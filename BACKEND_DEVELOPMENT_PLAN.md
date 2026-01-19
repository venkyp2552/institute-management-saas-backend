# Backend Development Plan: FastAPI & Razorpay Integration

This document outlines the step-by-step development plan for creating a Python FastAPI backend to handle Razorpay payment processing and linking it with the Next.js frontend.

## Overview
- **Backend Stack**: Python 3.x, FastAPI, Uvicorn
- **Integrations**: Razorpay, Supabase (for user data updates)
- **Frontend**: Next.js (Existing)

---

## Phase 1: FastAPI Backend Implementation

In this phase, we establish the foundation of the backend application.

### Step 1.1: Project Structure & Environment Setup
**Action**: Create the backend directory and set up the Python environment.

1.  **Create Directory**:
    ```bash
    mkdir backend
    cd backend
    ```
2.  **Initialize Virtual Environment**:
    ```bash
    python -m venv venv
    # Windows: venv\Scripts\activate
    # Mac/Linux: source venv/bin/activate
    ```
3.  **Install Dependencies**:
    Create a `requirements.txt` file:
    ```text
    fastapi
    uvicorn[standard]
    razorpay
    python-dotenv
    pydantic
    httpx
    supabase # if direct DB access is needed
    ```
    Run `pip install -r requirements.txt`.

### Step 1.2: Core Configuration
**Action**: Configure environment variables and main app settings.

1.  **Create `.env` file**:
    ```env
    # API Keys
    RAZORPAY_KEY_ID=your_test_key_id
    RAZORPAY_KEY_SECRET=your_test_key_secret

    # Configuration
    FRONTEND_URL=http://localhost:3000
    
    # Database (Supabase) - for upgrading users
    SUPABASE_URL=your_supabase_url
    SUPABASE_SERVICE_KEY=your_service_role_key
    ```
2.  **Create `config.py`**:
    -   Use `pydantic-settings` or `os.getenv` to load these safely.

### Step 1.3: Basic Server & CORS
**Action**: Create `main.py` with the FastAPI app.

1.  **Initialize App**:
    ```python
    from fastapi import FastAPI
    from fastapi.middleware.cors import CORSMiddleware
    from config import FRONTEND_URL

    app = FastAPI(title="Payment Service")

    # Security: Allow only trusted origins (Frontend)
    app.add_middleware(
        CORSMiddleware,
        allow_origins=[FRONTEND_URL],
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

    @app.get("/")
    def health_check():
        return {"status": "ok", "service": "Payment Backend"}
    ```
2.  **Run Server**: `uvicorn main:app --reload`

---

## Phase 2: Razorpay Integration & Frontend Connection (Next.js)

This phase implements the payment logic and connects it to the user interface.

### Step 2.1: Payment Models (Pydantic)
**Action**: Define data structures for requests.

Create `models.py`:
-   **OrderCreateRequest**: `amount` (int), `currency` (str), `receipt` (str, optional).
-   **PaymentVerifyRequest**: `razorpay_order_id`, `razorpay_payment_id`, `razorpay_signature`, `user_id` (to identify who paid).

### Step 2.2: Razorpay API Implementation (Backend)
**Action**: Create routes in `main.py` (or a dedicated `routes/payments.py`).

1.  **Initialize Razorpay Client**:
    ```python
    import razorpay
    client = razorpay.Client(auth=(settings.RAZORPAY_KEY_ID, settings.RAZORPAY_KEY_SECRET))
    ```

2.  **Endpoint 1: Create Order (`POST /api/orders`)**
    -   **Logic**:
        -   Receive amount (ensure it's in smallest currency unit, e.g., paise for INR).
        -   Call `client.order.create(data)`.
        -   Return `order_id` and formatted amount to frontend.
    -   **Validation**: Ensure amount is positive and currency is supported.

3.  **Endpoint 2: Verify Payment (`POST /api/verify`)**
    -   **Logic**:
        -   Receive `razorpay_order_id`, `razorpay_payment_id`, `razorpay_signature`.
        -   **Verify Signature**:
            ```python
            client.utility.verify_payment_signature({
                'razorpay_order_id': ...,
                'razorpay_payment_id': ...,
                'razorpay_signature': ...
            })
            ```
        -   **Post-Payment Logic (User Upgrade)**:
            -   If verification passes, use `supabase-py` (with Service Role Key) to update the `users` table or `subscriptions` table.
            -   Example: Set `is_pro = true` or create a new subscription record.
            -   **Critical**: Do NOT trust frontend for this update. Only update DB after backend verifies signature.

### Step 2.3: Frontend Integration (Next.js)
**Action**: Update Next.js app to communicate with FastAPI.

1.  **Script Loading**:
    -   Ensure Razorpay checkout script is loaded in `create-next-app` (usually via `next/script` with `src="https://checkout.razorpay.com/v1/checkout.js"`).

2.  **Payment Function (`handlePayment`)**:
    -   **Sequence**:
        1.  User clicks "Upgrade".
        2.  `await fetch('http://localhost:8000/api/orders', ...)`
        3.  Receive `order_id`.
        4.  Initialize Razorpay options:
            ```javascript
            const options = {
                key: process.env.NEXT_PUBLIC_RAZORPAY_KEY_ID, // Public key only
                amount: data.amount,
                currency: data.currency,
                order_id: data.order_id,
                handler: async function (response) {
                    // Call backend verify
                    const result = await fetch('http://localhost:8000/api/verify', {
                        method: 'POST',
                        body: JSON.stringify({
                            razorpay_payment_id: response.razorpay_payment_id,
                            razorpay_order_id: response.razorpay_order_id,
                            razorpay_signature: response.razorpay_signature,
                            user_id: currentUser.id
                        })
                    });
                    if (result.ok) alert("Upgrade Successful!");
                }
            };
            const rzp = new window.Razorpay(options);
            rzp.open();
            ```

---

## Phase 3: Production Readiness & Deployment

### Step 3.1: Security & Best Practices
1.  **Environment Variables**:
    -   Ensure `.env` is in `.gitignore`.
    -   Never commit secret keys (Secret Key, Database Service Key) to Git.
2.  **Input Validation**:
    -   Strictly type-check all inputs in FastAPI using Pydantic.
    -   Sanitize amounts on the backend (e.g., fetch price from DB instead of trusting frontend input for amount).
3.  **CORS**:
    -   In production, set `allow_origins` to your specific production domain (e.g., `https://my-saas-app.com`), not `*`.

### Step 3.2: Production Environment Config
1.  **Razorpay Keys**:
    -   Switch from **Test Mode** to **Live Mode** in Razorpay Dashboard.
    -   Update `RAZORPAY_KEY_ID` and `RAZORPAY_KEY_SECRET` in the production environment variables.
2.  **Web Server**:
    -   Use `gunicorn` with `uvicorn` workers for production performance.
    -   Command: `gunicorn -w 4 -k uvicorn.workers.UvicornWorker main:app`

### Step 3.3: Deployment Handover
-   **Docker**: Create a `Dockerfile` for the backend.
-   **Hosting**:
    -   Deploy Next.js to Vercel.
    -   Deploy Python Backend to a container service (Render, Railway, AWS ECS, or DigitalOcean).
    -   Update `FRONTEND_URL` in Backend Env and `NEXT_PUBLIC_BACKEND_URL` in Frontend Env to point to live URLs.

---

## Rules to Follow

1.  **Verification is Mandatory**: Never mark an order as "paid" without backend signature verification.
2.  **Secure the Service Role**: The Supabase Service Role key (used to upgrade users) must ONLY exist in the Backend `.env`. Never expose it to the Frontend.
3.  **Idempotency**: Handle cases where webhooks might send the same payment event twice (if using webhooks) to avoid double-crediting.
4.  **Error Handling**: Gracefully handle network failures during the verification step (e.g., Razorpay charges user, but backend verification fails - have a manual check process or retry mechanism).
