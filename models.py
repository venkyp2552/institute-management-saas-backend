from pydantic import BaseModel
from typing import Optional

class OrderCreateRequest(BaseModel):
    amount: int  # Amount in paise (e.g., 10000 = ₹100)
    currency: str = "INR"
    receipt: Optional[str] = None

class PaymentVerifyRequest(BaseModel):
    razorpay_order_id: str
    razorpay_payment_id: str
    razorpay_signature: str
    user_id: str
