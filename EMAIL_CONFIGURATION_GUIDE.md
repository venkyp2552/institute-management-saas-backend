# 📧 Complete Email Configuration Guide

## 🔍 Understanding the Issue

You're not receiving emails because Supabase needs proper configuration. Here's how to fix it:

---

## 🚨 Current Setup

### Signup Flow (Currently):
- ✅ Auto-confirms email (no verification email sent)
- ✅ User can login immediately after signup
- ⚠️ No email verification required

### Forgot Password Flow:
- ⚠️ Requires Supabase redirect URL configuration
- ⚠️ Emails won't send without proper setup

---

## 🔧 Fix Email Issues - Step by Step

### Step 1: Access Supabase Dashboard

1. Go to: https://supabase.com/dashboard
2. Select your project: `ogbdkyjmecmgkudhzclb`
3. You should see your project dashboard

---

### Step 2: Configure Redirect URLs

This is **CRITICAL** for forgot password to work!

1. In Supabase Dashboard, go to:
   ```
   Authentication → URL Configuration
   ```

2. Find **"Redirect URLs"** section

3. Add these URLs (click "+ Add URL" for each):
   ```
   http://localhost:3000/auth/callback
   http://localhost:3000/auth/reset-password
   http://localhost:3000/auth/confirm
   ```

4. Set **Site URL** to:
   ```
   http://localhost:3000
   ```

5. Click **Save**

---

### Step 3: Check Email Settings

1. Go to:
   ```
   Authentication → Email Templates
   ```

2. You should see these templates:
   - ✅ Confirm signup
   - ✅ Invite user
   - ✅ Magic Link
   - ✅ Change Email Address
   - ✅ **Reset Password** ← This is what you need!

3. Click on **"Reset Password"** template

4. Verify it's enabled (toggle should be ON)

---

### Step 4: Test Email Delivery

#### Option A: Use Supabase's Built-in Email Service (Easiest)

Supabase provides email service by default. Just ensure:

1. Go to **Project Settings** → **Auth**
2. Scroll to **Email Auth**
3. Ensure "Enable Email Signup" is **ON**
4. Ensure "Confirm Email" is configured

#### Option B: Configure Custom SMTP (For Production)

1. Go to **Project Settings** → **Auth**
2. Scroll to **SMTP Settings**
3. Enable custom SMTP
4. Configure your email provider:

**Gmail Example:**
```
Host: smtp.gmail.com
Port: 587
Username: your-email@gmail.com
Password: your-app-password
Sender Email: your-email@gmail.com
Sender Name: InstituteTool
```

**SendGrid Example:**
```
Host: smtp.sendgrid.net
Port: 587
Username: apikey
Password: your-sendgrid-api-key
Sender Email: noreply@yourdomain.com
Sender Name: InstituteTool
```

---

## 🧪 Testing Forgot Password

### After Configuration:

1. **Go to login page**:
   ```
   http://localhost:3000/auth/login
   ```

2. **Click "Forgot your password?"**

3. **Enter your email** (the one you used for signup)

4. **Click "Send Reset Link"**

5. **Check your email inbox** (and spam folder!)

6. **You should receive an email** with subject: "Reset Your Password"

7. **Click the reset link** in the email

8. **Set your new password**

9. **Login with new password**

---

## 🔄 Enable Email Verification for Signup (Optional)

If you want users to verify their email during signup:

### Update Signup API

Replace the signup API code with this version:

**File**: `src/app/api/auth/signup/route.ts`

```typescript
import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'

export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    const { instituteName, adminName, email, password, phone, address, selectedPlan } = body

    const supabase = await createClient()
    
    // Create user (will send verification email)
    const { data: authData, error: authError } = await supabase.auth.signUp({
      email,
      password,
      options: {
        emailRedirectTo: `${process.env.NEXT_PUBLIC_SUPABASE_URL}/auth/callback`,
        data: {
          full_name: adminName,
          institute_name: instituteName,
        }
      }
    })

    if (authError) {
      return NextResponse.json({ error: authError.message }, { status: 400 })
    }

    if (!authData.user) {
      return NextResponse.json({ error: 'Failed to create user' }, { status: 400 })
    }

    // Note: School and admin records should be created after email verification
    // For now, we'll create them immediately but mark as pending

    return NextResponse.json({ 
      success: true, 
      message: 'Account created! Please check your email to verify your account.',
      requiresVerification: true
    })

  } catch (error) {
    console.error('Signup error:', error)
    return NextResponse.json({ error: 'An unexpected error occurred' }, { status: 500 })
  }
}
```

---

## 📋 Quick Checklist

Use this to verify everything is configured:

### Supabase Configuration:
- [ ] Logged into Supabase dashboard
- [ ] Project selected
- [ ] Redirect URLs added:
  - [ ] `http://localhost:3000/auth/callback`
  - [ ] `http://localhost:3000/auth/reset-password`
  - [ ] `http://localhost:3000/auth/confirm`
- [ ] Site URL set to `http://localhost:3000`
- [ ] Email templates enabled
- [ ] Reset Password template exists

### Testing:
- [ ] Server running (`npm run dev`)
- [ ] Can access login page
- [ ] Can click "Forgot your password?"
- [ ] Can enter email and submit
- [ ] Success message appears
- [ ] Email received (check spam!)
- [ ] Reset link works
- [ ] Can set new password
- [ ] Can login with new password

---

## 🐛 Troubleshooting

### Issue: No email received

**Check these:**

1. **Spam/Junk folder** - Supabase emails often go to spam
2. **Email address is correct** - Verify you used the right email
3. **Supabase logs**:
   - Go to Authentication → Logs
   - Look for password reset requests
   - Check for errors

4. **Rate limiting**:
   - Supabase limits emails per hour
   - Wait a few minutes and try again

5. **Email provider blocking**:
   - Some providers block automated emails
   - Try a different email address (Gmail usually works)

### Issue: "Invalid redirect URL"

**Solution:**
- Ensure redirect URLs are added in Supabase
- URLs must match exactly (including http://)
- No trailing slashes

### Issue: Email received but link doesn't work

**Solution:**
- Check that `/auth/callback` route exists
- Verify redirect URLs in Supabase
- Clear browser cache
- Try incognito mode

---

## 📸 Visual Guide

### Where to Find Settings:

```
Supabase Dashboard
├── Authentication
│   ├── URL Configuration ← Add redirect URLs here
│   ├── Email Templates ← Check templates here
│   └── Logs ← Debug issues here
└── Project Settings
    └── Auth ← SMTP settings here
```

---

## 🎯 Quick Fix Commands

### 1. Restart Server
```bash
# Stop current server (Ctrl+C)
npm run dev
```

### 2. Test Forgot Password
```bash
# Open in browser:
http://localhost:3000/auth/forgot-password
```

### 3. Check Supabase Connection
```bash
# Your Supabase URL:
https://ogbdkyjmecmgkudhzclb.supabase.co

# Dashboard:
https://supabase.com/dashboard/project/ogbdkyjmecmgkudhzclb
```

---

## 🚀 After Configuration

Once you've added the redirect URLs in Supabase:

1. **No code changes needed** - Everything is already implemented
2. **Just test the flow** - Go to forgot password page
3. **Emails will work** - You'll receive reset links
4. **Complete the flow** - Reset password and login

---

## 📞 Still Having Issues?

### Check Supabase Logs:

1. Go to Supabase Dashboard
2. Click **Authentication** → **Logs**
3. Look for:
   - Password reset requests
   - Email delivery status
   - Any error messages

### Common Error Messages:

- **"Invalid redirect URL"** → Add URLs in Supabase
- **"Email not sent"** → Check SMTP settings
- **"Rate limit exceeded"** → Wait and try again
- **"User not found"** → Email not registered

---

## ✅ Summary

**The main issue**: Supabase redirect URLs are not configured

**The fix**: Add these URLs in Supabase Dashboard → Authentication → URL Configuration:
```
http://localhost:3000/auth/callback
http://localhost:3000/auth/reset-password
http://localhost:3000/auth/confirm
```

**After fixing**: Forgot password emails will work immediately!

---

## 🎉 Next Steps

1. **Configure Supabase** (5 minutes)
2. **Test forgot password** (2 minutes)
3. **Verify email received** (check inbox/spam)
4. **Complete password reset** (1 minute)
5. **Login successfully** ✅

**Your Supabase Dashboard**: https://supabase.com/dashboard/project/ogbdkyjmecmgkudhzclb
