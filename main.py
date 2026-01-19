from fastapi import FastAPI, HTTPException, status
from fastapi.middleware.cors import CORSMiddleware
import razorpay
from razorpay.errors import SignatureVerificationError

from config import settings
from models import OrderCreateRequest, PaymentVerifyRequest
from database import supabase

app = FastAPI(title="Institute Management Payment Service")

# CORS Configuration
# In production, replace allow_origins with specific domains
app.add_middleware(
    CORSMiddleware,
    allow_origins=[settings.FRONTEND_URL],  # Allow requests from Next.js
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Initialize Razorpay Client
# Note: This will raise an error if keys are missing/invalid when making calls
client = razorpay.Client(auth=(settings.RAZORPAY_KEY_ID, settings.RAZORPAY_KEY_SECRET))

@app.get("/")
def health_check():
    return {"status": "ok", "service": "Payment Backend"}

@app.post("/api/orders")
def create_order(request: OrderCreateRequest):
    """
    Create a Razorpay order.
    Amount should be in paise (100 paise = 1 INR).
    """
    try:
        data = {
            "amount": request.amount,
            "currency": request.currency,
            "receipt": request.receipt or "receipt_1",
            "payment_capture": 1 # Auto capture
        }
        if settings.MOCK_PAYMENTS:
            import time
            return {
                "id": f"order_mock_{int(time.time())}",
                "entity": "order",
                "amount": request.amount,
                "amount_paid": 0,
                "amount_due": request.amount,
                "currency": request.currency,
                "receipt": request.receipt or "receipt_1",
                "status": "created",
                "attempts": 0,
                "notes": [],
                "created_at": int(time.time())
            }

        order = client.order.create(data=data)
        return order
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/api/verify")
def verify_payment(request: PaymentVerifyRequest):
    """
    Verify the payment signature and upgrade the user's subscription.
    """
    try:
        # 1. Verify Signature
        params = {
            'razorpay_order_id': request.razorpay_order_id,
            'razorpay_payment_id': request.razorpay_payment_id,
            'razorpay_signature': request.razorpay_signature
        }
        
        # This will raise SignatureVerificationError if verification fails
        if not settings.MOCK_PAYMENTS:
            client.utility.verify_payment_signature(params)
        else:
             # In mock mode, just log or pass
             print("MOCK MODE: Skipping signature verification")
        
        # 2. Upgrade User (School)
        # Find the school associated with the user (admin)
        # Assuming user_id maps to a school_admin
        
        # Get admin profile
        admin_res = supabase.table("school_admins") \
            .select("school_id") \
            .eq("user_id", request.user_id) \
            .execute()
            
        if not admin_res.data:
             # Fallback: Check if user is platform admin (optional) or handle error
             # For now, simplistic approach:
             raise HTTPException(status_code=404, detail="User not found or not a school admin")
             
        school_id = admin_res.data[0]['school_id']
        
        # Update school subscription
        # Set to 'pro' (or whatever plan is purchased - logic can be improved)
        # Set status to 'active'
        update_res = supabase.table("schools") \
            .update({
                "subscription_plan": "pro",
                "subscription_status": "active"
                # "subscription_expires_at": ... # Todo: calculate expiry
            }) \
            .eq("id", school_id) \
            .execute()
            
        if not update_res.data:
            raise HTTPException(status_code=500, detail="Failed to update subscription")
            
        return {"status": "success", "message": "Payment verified and subscription updated"}

    except SignatureVerificationError:
        raise HTTPException(status_code=400, detail="Invalid Payment Signature")
    except HTTPException as he:
        raise he
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
