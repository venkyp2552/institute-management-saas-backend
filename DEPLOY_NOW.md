
# 🚀 Deployment Instructions

Since I cannot directly access your GitHub or Vercel accounts to run commands on your behalf, I have prepared everything locally. You just need to run the following commands in your terminal to deploy.

## Prerequisite
Ensure you have the Vercel CLI installed. If not, install it:
```bash
npm install -g vercel
```

## Option 1: Deploy Directly from Command Line (Easiest)
Run the following command while logged into your Vercel account:

```bash
vercel deploy --prod
```
- It will ask you to log in (if not already).
- Hit `Enter` to confirm the default settings for most questions.
- **IMPORTANT**: When asked about the "Build Command", "Output Directory", etc., simpler usually works better for Next.js, but since we have a Python API, Vercel should auto-detect it.
- **Environment Variables**: You can add them in the dashboard later or during the CLI flow if prompted.

## Option 2: Deploy via GitHub (Recommended for CI/CD)
1. create a new repository on GitHub (e.g., `institute-management`).
2. Push this code:
```bash
git remote add origin https://github.com/venkyp2552/YOUR_REPO_NAME.git
git branch -M main
git push -u origin main
```
3. Go to [Vercel Dashboard](https://vercel.com/new).
4. Import the repository.
5. Add the Environment Variables (Copy them from your `.env.local` and `backend/.env`).

## 🔑 Environment Variables to Set in Vercel
You MUST set these in the Vercel Project Settings for the app to work:

**Frontend**:
- `NEXT_PUBLIC_SUPABASE_URL`: `https://ogbdkyjmecmgkudhzclb.supabase.co`
- `NEXT_PUBLIC_SUPABASE_ANON_KEY`: (Your long Anon key starting with `ey...`)

**Backend**:
- `SUPABASE_URL`: `https://ogbdkyjmecmgkudhzclb.supabase.co`
- `SUPABASE_SERVICE_KEY`: (Your SERVICE_ROLE key - **Critical** for backend)
- `FRONTEND_URL`: `https://your-vercel-app-url.vercel.app` (Update this after first deploy)
- `RAZORPAY_KEY_ID`: `rzp_test_mock`
- `RAZORPAY_KEY_SECRET`: `secret_mock`
- `MOCK_PAYMENTS`: `true`

## ✅ Verification
Once deployed, your app URL will be provided by Vercel. 
- Go to `/api/docs` on that URL to verify the Python backend is running the docs.
- Go to `Dashboard > Profile` and click "Upgrade to Pro" to test the integration.
