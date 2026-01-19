# Phase 2: Authentication, Roles & Multi-Tenancy

## 1. Goal & Objectives
**Goal:** Implement secure authentication and the core "Multi-Tenant" architecture where data is strictly isolated per school.
**Focus:** Database Design, Security (RLS), and Onboarding Flow.

## 2. Features & Components
### 2.1 Database Schema (Supabase)
- **Tables:**
    - `schools`: Stores school details (Name, ID, Status: Active/Inactive, Subscription).
    - `profiles`: Extends Supabase Auth (User ID, Role: 'super_admin' | 'school_admin' | 'student', School ID).
- **Row Level Security (RLS):**
    - **Strict Rule:** Users can ONLY access rows where `school_id` matches their own.
    - **Super Admin:** Can access all rows (requires special bypass policy or role check).

### 2.2 Application Authentication
- **Sign Up:** "Register your School" (Linked from the "Get Started" button in **Phase 0**).
- **Log In:** Universal login page (Linked from the "Login" button in **Phase 0**).
- **Middleware:** Next.js middleware to protect `/dashboard/*` routes.
    - Redirect unauthenticated users to `/login`.
    - Redirect activated schools to Dashboard.
    - Redirect inactive schools to "Payment Pending" page.

### 2.3 Dashboard Shell (Layouts)
- **Super Admin Layout:** Sidebar with "Manage Schools", "Analytics".
- **School Admin Layout:** Sidebar with "Students", "Batches", "Attendance".
- **Top Bar:** User User Profile dropdown & Logout.

## 3. Technical Implementation Details
### Database
- **Supabase Auth:** Handle Signups/Logins.
- **Triggers:** Auto-create `profile` entry on new User signup.
- **Policies:**
    - `CREATE policy "Enable read for users based on school_id" ON "schools" ...`
    - `CREATE policy "Enable all for super_admin" ...`

### Frontend
- **Page:** `/auth/login` and `/auth/signup`.
- **Context:** `AuthContext` to store user session and profile data globally.
- **Protected Routes:** Use Next.js Middleware to inspect Session Tokens.

## 4. Deliverables & Acceptance Criteria
- [ ] Users can Sign Up (Creating a new School).
- [ ] Users can Log In.
- [ ] Middleware prevents access to `/dashboard` without login.
- [ ] Logic confirmed: Clicking "Get Started" on Landing Page (Phase 0) leads to Signup.
- [ ] RLS policies confirmed: One school Admin cannot query another school's data via Supabase Client.
- [ ] Basic Sidebar Navigation is visible upon login.

## 5. Connection to Next Phase
Phase 2 secures the platform. Phase 3 will flesh out the **School Admin Dashboard** with actual CRUD capabilities for School Identity and Batch Management.
