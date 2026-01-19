
# Deployment Guide: Institute Management SaaS

## 1. Vercel Configuration (Important)
This project is configured to deploy both the Next.js Frontend and the Python Backend (FastAPI) on Vercel.

### Files Created/Modified:
- `vercel.json`: Configures rewrites to route `/api/orders`, `/api/verify`, and docs to the Python backend.
- `api/index.py`: Entrypoint for Vercel Serverless Functions.
- `requirements.txt`: Copied to root for Vercel to install Python dependencies.

## 2. Environment Variables
You MUST set the following Environment Variables in your Vercel Project Settings:

### Frontend Variables:
- `NEXT_PUBLIC_SUPABASE_URL`: Your Supabase Project URL.
- `NEXT_PUBLIC_SUPABASE_ANON_KEY`: Your Supabase Anon Key.

### Backend Variables:
- `SUPABASE_URL`: Same as above.
- `SUPABASE_SERVICE_KEY`: **CRITICAL**. This is your Supabase SERVICE ROLE KEY (not Anon key). Start with `ey...` and is usually longer. You can find it in Supabase Dashboard -> Project Settings -> API.
- `FRONTEND_URL`: Your Vercel deployment URL (e.g., `https://your-project.vercel.app`). For now, you can set it to `*` or update it after deployment.
- `RAZORPAY_KEY_ID`: Your Razorpay Key ID (or `rzp_test_mock` if using mock).
- `RAZORPAY_KEY_SECRET`: Your Razorpay Secret (or `secret_mock` if using mock).
- `MOCK_PAYMENTS`: `true` (Set to `false` when you have real credentials).

## 3. Deployment Steps
1. Push this code to GitHub/GitLab/Bitbucket.
2. Import the project in Vercel.
3. Add the Environment Variables listed above.
4. Deploy.

## 4. Verification
- Frontend should load at `https://your-project.vercel.app`.
- Backend health check should be available at `https://your-project.vercel.app/api/docs` (if you mapped it) or via API calls.
- Payment flow (Mock) can be tested by going to Dashboard -> Profile -> Upgrade to Pro.

## Local Development
- Run `npm run dev` to start Next.js (port 3000).
- Run `uvicorn backend.main:app --reload` to start Python (port 8000).
- `next.config.ts` is configured to proxy API calls to localhost:8000.
