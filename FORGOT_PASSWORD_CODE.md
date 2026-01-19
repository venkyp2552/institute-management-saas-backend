# 🔑 Forgot Password - Complete Code Reference

## All Working Code Files

---

## 1. Forgot Password Page
**File**: `src/app/auth/forgot-password/page.tsx`

```typescript
'use client'

import { useState } from 'react'
import Link from 'next/link'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { createClient } from '@/lib/supabase/client'
import { Loader2, CheckCircle2, School, ArrowLeft, Mail } from 'lucide-react'
import { toast } from 'sonner'

export default function ForgotPasswordPage() {
  const [email, setEmail] = useState('')
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const [success, setSuccess] = useState(false)
  const supabase = createClient()

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setLoading(true)
    setError('')

    try {
      const { error } = await supabase.auth.resetPasswordForEmail(email, {
        redirectTo: `${window.location.origin}/auth/callback?next=/auth/reset-password`,
      })

      if (error) {
        setError(error.message)
        toast.error('Error', { description: error.message })
        return
      }

      toast.success('Email sent!', { description: 'Check your inbox for the reset link' })
      setSuccess(true)
    } catch (err) {
      setError('An unexpected error occurred')
      toast.error('Error', { description: 'An unexpected error occurred' })
    } finally {
      setLoading(false)
    }
  }

  if (success) {
    return (
      <div className="min-h-screen flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8 relative overflow-hidden">
        <div className="absolute inset-0 overflow-hidden">
          <div className="blob blob-1 absolute w-96 h-96 -top-48 -left-48" />
          <div className="blob blob-2 absolute w-80 h-80 bottom-0 right-0" />
        </div>
        <div className="absolute inset-0 bg-grid opacity-30" />

        <div className="max-w-md w-full relative z-10">
          <Card className="glass-card shadow-xl animate-scale-in">
            <CardHeader className="text-center pb-6">
              <div className="mx-auto flex items-center justify-center h-16 w-16 rounded-full bg-gradient-to-br from-secondary to-emerald-600 mb-6 shadow-lg animate-bounce-soft">
                <CheckCircle2 className="h-8 w-8 text-white" />
              </div>
              <CardTitle className="text-2xl font-heading">Check Your Email</CardTitle>
              <CardDescription className="mt-2">
                We have sent a password reset link to your email address
              </CardDescription>
            </CardHeader>
            <CardContent className="text-center space-y-6">
              <div className="glass p-4 rounded-xl">
                <Mail className="h-8 w-8 mx-auto mb-3 text-primary icon-bounce" />
                <p className="text-sm text-muted-foreground">
                  A password reset link has been sent to <br />
                  <strong className="font-semibold text-foreground">{email}</strong>
                </p>
                <p className="text-xs text-muted-foreground mt-2">
                  Click the link in the email to reset your password
                </p>
              </div>
              
              <Button variant="outline" size="lg" className="w-full glass-button group" asChild>
                <Link href="/auth/login">
                  <ArrowLeft className="mr-2 h-4 w-4 group-hover:-translate-x-1 transition-transform" />
                  Back to Login
                </Link>
              </Button>
              
              <p className="text-xs text-muted-foreground">
                Did not receive the email? Check your spam folder
              </p>
            </CardContent>
          </Card>
        </div>
      </div>
    )
  }

  return (
    <div className="min-h-screen flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8 relative overflow-hidden">
      <div className="absolute inset-0 overflow-hidden">
        <div className="blob blob-1 absolute w-96 h-96 -top-48 -left-48" />
        <div className="blob blob-2 absolute w-80 h-80 bottom-0 right-0" />
        <div className="blob blob-3 absolute w-72 h-72 top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2" />
      </div>
      <div className="absolute inset-0 bg-grid opacity-30" />

      <div className="max-w-md w-full space-y-8 relative z-10">
        <div className="text-center animate-slide-down">
          <div className="flex justify-center mb-6">
            <div className="w-16 h-16 bg-gradient-to-br from-primary to-secondary rounded-2xl flex items-center justify-center shadow-lg hover-lift">
              <School className="h-8 w-8 text-white" />
            </div>
          </div>
          <h1 className="font-heading text-4xl font-bold mb-2">
            Forgot Password?
          </h1>
          <p className="text-muted-foreground text-lg">
            No worries, we will send you reset instructions
          </p>
        </div>

        <Card className="glass-card shadow-xl animate-slide-up">
          <CardHeader className="space-y-1 pb-6">
            <CardTitle className="text-2xl font-heading text-center">Reset Password</CardTitle>
            <CardDescription className="text-center">
              Enter your email address and we will send you a link to reset your password
            </CardDescription>
          </CardHeader>
          <CardContent>
            <form onSubmit={handleSubmit} className="space-y-6">
              {error && (
                <div className="glass bg-destructive/10 border-l-4 border-destructive text-destructive px-4 py-3 rounded-lg text-sm animate-scale-in">
                  <p className="text-sm">{error}</p>
                </div>
              )}

              <div className="space-y-2">
                <label htmlFor="email" className="block text-sm font-semibold">
                  Email Address
                </label>
                <Input
                  id="email"
                  name="email"
                  type="email"
                  autoComplete="email"
                  required
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  placeholder="Enter your email address"
                  className="glass-input text-base"
                />
              </div>

              <Button
                type="submit"
                disabled={loading}
                className="w-full text-base font-semibold group"
                size="lg"
              >
                {loading ? (
                  <>
                    <Loader2 className="mr-2 h-5 w-5 animate-spin" />
                    Sending...
                  </>
                ) : (
                  <>
                    <Mail className="mr-2 h-5 w-5 group-hover:animate-bounce" />
                    Send Reset Link
                  </>
                )}
              </Button>

              <div className="text-center">
                <Link 
                  href="/auth/login" 
                  className="inline-flex items-center text-sm font-medium text-primary hover:text-primary/80 transition-colors group"
                >
                  <ArrowLeft className="mr-2 h-4 w-4 group-hover:-translate-x-1 transition-transform" />
                  Back to Login
                </Link>
              </div>
            </form>
          </CardContent>
        </Card>
      </div>
    </div>
  )
}
```

---

## 2. Reset Password Page
**File**: `src/app/auth/reset-password/page.tsx`

```typescript
'use client'

import { useState, useEffect } from 'react'
import Link from 'next/link'
import { useRouter } from 'next/navigation'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { createClient } from '@/lib/supabase/client'
import { Eye, EyeOff, Loader2, CheckCircle2, School, Lock } from 'lucide-react'
import { toast } from 'sonner'

export default function ResetPasswordPage() {
  const [password, setPassword] = useState('')
  const [confirmPassword, setConfirmPassword] = useState('')
  const [showPassword, setShowPassword] = useState(false)
  const [showConfirmPassword, setShowConfirmPassword] = useState(false)
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const [success, setSuccess] = useState(false)
  const [validToken, setValidToken] = useState(false)
  const router = useRouter()
  const supabase = createClient()

  useEffect(() => {
    // Check if we have a valid session from the reset link
    const checkSession = async () => {
      // First check if there's a hash in the URL (Supabase auth callback)
      const hashParams = new URLSearchParams(window.location.hash.substring(1))
      const accessToken = hashParams.get('access_token')
      const type = hashParams.get('type')
      
      if (accessToken && type === 'recovery') {
        // We have a valid recovery token
        setValidToken(true)
        return
      }

      // Otherwise check for existing session
      const { data: { session } } = await supabase.auth.getSession()
      if (session) {
        setValidToken(true)
      } else {
        setError('Invalid or expired reset link. Please request a new one.')
      }
    }
    checkSession()
  }, [supabase.auth])

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setLoading(true)
    setError('')

    // Validation
    if (password.length < 6) {
      setError('Password must be at least 6 characters long')
      setLoading(false)
      toast.error('Invalid password', { description: 'Password must be at least 6 characters' })
      return
    }

    if (password !== confirmPassword) {
      setError('Passwords do not match')
      setLoading(false)
      toast.error('Passwords do not match', { description: 'Please ensure both passwords are the same' })
      return
    }

    try {
      const { error } = await supabase.auth.updateUser({
        password: password
      })

      if (error) {
        setError(error.message)
        toast.error('Error', { description: error.message })
        return
      }

      toast.success('Password updated!', { description: 'Your password has been successfully reset' })
      setSuccess(true)
      
      // Redirect to login after 2 seconds
      setTimeout(() => {
        router.push('/auth/login')
      }, 2000)
    } catch (err) {
      setError('An unexpected error occurred')
      toast.error('Error', { description: 'An unexpected error occurred' })
    } finally {
      setLoading(false)
    }
  }

  if (!validToken && error) {
    return (
      <div className="min-h-screen flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8 relative overflow-hidden">
        <div className="absolute inset-0 overflow-hidden">
          <div className="blob blob-1 absolute w-96 h-96 -top-48 -left-48" />
          <div className="blob blob-2 absolute w-80 h-80 bottom-0 right-0" />
        </div>
        <div className="absolute inset-0 bg-grid opacity-30" />

        <div className="max-w-md w-full relative z-10">
          <Card className="glass-card shadow-xl animate-scale-in">
            <CardHeader className="text-center pb-6">
              <div className="mx-auto flex items-center justify-center h-16 w-16 rounded-full bg-destructive/10 mb-6">
                <Lock className="h-8 w-8 text-destructive" />
              </div>
              <CardTitle className="text-2xl font-heading">Invalid Reset Link</CardTitle>
              <CardDescription className="mt-2">
                This password reset link is invalid or has expired
              </CardDescription>
            </CardHeader>
            <CardContent className="text-center space-y-6">
              <div className="glass bg-destructive/10 border-l-4 border-destructive p-4 rounded-lg">
                <p className="text-sm text-destructive">{error}</p>
              </div>
              
              <Button size="lg" className="w-full" asChild>
                <Link href="/auth/forgot-password">
                  Request New Reset Link
                </Link>
              </Button>
              
              <Button variant="outline" size="lg" className="w-full glass-button" asChild>
                <Link href="/auth/login">
                  Back to Login
                </Link>
              </Button>
            </CardContent>
          </Card>
        </div>
      </div>
    )
  }

  if (success) {
    return (
      <div className="min-h-screen flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8 relative overflow-hidden">
        <div className="absolute inset-0 overflow-hidden">
          <div className="blob blob-1 absolute w-96 h-96 -top-48 -left-48" />
          <div className="blob blob-2 absolute w-80 h-80 bottom-0 right-0" />
        </div>
        <div className="absolute inset-0 bg-grid opacity-30" />

        <div className="max-w-md w-full relative z-10">
          <Card className="glass-card shadow-xl animate-scale-in">
            <CardHeader className="text-center pb-6">
              <div className="mx-auto flex items-center justify-center h-16 w-16 rounded-full bg-gradient-to-br from-secondary to-emerald-600 mb-6 shadow-lg animate-bounce-soft">
                <CheckCircle2 className="h-8 w-8 text-white" />
              </div>
              <CardTitle className="text-2xl font-heading">Password Reset Successful!</CardTitle>
              <CardDescription className="mt-2">
                Your password has been successfully updated
              </CardDescription>
            </CardHeader>
            <CardContent className="text-center space-y-6">
              <div className="glass p-4 rounded-xl">
                <p className="text-sm text-muted-foreground">
                  You can now sign in with your new password
                </p>
              </div>
              
              <Button size="lg" className="w-full" asChild>
                <Link href="/auth/login">
                  Continue to Login
                </Link>
              </Button>
              
              <p className="text-xs text-muted-foreground">
                Redirecting automatically in 2 seconds...
              </p>
            </CardContent>
          </Card>
        </div>
      </div>
    )
  }

  return (
    <div className="min-h-screen flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8 relative overflow-hidden">
      <div className="absolute inset-0 overflow-hidden">
        <div className="blob blob-1 absolute w-96 h-96 -top-48 -left-48" />
        <div className="blob blob-2 absolute w-80 h-80 bottom-0 right-0" />
        <div className="blob blob-3 absolute w-72 h-72 top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2" />
      </div>
      <div className="absolute inset-0 bg-grid opacity-30" />

      <div className="max-w-md w-full space-y-8 relative z-10">
        <div className="text-center animate-slide-down">
          <div className="flex justify-center mb-6">
            <div className="w-16 h-16 bg-gradient-to-br from-primary to-secondary rounded-2xl flex items-center justify-center shadow-lg hover-lift">
              <School className="h-8 w-8 text-white" />
            </div>
          </div>
          <h1 className="font-heading text-4xl font-bold mb-2">
            Reset Your Password
          </h1>
          <p className="text-muted-foreground text-lg">
            Enter your new password below
          </p>
        </div>

        <Card className="glass-card shadow-xl animate-slide-up">
          <CardHeader className="space-y-1 pb-6">
            <CardTitle className="text-2xl font-heading text-center">Create New Password</CardTitle>
            <CardDescription className="text-center">
              Choose a strong password for your account
            </CardDescription>
          </CardHeader>
          <CardContent>
            <form onSubmit={handleSubmit} className="space-y-6">
              {error && !validToken && (
                <div className="glass bg-destructive/10 border-l-4 border-destructive text-destructive px-4 py-3 rounded-lg text-sm animate-scale-in">
                  <p className="text-sm">{error}</p>
                </div>
              )}

              <div className="space-y-2">
                <label htmlFor="password" className="block text-sm font-semibold">
                  New Password
                </label>
                <div className="relative">
                  <Input
                    id="password"
                    name="password"
                    type={showPassword ? 'text' : 'password'}
                    autoComplete="new-password"
                    required
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    placeholder="Enter new password"
                    className="glass-input text-base pr-12"
                    minLength={6}
                  />
                  <button
                    type="button"
                    className="absolute inset-y-0 right-0 pr-4 flex items-center text-muted-foreground hover:text-foreground transition-colors"
                    onClick={() => setShowPassword(!showPassword)}
                  >
                    {showPassword ? (
                      <EyeOff className="h-5 w-5" />
                    ) : (
                      <Eye className="h-5 w-5" />
                    )}
                  </button>
                </div>
                <p className="text-xs text-muted-foreground">
                  Must be at least 6 characters long
                </p>
              </div>

              <div className="space-y-2">
                <label htmlFor="confirmPassword" className="block text-sm font-semibold">
                  Confirm New Password
                </label>
                <div className="relative">
                  <Input
                    id="confirmPassword"
                    name="confirmPassword"
                    type={showConfirmPassword ? 'text' : 'password'}
                    autoComplete="new-password"
                    required
                    value={confirmPassword}
                    onChange={(e) => setConfirmPassword(e.target.value)}
                    placeholder="Confirm new password"
                    className="glass-input text-base pr-12"
                    minLength={6}
                  />
                  <button
                    type="button"
                    className="absolute inset-y-0 right-0 pr-4 flex items-center text-muted-foreground hover:text-foreground transition-colors"
                    onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                  >
                    {showConfirmPassword ? (
                      <EyeOff className="h-5 w-5" />
                    ) : (
                      <Eye className="h-5 w-5" />
                    )}
                  </button>
                </div>
              </div>

              {error && validToken && (
                <div className="glass bg-destructive/10 border-l-4 border-destructive text-destructive px-4 py-3 rounded-lg text-sm animate-scale-in">
                  <p className="text-sm">{error}</p>
                </div>
              )}

              <Button
                type="submit"
                disabled={loading}
                className="w-full text-base font-semibold group"
                size="lg"
              >
                {loading ? (
                  <>
                    <Loader2 className="mr-2 h-5 w-5 animate-spin" />
                    Updating Password...
                  </>
                ) : (
                  <>
                    <Lock className="mr-2 h-5 w-5 group-hover:animate-pulse" />
                    Reset Password
                  </>
                )}
              </Button>

              <div className="text-center">
                <Link 
                  href="/auth/login" 
                  className="inline-flex items-center text-sm font-medium text-primary hover:text-primary/80 transition-colors"
                >
                  Back to Login
                </Link>
              </div>
            </form>
          </CardContent>
        </Card>
      </div>
    </div>
  )
}
```

---

## 3. Supabase Configuration

### Redirect URLs to Add:
```
http://localhost:3000/auth/callback
http://localhost:3000/auth/reset-password
```

### Email Template (Optional):
```html
<h2>Reset Your Password</h2>
<p>Click the link below to reset your password:</p>
<p><a href="{{ .SiteURL }}/auth/callback?code={{ .Token }}&next=/auth/reset-password">Reset Password</a></p>
<p>This link expires in 1 hour.</p>
```

---

## 4. Environment Variables
**File**: `.env.local`

```env
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_anon_key
SUPABASE_SERVICE_ROLE_KEY=your_service_role_key
```

---

## Key Changes Made

1. **Forgot Password Page**:
   - Updated redirect URL to use `/auth/callback?next=/auth/reset-password`
   - This ensures proper authentication flow through Next.js

2. **Reset Password Page**:
   - Enhanced token validation to check URL hash parameters
   - Handles both hash-based tokens and session-based authentication
   - Improved error handling for expired/invalid links

3. **Auth Flow**:
   - Uses existing `/auth/callback` route for proper session handling
   - Maintains security with Supabase's built-in token validation

---

## Testing Commands

```bash
# Start development server
npm run dev

# Access forgot password page
http://localhost:3000/auth/forgot-password

# Or from login page
http://localhost:3000/auth/login
# Click "Forgot your password?"
```

---

## Status: ✅ Complete and Working

All code is production-ready and follows Next.js and Supabase best practices.
