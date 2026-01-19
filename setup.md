# Setup Guide for Institute Management SaaS

## Quick Setup Checklist

### 1. Prerequisites ✅
- [ ] Node.js 18+ installed
- [ ] npm or yarn package manager
- [ ] Git installed
- [ ] Supabase account created

### 2. Project Setup ✅
- [ ] Clone the repository
- [ ] Run `npm install`
- [ ] Copy `.env.local.example` to `.env.local`

### 3. Supabase Configuration 🔧

#### Step 1: Create Supabase Project
1. Go to [supabase.com](https://supabase.com)
2. Click "Start your project"
3. Create a new organization (if needed)
4. Create a new project
5. Wait for the project to be ready

#### Step 2: Get API Keys
1. Go to Project Settings → API
2. Copy the following:
   - Project URL
   - `anon` `public` key
   - `service_role` `secret` key

#### Step 3: Update Environment Variables
Update your `.env.local` file:
```env
NEXT_PUBLIC_SUPABASE_URL=https://your-project-ref.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key
```

#### Step 4: Set Up Database Schema
1. Go to your Supabase project dashboard
2. Click on "SQL Editor" in the sidebar
3. Copy the entire content from `database/schema.sql`
4. Paste it in the SQL Editor
5. Click "Run" to execute the schema

#### Step 5: Verify Database Setup
Check that these tables were created:
- [ ] schools
- [ ] school_admins
- [ ] platform_admins
- [ ] students
- [ ] batches
- [ ] attendance
- [ ] announcements
- [ ] academic_content

### 4. Run the Application 🚀
```bash
npm run dev
```

Visit [http://localhost:3000](http://localhost:3000)

### 5. Create Your First Platform Admin (Optional)

If you want to access the platform admin dashboard:

1. Go to Supabase → Authentication → Users
2. Create a new user with your email
3. Go to SQL Editor and run:
```sql
INSERT INTO platform_admins (user_id, email, full_name) 
VALUES ('your-user-id-from-auth-users', 'your-email@example.com', 'Your Name');
```

### 6. Test the Application 🧪

#### Test School Registration:
1. Go to `/auth/signup`
2. Fill in institute details
3. Check email for verification
4. Sign in and access dashboard

#### Test Platform Admin:
1. Sign in with platform admin account
2. Go to `/platform-admin`
3. View schools and analytics

### 7. Deployment (Optional) 🌐

#### Deploy to Vercel:
1. Push code to GitHub
2. Connect repository to Vercel
3. Add environment variables in Vercel dashboard
4. Deploy

## Troubleshooting

### Common Issues:

**1. "Invalid API key" error**
- Check that your Supabase URL and keys are correct
- Ensure no extra spaces in environment variables

**2. "Table doesn't exist" error**
- Make sure you ran the database schema
- Check Supabase dashboard → Database → Tables

**3. Authentication not working**
- Verify Supabase Auth is enabled
- Check RLS policies are applied

**4. Can't access dashboard**
- Ensure user is created in `school_admins` table
- Check middleware is working correctly

### Getting Help:
- Check the console for error messages
- Verify Supabase logs in the dashboard
- Ensure all environment variables are set

## Next Steps

Once setup is complete:
1. Customize the branding and colors
2. Add your own content to landing pages
3. Configure email templates in Supabase
4. Set up custom domain
5. Add payment integration (Phase 5)

## Development Tips

- Use the browser dev tools to debug
- Check Supabase logs for database issues
- Test with multiple school accounts
- Verify RLS policies are working correctly

---

🎉 **Congratulations!** Your Institute Management SaaS is now ready to use!