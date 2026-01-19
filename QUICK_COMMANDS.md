# ⚡ Quick Commands Reference

## 🚀 Start/Stop Server

```bash
# Start development server
npm run dev

# Server will run at:
# http://localhost:3000
```

---

## 🔗 Quick URLs

```bash
# Login Page
http://localhost:3000/auth/login

# Forgot Password
http://localhost:3000/auth/forgot-password

# Reset Password (accessed via email link)
http://localhost:3000/auth/reset-password

# Signup
http://localhost:3000/auth/signup

# Dashboard
http://localhost:3000/dashboard

# Home Page
http://localhost:3000
```

---

## 🧪 Test Forgot Password Flow

```bash
# 1. Open login page
http://localhost:3000/auth/login

# 2. Click "Forgot your password?" link

# 3. Enter email and submit

# 4. Check email inbox

# 5. Click reset link in email

# 6. Set new password

# 7. Login with new password
```

---

## 📝 Supabase Configuration URLs

```bash
# Redirect URLs to add in Supabase:
http://localhost:3000/auth/callback
http://localhost:3000/auth/reset-password

# For production, also add:
https://yourdomain.com/auth/callback
https://yourdomain.com/auth/reset-password
```

---

## 🔍 Check Server Status

```bash
# View server logs
# (Check terminal where npm run dev is running)

# Server should show:
# ✓ Ready in X.Xs
# - Local: http://localhost:3000
```

---

## 📁 Key Files

```bash
# Forgot Password Page
src/app/auth/forgot-password/page.tsx

# Reset Password Page
src/app/auth/reset-password/page.tsx

# Login Page
src/app/auth/login/page.tsx

# Auth Callback
src/app/auth/callback/route.ts

# Environment Variables
.env.local
```

---

## 📚 Documentation Files

```bash
# Complete code reference
FORGOT_PASSWORD_CODE.md

# Testing guide
FORGOT_PASSWORD_TESTING.md

# Quick guide
FORGOT_PASSWORD_QUICK_GUIDE.md

# Email setup
EMAIL_SETUP.md

# Flow diagrams
PASSWORD_RESET_FLOW.md

# Implementation summary
IMPLEMENTATION_SUMMARY.md

# This file
QUICK_COMMANDS.md
```

---

## 🛠️ Useful Commands

```bash
# Install dependencies
npm install

# Build for production
npm run build

# Start production server
npm run start

# Run linter
npm run lint

# Check for errors
# (Open browser DevTools → Console)
```

---

## 🎯 Quick Test Checklist

```bash
✓ Server running
✓ Login page loads
✓ Forgot password link visible
✓ Forgot password page loads
✓ Can enter email
✓ Submit button works
✓ Success screen appears
□ Email received (needs Supabase config)
□ Reset link works
□ Can set new password
□ Can login with new password
```

---

## 🔧 Troubleshooting Commands

```bash
# Restart server
# Press Ctrl+C in terminal
npm run dev

# Clear browser cache
# Ctrl+Shift+Delete (Chrome/Edge)
# Or use Incognito mode

# Check Supabase connection
# Open browser console
# Should see no Supabase errors

# View detailed logs
# Check terminal where server is running
```

---

## 📊 Status Check

```bash
# Current Status:
✅ Server: Running
✅ Port: 3000
✅ Forgot Password: Implemented
✅ Reset Password: Implemented
✅ Code: No errors
✅ Documentation: Complete

# Needs Configuration:
⚠️ Supabase redirect URLs
⚠️ Email testing
```

---

## 🚀 Ready to Test!

**Server**: http://localhost:3000  
**Test Page**: http://localhost:3000/auth/forgot-password

**Next Step**: Configure Supabase redirect URLs and test the complete flow!
