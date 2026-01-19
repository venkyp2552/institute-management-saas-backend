# 🔧 Fix Email Issue - Quick Solution

## ❌ Problem
You're not receiving password reset emails.

## ✅ Solution
Configure Supabase redirect URLs (takes 5 minutes).

---

## 🎯 What You Need to Do

### Go to Supabase Dashboard:
**URL**: https://supabase.com/dashboard/project/ogbdkyjmecmgkudhzclb

### Add These 3 URLs:

1. Go to **Authentication** → **URL Configuration**
2. Add these redirect URLs:

```
http://localhost:3000/auth/callback
http://localhost:3000/auth/reset-password
http://localhost:3000/auth/confirm
```

3. Set **Site URL** to:
```
http://localhost:3000
```

4. Click **Save**

---

## 🧪 Test It

1. Go to: http://localhost:3000/auth/login
2. Click "Forgot your password?"
3. Enter your email
4. Check your inbox (and spam folder!)

---

## 📚 Detailed Guides

If you need more help, check these files:

1. **SUPABASE_SETUP_STEPS.md** - Visual step-by-step guide
2. **EMAIL_CONFIGURATION_GUIDE.md** - Complete configuration guide
3. **FORGOT_PASSWORD_TESTING.md** - Testing instructions

---

## ⚡ Quick Summary

**Issue**: Supabase redirect URLs not configured  
**Fix**: Add 3 URLs in Supabase dashboard  
**Time**: 5 minutes  
**Result**: Emails will work! ✅

---

## 🚨 Important Notes

### Current Signup Behavior:
- ✅ Signup works without email verification
- ✅ Users can login immediately after signup
- ✅ No verification email is sent (by design)

### Forgot Password:
- ⚠️ Requires Supabase configuration (above)
- ✅ Will send email after configuration
- ✅ Already fully implemented in code

---

## 💡 Why This Happens

Supabase requires you to whitelist redirect URLs for security. Without this configuration:
- ❌ Password reset emails won't send
- ❌ Email verification won't work
- ❌ Magic links won't work

After configuration:
- ✅ All email features work perfectly!

---

## 🎉 That's It!

Just add those 3 URLs in Supabase, and everything will work!

**Your Supabase Dashboard**: https://supabase.com/dashboard/project/ogbdkyjmecmgkudhzclb
