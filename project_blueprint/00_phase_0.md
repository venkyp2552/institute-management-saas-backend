# Phase 0: Public Website & Landing Page Design

## 1. Goal & Objectives
**Goal:** Create a high-converting, aesthetically premium "Front Door" for the SaaS that explains the value proposition and funnels users into the application.
**Focus:** Visual Design, Marketing Content, and Navigation Structure.

## 2. Page Structure & Details
### 2.1 Global Navigation (Navbar)
- **Logo:** "Institute SaaS" (Left aligned).
- **Links:** Home, Features, Pricing, About Us, Contact.
- **Auth Buttons:** 
    - **"Login"**: Secondary Style (Outline). Link to `/auth/login`.
    - **"Get Started" / "Register Institute"**: Primary Style (Solid). Link to `/auth/signup`.
    - *Note:* These buttons will be static links in this phase, handled in Phase 2.

### 2.2 Home Page (`/`)
- **Hero Section:** 
    - Headline: "Manage Your Institute Effeciently & Digitally."
    - Sub-text: "One platform for Students, Batches, and Fees."
    - Two Buttons: "Start Free Trial" & "Watch Demo".
- **Social Proof:** "Trusted by 50+ Schools" (Logos).
- **Key Benefits Grid:** 3-Column Layout (Attendance, Easy Management, Secure Data).
- **Interactive Preview:** A mock screenshot or generic image of the Dashboard (Glassmorphism style).

### 2.3 Features Page (`/features`)
- **Detailed Sections:**
    - **Academic Management:** Graphics showing Batch creation.
    - **Student Life:** Graphics showing Announcement cards.
    - **Reports:** Graphics showing charts.
- **Call-to-Action:** Bottom section redirecting to Signup.

### 2.4 Pricing Page (`/pricing`)
- **Plans Card Wrapper:**
    - **Basic Plan:** "Free/Low Cost" -> List features -> "Choose Basic" Button.
    - **Pro Plan:** "Premium" -> List advanced features -> "Choose Pro" Button.
- **Button Logic:** Both buttons temporarily link to `/auth/signup`. In Phase 5, these will trigger the Payment Flow.

### 2.5 Contact / Support (`/contact`)
- Simple form (Name, Email, Message) using a service like Formspree or just a `mailto:` link for Phase 0.
- Office Address & Email detail footer.

## 3. Technical Implementation Details
### Frontend (Next.js)
- **Design System:** Implement the "Institute Theme" here first.
    - **Colors:** Deep Blue (`#1e3a8a`) and Emerald Green (`#10b981`) accents.
    - **Typography:** `Inter` for UI, `Merriweather` for Headings.
- **Components:**
    - `HeroSection.tsx`
    - `FeatureCard.tsx`
    - `PricingTable.tsx`
    - `Footer.tsx`
- **Responsiveness:** Mobile-first approach. Hamburger menu for Navbar on mobile.

## 4. Connections to Future Phases
- **Login/Signup Buttons:** Will connect to the Authentication Routes built in **Phase 2**.
- **Pricing "Choose Plan" Buttons:** Will carry the selected `plan_id` to the Signup flow in **Phase 5**.
- **Admin Dashboard:** The "Preview" images here should match the actual design built in **Phase 3**.

## 5. Deliverables & Acceptance Criteria
- [ ] Landing Page is live at root URL.
- [ ] "Features" and "Pricing" pages are accessible.
- [ ] Navbar exists on all public pages.
- [ ] Mobile Menu works.
- [ ] UI matches the "Modern & Minimal Institute-style" guideline.
