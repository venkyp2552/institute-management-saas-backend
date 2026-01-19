# 🧪 Forgot Password - Testing & Verification Guide

## ✅ Fixed Issues

1. **Auth Callback Integration** - Updated to use proper Supabase callback flow
2. **Token Validation** - Enhanced to handle URL hash parameters
3. **Redirect URLs** - Configured to work with Next.js auth callback

---

## 🔧 Configuration Steps

### Step 1: Configure Supabase Redirect URLs

1. Go to your Supabase project: https://supabase.com/dashboard
2. Navigate to **Authentication** → **URL Configuration**
3. Add these redirect URLs:

```
http://localhost:3000/auth/callback
http://localhost:3000/auth/reset-password
```

### Step 2: Update Email Template (Optional but Recommended)

1. Go to **Authentication** → **Email Templates**
2. Select **Reset Password** template
3. The default template should work, but you can customize it

---

## 🧪 Testing Instructions

### Test 1: Request Password Reset

1. **Start the server** (if not running):
   ```bash
   npm run dev
   ```

2. **Navigate to login page**:
   ```
   http://localhost:3000/auth/login
   ```

3. **Click "Forgot your password?"** link

4. **Enter a test email**:
   - Use an email you have access to
   - Or create a test user first at `/auth/signup`

5. **Click "Send Reset Link"**

6. **Verify success screen appears**:
   - Should show "Check Your Email" message
   - Should display the email address you entered

### Test 2: Check Email

1. **Open your email inbox**
2. **Look for email from Supabase**
   - Subject: "Reset Your Password"
   - From: noreply@mail.app.supabase.io (or your custom domain)
3. **Check spam folder** if not in inbox

### Test 3: Reset Password

1. **Click the reset link** in the email
2. **Should redirect to**: `http://localhost:3000/auth/reset-password`
3. **Enter new password**:
   - Must be at least 6 characters
   - Enter same password in both fields
4. **Click "Reset Password"**
5. **Verify success screen**:
   - Should show "Password Reset Successful!"
   - Should auto-redirect to login after 2 seconds

### Test 4: Login with New Password

1. **Navigate to login page** (or wait for auto-redirect)
2. **Enter your email**
3. **Enter your NEW password**
4. **Click "Sign In to Dashboard"**
5. **Should successfully login** and redirect to dashboard

---

## 🐛 Troubleshooting

### Issue: "Invalid or expired reset link"

**Possible Causes:**
- Link expired (valid for 1 hour)
- Link already used
- Redirect URLs not configured in Supabase

**Solution:**
1. Check Supabase redirect URLs are configured
2. Request a new reset link
3. Use the link within 1 hour

### Issue: Email not received

**Possible Causes:**
- Email in spam folder
- Email not registered in system
- Supabase email service issue

**Solution:**
1. Check spam/junk folder
2. Verify email is registered (check Supabase Auth → Users)
3. Check Supabase logs (Authentication → Logs)
4. Try with a different email provider

### Issue: "Passwords do not match"

**Solution:**
- Ensure both password fields have identical values
- Check for extra spaces
- Use copy-paste to ensure they match

### Issue: Can't login after reset

**Solution:**
1. Clear browser cache and cookies
2. Try incognito/private browsing
3. Verify password was actually updated in Supabase (Auth → Users)
4. Try resetting password again

---

## 📊 Verification Checklist

Use this checklist to verify everything works:

- [ ] Server is running on http://localhost:3000
- [ ] Can access login page
- [ ] "Forgot your password?" link is visible
- [ ] Clicking link goes to forgot password page
- [ ] Can enter email address
- [ ] Submit button works
- [ ] Success screen appears after submit
- [ ] Email is received (check inbox and spam)
- [ ] Email contains reset link
- [ ] Clicking reset link opens reset password page
- [ ] Can enter new password
- [ ] Password confirmation works
- [ ] Show/hide password toggles work
- [ ] Submit button works
- [ ] Success screen appears
- [ ] Auto-redirects to login
- [ ] Can login with new password
- [ ] Successfully accesses dashboard

---

## 🔍 Debugging Tips

### Check Supabase Logs

1. Go to Supabase Dashboard
2. Navigate to **Authentication** → **Logs**
3. Look for:
   - Password reset requests
   - Email sent confirmations
   - Token validation attempts
   - Password update events

### Check Browser Console

1. Open browser DevTools (F12)
2. Go to Console tab
3. Look for:
   - JavaScript errors
   - Network request failures
   - Supabase client errors

### Check Network Tab

1. Open browser DevTools (F12)
2. Go to Network tab
3. Filter by "Fetch/XHR"
4. Look for:
   - `/auth/v1/recover` - Password reset request
   - `/auth/v1/user` - Password update request
   - Check response status codes

---

## 📝 Code Files

### Main Files:

1. **Forgot Password Page**
   ```
   src/app/auth/forgot-password/page.tsx
   ```
   - Handles password reset request
   - Sends email via Supabase
   - Shows success confirmation

2. **Reset Password Page**
   ```
   src/app/auth/reset-password/page.tsx
   ```
   - Validates reset token
   - Allows setting new password
   - Updates password in Supabase

3. **Auth Callback**
   ```
   src/app/auth/callback/route.ts
   ```
   - Handles Supabase auth redirects
   - Exchanges code for session

4. **Login Page**
   ```
   src/app/auth/login/page.tsx
   ```
   - Contains "Forgot password?" link
   - Handles user login

---

## 🎯 Expected Flow

```
User Flow:
1. Login Page → Click "Forgot password?"
2. Forgot Password Page → Enter email → Submit
3. Success Screen → "Check your email"
4. Email Inbox → Click reset link
5. Reset Password Page → Enter new password → Submit
6. Success Screen → Auto-redirect
7. Login Page → Login with new password
8. Dashboard → Successfully logged in

Technical Flow:
1. POST /auth/v1/recover (email)
2. Supabase sends email with token
3. User clicks link with token
4. GET /auth/callback?code=xxx&next=/auth/reset-password
5. Exchange code for session
6. Redirect to /auth/reset-password
7. PUT /auth/v1/user (new password)
8. Redirect to /auth/login
9. POST /auth/v1/token (login)
10. Redirect to /dashboard
```

---

## 🚀 Production Deployment

Before deploying to production:

1. **Update Supabase URLs**:
   - Add production domain to redirect URLs
   - Update Site URL to production domain

2. **Configure Custom SMTP** (recommended):
   - Set up SendGrid, Mailgun, or similar
   - Configure in Supabase → Project Settings → Auth

3. **Test in Production**:
   - Test complete flow with production URLs
   - Verify emails are delivered
   - Check all redirects work correctly

4. **Monitor**:
   - Set up error tracking (Sentry, etc.)
   - Monitor Supabase logs
   - Track email delivery rates

---

## ✨ Features Implemented

- ✅ Request password reset via email
- ✅ Secure token-based authentication
- ✅ Email delivery via Supabase
- ✅ Token validation and expiration
- ✅ Password strength requirements
- ✅ Password confirmation matching
- ✅ Show/hide password toggles
- ✅ Loading states and animations
- ✅ Success/error notifications
- ✅ Toast messages
- ✅ Auto-redirect after success
- ✅ Expired link handling
- ✅ Mobile responsive design
- ✅ Accessibility compliant

---

## 📞 Need Help?

If you encounter issues:

1. Check this testing guide
2. Review `EMAIL_SETUP.md` for configuration
3. Check `PASSWORD_RESET_FLOW.md` for technical details
4. Review Supabase documentation: https://supabase.com/docs/guides/auth
5. Check Supabase logs for errors

---

**Status**: ✅ Implementation Complete & Ready for Testing

**Server**: http://localhost:3000  
**Test URL**: http://localhost:3000/auth/forgot-password
