# Phase 5: Finance & Payment Integration

## 1. Goal & Objectives
**Goal:** Implement the monetization layer to handle School Subscriptions and ensure the platform operates as a sustainable SaaS.
**Focus:** Payment Gateway Integration (FastAPI), Subscription Management, and Access Control.

## 2. Features & Components
### 2.1 Payment Gateway Integration (FastAPI)
- **Service:** Create a robust Payment Service in FastAPI.
- **Provider:** Stripe / Razorpay (or a Mock Provider for MVP).
- **Flow:**
    1. **Checkout:** School Admin selects a plan on the Pricing Page (from **Phase 0**).
    2. **Initiate:** Frontend calls FastAPI `/payments/create-session` with the `plan_id`.
    3. **Process:** FastAPI talks to Gateway, returns Checkout URL.
    4. **Webhook:** Gateway calls FastAPI `/payments/webhook` on success.
    5. **Update:** FastAPI updates Supabase `schools` table (`subscription_status = 'active'`).

### 2.2 Subscription Management
- **Database:** Track `plan_type` (Basic/Pro), `start_date`, `end_date`.
- **Logic:**
    - Cron Job (or check on login) to expire subscriptions.
    - **Middleware:** If `subscription_status != 'active'`, redirect to `/billing`.

### 2.3 Invoice Generation (Optional/Future)
- **FastAPI:** Generate PDF Invoices using a Python library (e.g., `reportlab` or `weasyprint`) and email to the School Admin.

## 3. Technical Implementation Details
### Backend (FastAPI)
- **Endpoints:**
    - `POST /payments/checkout`: Create session.
    - `POST /payments/webhook`: Handle async status updates.
- **Security:** Verify Webhook signatures to prevent fraud.

### Database (Supabase)
- **Columns:** Add `subscription_status`, `stripe_customer_id`, `current_period_end` to `schools` table.
- **RLS:** Ensure Payment Webhook (Service Role) can update these sensitive fields, but Admins cannot.

## 4. Deliverables & Acceptance Criteria
- [ ] Checkout flow works (redirects to Gateway/Mock).
- [ ] Webhook listener correctly updates School status in Supabase.
- [ ] Inactive schools effectively blocked from Dashboard.
- [ ] School Admin can view their "Current Plan" status.

## 5. Connection to Next Phase
Phase 5 makes the SaaS "sellable". Phase 6 focuses on **Quality Assurance**, **Optimization**, and the final **Launch**.
