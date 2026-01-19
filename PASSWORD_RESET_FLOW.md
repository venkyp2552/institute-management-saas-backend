# 🔐 Password Reset Flow

## Complete User Journey

```
┌─────────────────────────────────────────────────────────────────┐
│                     PASSWORD RESET FLOW                          │
└─────────────────────────────────────────────────────────────────┘

Step 1: User Forgets Password
┌──────────────────────┐
│   Login Page         │
│  /auth/login         │
│                      │
│  [Forgot Password?]  │ ◄─── User clicks link
└──────────┬───────────┘
           │
           ▼
Step 2: Request Reset
┌──────────────────────┐
│ Forgot Password Page │
│ /auth/forgot-password│
│                      │
│  Enter Email:        │
│  [____________]      │
│                      │
│  [Send Reset Link]   │ ◄─── User enters email
└──────────┬───────────┘
           │
           ▼
Step 3: Email Sent
┌──────────────────────┐
│  Success Screen      │
│                      │
│  ✓ Check Your Email  │
│                      │
│  Reset link sent to: │
│  user@example.com    │
└──────────────────────┘
           │
           ▼
Step 4: User Checks Email
┌──────────────────────┐
│   Email Inbox        │
│                      │
│  From: InstituteTool │
│  Subject: Reset      │
│  Password            │
│                      │
│  [Reset Password] ◄──┼─── User clicks button
└──────────┬───────────┘
           │
           ▼
Step 5: Reset Password
┌──────────────────────┐
│ Reset Password Page  │
│ /auth/reset-password │
│                      │
│  New Password:       │
│  [____________]      │
│                      │
│  Confirm Password:   │
│  [____________]      │
│                      │
│  [Reset Password]    │ ◄─── User sets new password
└──────────┬───────────┘
           │
           ▼
Step 6: Success
┌──────────────────────┐
│  Success Screen      │
│                      │
│  ✓ Password Reset!   │
│                      │
│  Redirecting to      │
│  login...            │
└──────────┬───────────┘
           │
           ▼
Step 7: Login with New Password
┌──────────────────────┐
│   Login Page         │
│  /auth/login         │
│                      │
│  Email: [_______]    │
│  Password: [____]    │ ◄─── User logs in
│                      │
│  [Sign In]           │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│   Dashboard          │
│  /dashboard          │
│                      │
│  ✓ Logged In!        │
└──────────────────────┘
```

---

## Error Handling Flows

### Invalid/Expired Token
```
User clicks old reset link
         │
         ▼
┌──────────────────────┐
│  Error Screen        │
│                      │
│  ✗ Invalid Link      │
│                      │
│  [Request New Link]  │
└──────────────────────┘
```

### Passwords Don't Match
```
User enters mismatched passwords
         │
         ▼
┌──────────────────────┐
│  Error Message       │
│                      │
│  ⚠ Passwords do not  │
│     match            │
└──────────────────────┘
```

### Email Not Found
```
User enters unregistered email
         │
         ▼
┌──────────────────────┐
│  Success Screen      │
│  (Security measure)  │
│                      │
│  ✓ If email exists,  │
│    link sent         │
└──────────────────────┘
```

---

## Technical Flow

```
Frontend                    Supabase                    Email Service
   │                           │                              │
   │  1. Request Reset         │                              │
   ├──────────────────────────>│                              │
   │  (email)                  │                              │
   │                           │                              │
   │                           │  2. Generate Token           │
   │                           │  & Send Email                │
   │                           ├─────────────────────────────>│
   │                           │                              │
   │  3. Success Response      │                              │
   │<──────────────────────────┤                              │
   │                           │                              │
   │                           │  4. Email Delivered          │
   │                           │<─────────────────────────────┤
   │                           │                              │
   │  5. User Clicks Link      │                              │
   │  (with token)             │                              │
   ├──────────────────────────>│                              │
   │                           │                              │
   │  6. Validate Token        │                              │
   │<──────────────────────────┤                              │
   │                           │                              │
   │  7. Submit New Password   │                              │
   ├──────────────────────────>│                              │
   │                           │                              │
   │  8. Update Password       │                              │
   │  & Invalidate Token       │                              │
   │<──────────────────────────┤                              │
   │                           │                              │
```

---

## API Endpoints Used

### 1. Request Password Reset
```typescript
supabase.auth.resetPasswordForEmail(email, {
  redirectTo: `${window.location.origin}/auth/reset-password`,
})
```

### 2. Update Password
```typescript
supabase.auth.updateUser({
  password: newPassword
})
```

### 3. Get Session (Validate Token)
```typescript
supabase.auth.getSession()
```

---

## Security Measures

1. **Token Expiration**: 1 hour validity
2. **One-time Use**: Token invalidated after use
3. **Secure Transmission**: HTTPS only
4. **No Password Hints**: Generic success messages
5. **Rate Limiting**: Supabase built-in protection
6. **Email Verification**: Only registered emails

---

## Files Involved

```
src/
├── app/
│   └── auth/
│       ├── login/
│       │   └── page.tsx          # Login with "Forgot Password" link
│       ├── forgot-password/
│       │   └── page.tsx          # Request reset link
│       └── reset-password/
│           └── page.tsx          # Set new password
└── lib/
    └── supabase/
        └── client.ts             # Supabase client
```

---

## Testing Checklist

- [ ] Navigate to forgot password from login
- [ ] Submit valid email address
- [ ] Receive email with reset link
- [ ] Click reset link in email
- [ ] Verify token validation works
- [ ] Set new password successfully
- [ ] Confirm passwords must match
- [ ] Test password length validation
- [ ] Verify redirect to login works
- [ ] Login with new password
- [ ] Test expired token handling
- [ ] Test invalid token handling
- [ ] Verify email not found handling

---

## User Experience Features

### Visual Feedback
- ✅ Loading spinners during API calls
- ✅ Success animations
- ✅ Error messages with helpful text
- ✅ Toast notifications
- ✅ Progress indicators

### Accessibility
- ✅ Keyboard navigation
- ✅ Screen reader friendly
- ✅ Clear error messages
- ✅ Focus management
- ✅ ARIA labels

### Mobile Responsive
- ✅ Touch-friendly buttons
- ✅ Responsive layout
- ✅ Mobile-optimized forms
- ✅ Readable text sizes

---

## Next Steps

1. **Configure Supabase** (see EMAIL_SETUP.md)
2. **Test the flow** end-to-end
3. **Customize email templates** with branding
4. **Set up monitoring** for password resets
5. **Deploy to production**

---

**Status**: ✅ Fully Implemented and Ready to Use!
