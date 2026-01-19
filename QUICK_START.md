# 🚀 Quick Start Guide - Institute Management SaaS

## ✅ Current Status

Your project is now **running successfully**!

- **Development Server**: http://localhost:3000
- **Network Access**: http://172.17.80.1:3000
- **Dependencies**: Installed ✓
- **Environment File**: Created ✓

---

## ⚠️ Important: Configure Supabase

The application is running but **requires Supabase configuration** to work properly.

### Step 1: Create Supabase Project

1. Go to [supabase.com](https://supabase.com) and sign in
2. Click "New Project"
3. Fill in project details:
   - Name: `institute-management-saas`
   - Database Password: (create a strong password)
   - Region: (choose closest to you)
4. Wait 2-3 minutes for project setup

### Step 2: Get Your API Keys

1. In your Supabase project, go to **Settings** → **API**
2. Copy these three values:
   - **Project URL** (looks like: `https://xxxxx.supabase.co`)
   - **anon public** key (under "Project API keys")
   - **service_role secret** key (under "Project API keys")

### Step 3: Update Environment Variables

Open the `.env.local` file in your project and replace the placeholder values:

```env
NEXT_PUBLIC_SUPABASE_URL=https://your-project-ref.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

### Step 4: Set Up Database Schema

1. In Supabase dashboard, click **SQL Editor** (left sidebar)
2. Click "New Query"
3. Open the file `database/schema.sql` from your project
4. Copy the entire content
5. Paste it into the SQL Editor
6. Click **Run** (or press Ctrl+Enter)
7. Wait for "Success. No rows returned" message

This creates all necessary tables:
- schools
- school_admins
- platform_admins
- students
- batches
- attendance
- announcements
- academic_content

### Step 5: Restart Development Server

After updating `.env.local`:

1. Stop the current server (Ctrl+C in terminal)
2. Run: `npm run dev`
3. Visit: http://localhost:3000

---

## 🎯 What You Can Do Now

### 1. View the Landing Page
- Open http://localhost:3000
- Explore the public website

### 2. Sign Up as a School
- Go to http://localhost:3000/auth/signup
- Fill in your institute details
- Create an account

### 3. Access School Dashboard
- After signup and email verification
- Login at http://localhost:3000/auth/login
- Access your dashboard at http://localhost:3000/dashboard

### 4. Create Platform Admin (Optional)

To access the platform admin dashboard:

1. First, create a user account through the signup page
2. Go to Supabase → **Authentication** → **Users**
3. Copy your user's UUID
4. Go to **SQL Editor** and run:

```sql
INSERT INTO platform_admins (user_id, email, full_name) 
VALUES ('your-user-uuid-here', 'your-email@example.com', 'Your Name');
```

5. Login and visit http://localhost:3000/platform-admin

---

## 📁 Project Structure

```
src/
├── app/
│   ├── (public)/          # Landing pages (home, features, pricing)
│   ├── auth/              # Login, signup, password reset
│   ├── dashboard/         # School admin dashboard
│   └── platform-admin/    # Platform admin dashboard
├── components/
│   ├── dashboard/         # Dashboard components
│   ├── platform-admin/    # Platform admin components
│   └── ui/                # Reusable UI components
└── lib/
    └── supabase/          # Supabase client configuration
```

---

## 🔧 Available Commands

```bash
npm run dev      # Start development server
npm run build    # Build for production
npm run start    # Start production server
npm run lint     # Run ESLint
```

---

## 🎨 Key Features

### School Admin Dashboard
- ✅ Student Management
- ✅ Batch/Class Management
- ✅ Attendance Tracking
- ✅ Announcements
- ✅ Academic Content/Assignments
- ✅ Reports & Analytics

### Platform Admin Dashboard
- ✅ Multi-school Management
- ✅ School Activation/Deactivation
- ✅ Platform Analytics
- ✅ Subscription Management

---

## 🐛 Troubleshooting

### "Invalid API key" Error
- Verify your Supabase URL and keys in `.env.local`
- Ensure no extra spaces or quotes
- Restart the dev server after changes

### "Table doesn't exist" Error
- Make sure you ran the database schema in Supabase SQL Editor
- Check that all tables are created in Supabase → Database → Tables

### Can't Access Dashboard
- Verify email is confirmed in Supabase → Authentication → Users
- Check that user exists in `school_admins` table
- Clear browser cache and cookies

### Port Already in Use
- Stop other processes using port 3000
- Or change port: `npm run dev -- -p 3001`

---

## 📚 Next Steps

1. **Customize Branding**
   - Update colors in `src/app/globals.css`
   - Replace logo in `public/logo.svg`
   - Edit content in landing pages

2. **Test Multi-Tenancy**
   - Create multiple school accounts
   - Verify data isolation
   - Test different user roles

3. **Deploy to Production**
   - See `DEPLOYMENT.md` for Vercel deployment guide
   - Set up production Supabase project
   - Configure environment variables

4. **Add Payment Integration**
   - Integrate Stripe or Razorpay (Phase 5)
   - Set up subscription plans
   - Handle payment webhooks

---

## 📞 Support

- Check `README.md` for detailed documentation
- Review `setup.md` for step-by-step setup
- See `prd.md` for product requirements
- Check `project_blueprint/` for development phases

---

**🎉 Congratulations! Your Institute Management SaaS is ready to use!**

Visit http://localhost:3000 to get started.
