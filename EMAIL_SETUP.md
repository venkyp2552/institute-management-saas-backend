# 📧 Email Configuration Guide

## Password Reset Email Setup

The forgot password functionality is now fully implemented! Here's how to configure it properly in Supabase.

---

## ✅ What's Implemented

1. **Forgot Password Page** (`/auth/forgot-password`)
   - User enters their email
   - Sends password reset link via Supabase
   - Shows success confirmation

2. **Reset Password Page** (`/auth/reset-password`)
   - User clicks link from email
   - Validates reset token
   - Allows setting new password
   - Redirects to login on success

3. **Login Page Integration**
   - "Forgot your password?" link added
   - Seamless navigation flow

---

## 🔧 Supabase Email Configuration

### Step 1: Configure Email Templates

1. Go to your Supabase project dashboard
2. Navigate to **Authentication** → **Email Templates**
3. Find the **Reset Password** template

### Step 2: Update Reset Password Template

Replace the default template with this:

```html
<h2>Reset Your Password</h2>

<p>Hi there,</p>

<p>We received a request to reset your password for your InstituteTool account.</p>

<p>Click the button below to reset your password:</p>

<p>
  <a href="{{ .SiteURL }}/auth/reset-password?token={{ .Token }}&type=recovery" 
     style="display: inline-block; padding: 12px 24px; background-color: #4F46E5; color: white; text-decoration: none; border-radius: 6px; font-weight: 600;">
    Reset Password
  </a>
</p>

<p>Or copy and paste this link into your browser:</p>
<p>{{ .SiteURL }}/auth/reset-password?token={{ .Token }}&type=recovery</p>

<p>This link will expire in 1 hour for security reasons.</p>

<p>If you didn't request a password reset, you can safely ignore this email.</p>

<p>Thanks,<br>The InstituteTool Team</p>
```

### Step 3: Configure Site URL

1. Go to **Authentication** → **URL Configuration**
2. Set **Site URL** to:
   - Development: `http://localhost:3000`
   - Production: `https://yourdomain.com`

3. Add **Redirect URLs**:
   - `http://localhost:3000/auth/reset-password`
   - `https://yourdomain.com/auth/reset-password` (for production)

### Step 4: Email Settings (Optional)

By default, Supabase uses their email service. For production, you can configure your own SMTP:

1. Go to **Project Settings** → **Auth**
2. Scroll to **SMTP Settings**
3. Configure your email provider (Gmail, SendGrid, etc.)

---

## 🧪 Testing the Flow

### Test Forgot Password:

1. Go to `http://localhost:3000/auth/login`
2. Click "Forgot your password?"
3. Enter a registered email address
4. Click "Send Reset Link"
5. Check your email inbox (and spam folder)

### Test Reset Password:

1. Open the email from Supabase
2. Click the "Reset Password" button
3. Enter your new password (min 6 characters)
4. Confirm the password
5. Click "Reset Password"
6. You'll be redirected to login

### Test Login with New Password:

1. Go to login page
2. Enter your email and new password
3. Sign in successfully

---

## 🎨 Features Included

### Forgot Password Page:
- ✅ Clean, modern UI with animations
- ✅ Email validation
- ✅ Loading states
- ✅ Success confirmation screen
- ✅ Error handling
- ✅ Toast notifications
- ✅ Back to login link

### Reset Password Page:
- ✅ Token validation
- ✅ Password strength requirements
- ✅ Password confirmation matching
- ✅ Show/hide password toggle
- ✅ Success screen with auto-redirect
- ✅ Invalid/expired link handling
- ✅ Responsive design

---

## 🔒 Security Features

1. **Token Expiration**: Reset links expire after 1 hour
2. **Secure Tokens**: Cryptographically secure tokens from Supabase
3. **Password Requirements**: Minimum 6 characters (can be increased)
4. **One-time Use**: Tokens are invalidated after use
5. **Email Verification**: Only registered emails can request resets

---

## 🚨 Common Issues & Solutions

### Issue: Email not received
**Solutions:**
- Check spam/junk folder
- Verify email is registered in the system
- Check Supabase logs: Authentication → Logs
- Ensure SMTP is configured correctly

### Issue: "Invalid or expired reset link"
**Solutions:**
- Request a new reset link (links expire in 1 hour)
- Ensure the full URL is copied correctly
- Check that redirect URLs are configured in Supabase

### Issue: "Passwords do not match"
**Solution:**
- Ensure both password fields have identical values
- Check for extra spaces

### Issue: Password reset works but can't login
**Solution:**
- Clear browser cache and cookies
- Try incognito/private browsing mode
- Verify the new password was saved (try resetting again)

---

## 📱 Email Template Customization

You can customize the email template further:

### Add Your Logo:
```html
<img src="https://yourdomain.com/logo.png" alt="Logo" style="width: 150px; margin-bottom: 20px;">
```

### Change Colors:
Replace `#4F46E5` with your brand color

### Add Footer:
```html
<hr style="margin: 30px 0; border: none; border-top: 1px solid #e5e7eb;">
<p style="color: #6b7280; font-size: 12px;">
  InstituteTool - Institute Management Platform<br>
  © 2024 All rights reserved
</p>
```

---

## 🌐 Production Checklist

Before deploying to production:

- [ ] Configure custom SMTP provider
- [ ] Update Site URL to production domain
- [ ] Add production redirect URLs
- [ ] Customize email templates with branding
- [ ] Test complete flow in production
- [ ] Set up email monitoring/logging
- [ ] Configure email rate limiting

---

## 📊 Monitoring

Monitor password reset activity in Supabase:

1. **Authentication** → **Users**: See user activity
2. **Authentication** → **Logs**: View auth events
3. Check for failed attempts or suspicious activity

---

## 🎉 You're All Set!

The forgot password functionality is now fully operational. Users can:

1. Request password reset from login page
2. Receive secure reset link via email
3. Set new password securely
4. Login with updated credentials

For any issues, check the Supabase logs and ensure all configuration steps are completed.
