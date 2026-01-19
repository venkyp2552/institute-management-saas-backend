# 🎯 Supabase Setup - Visual Step-by-Step Guide

## 🚨 CRITICAL: This Must Be Done for Emails to Work!

---

## Step 1: Open Supabase Dashboard

1. **Open your browser**
2. **Go to**: https://supabase.com/dashboard
3. **Login** with your Supabase account
4. **Click on your project**: `ogbdkyjmecmgkudhzclb`

---

## Step 2: Navigate to URL Configuration

1. In the left sidebar, click **"Authentication"**
2. In the Authentication menu, click **"URL Configuration"**
3. You should see a page with URL settings

---

## Step 3: Add Redirect URLs

### What You'll See:
- A section called **"Redirect URLs"**
- A text input field
- An **"Add URL"** button

### What to Do:

1. **In the text field, type**:
   ```
   http://localhost:3000/auth/callback
   ```

2. **Click "Add URL"** or press Enter

3. **Repeat for the second URL**:
   ```
   http://localhost:3000/auth/reset-password
   ```

4. **Click "Add URL"** or press Enter

5. **Add the third URL**:
   ```
   http://localhost:3000/auth/confirm
   ```

6. **Click "Add URL"** or press Enter

### After Adding:
You should see all three URLs listed:
- ✅ http://localhost:3000/auth/callback
- ✅ http://localhost:3000/auth/reset-password
- ✅ http://localhost:3000/auth/confirm

---

## Step 4: Set Site URL

### In the same page:

1. **Find "Site URL" field**
2. **Enter**:
   ```
   http://localhost:3000
   ```
3. **Make sure there's NO trailing slash** (no `/` at the end)

---

## Step 5: Save Changes

1. **Scroll to the bottom** of the page
2. **Click the "Save" button**
3. **Wait for confirmation** message (usually green notification)

---

## Step 6: Verify Email Templates

1. **In the left sidebar**, click **"Authentication"**
2. **Click "Email Templates"**
3. **You should see these templates**:
   - Confirm signup
   - Invite user
   - Magic Link
   - Change Email Address
   - **Reset Password** ← This is important!

4. **Click on "Reset Password"**
5. **Verify the toggle is ON** (enabled)
6. **The template should look like this**:

```
Subject: Reset Your Password

Body:
<h2>Reset Your Password</h2>
<p>Follow this link to reset the password for your user:</p>
<p><a href="{{ .SiteURL }}/auth/callback?code={{ .Token }}&next=/auth/reset-password">Reset Password</a></p>
```

---

## Step 7: Check Auth Settings

1. **In the left sidebar**, click **"Project Settings"** (gear icon at bottom)
2. **Click "Auth"** in the settings menu
3. **Scroll down to find**:
   - **Enable Email Signup**: Should be ON ✅
   - **Confirm Email**: Can be ON or OFF (currently OFF for auto-confirm)

---

## ✅ Configuration Complete!

You should now have:
- ✅ 3 Redirect URLs added
- ✅ Site URL set to `http://localhost:3000`
- ✅ Email templates enabled
- ✅ Auth settings verified

---

## 🧪 Test It Now!

### Test Forgot Password:

1. **Open**: http://localhost:3000/auth/login
2. **Click**: "Forgot your password?"
3. **Enter**: Your email address (the one you used for signup)
4. **Click**: "Send Reset Link"
5. **Check**: Your email inbox (and spam folder!)

### What Should Happen:

1. ✅ Success message appears on screen
2. ✅ Email arrives within 1-2 minutes
3. ✅ Email has subject: "Reset Your Password"
4. ✅ Email contains a clickable link
5. ✅ Clicking link opens reset password page
6. ✅ You can set new password
7. ✅ You can login with new password

---

## 🐛 If Email Doesn't Arrive

### Check These:

1. **Spam/Junk Folder**
   - Supabase emails often go to spam
   - Check your spam folder first!

2. **Correct Email Address**
   - Make sure you entered the email you used for signup
   - Check for typos

3. **Supabase Logs**
   - Go to: Authentication → Logs
   - Look for password reset requests
   - Check for any error messages

4. **Wait a Few Minutes**
   - Sometimes emails take 2-5 minutes
   - Be patient!

5. **Try Different Email**
   - Some email providers block automated emails
   - Try Gmail if you're using another provider

---

## 📊 Visual Checklist

```
Supabase Dashboard Setup:
┌─────────────────────────────────────┐
│ ✅ Logged into Supabase             │
│ ✅ Project selected                 │
│ ✅ Authentication → URL Config      │
│ ✅ Added redirect URLs (3 total)   │
│ ✅ Set Site URL                     │
│ ✅ Saved changes                    │
│ ✅ Verified email templates         │
│ ✅ Checked auth settings            │
└─────────────────────────────────────┘

Testing:
┌─────────────────────────────────────┐
│ ✅ Server running                   │
│ ✅ Opened forgot password page      │
│ ✅ Entered email                    │
│ ✅ Clicked send                     │
│ ⏳ Waiting for email...             │
│ ✅ Email received!                  │
│ ✅ Clicked reset link               │
│ ✅ Set new password                 │
│ ✅ Logged in successfully           │
└─────────────────────────────────────┘
```

---

## 🎯 Quick Links

### Your Supabase Project:
```
Dashboard: https://supabase.com/dashboard/project/ogbdkyjmecmgkudhzclb
URL Config: https://supabase.com/dashboard/project/ogbdkyjmecmgkudhzclb/auth/url-configuration
Email Templates: https://supabase.com/dashboard/project/ogbdkyjmecmgkudhzclb/auth/templates
Logs: https://supabase.com/dashboard/project/ogbdkyjmecmgkudhzclb/auth/logs
```

### Your Local App:
```
Login: http://localhost:3000/auth/login
Forgot Password: http://localhost:3000/auth/forgot-password
Signup: http://localhost:3000/auth/signup
```

---

## 📝 Copy-Paste URLs

For easy copy-paste into Supabase:

```
http://localhost:3000/auth/callback
```

```
http://localhost:3000/auth/reset-password
```

```
http://localhost:3000/auth/confirm
```

```
http://localhost:3000
```

---

## 🎉 After Setup

Once configured, you can:
- ✅ Request password reset
- ✅ Receive email with reset link
- ✅ Click link to reset password
- ✅ Set new password
- ✅ Login successfully

**No code changes needed** - Everything is already implemented!

---

## 💡 Pro Tips

1. **Bookmark your Supabase dashboard** for quick access
2. **Check spam folder first** if email doesn't arrive
3. **Use Gmail** for testing (most reliable)
4. **Wait 2-5 minutes** for email delivery
5. **Check Supabase logs** if issues persist

---

## 🚀 You're Almost There!

Just complete the Supabase configuration above, and your forgot password feature will work perfectly!

**Estimated Time**: 5 minutes  
**Difficulty**: Easy  
**Result**: Fully working password reset! ✅
