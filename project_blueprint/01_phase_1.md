# Phase 1: Foundation & Technical Setup

## 1. Goal & Objectives
**Goal:** Establish the technical foundation and infrastructure for the entire SaaS.
**Focus:** Next.js Setup, Global Styling Framework, and Database Connection.

## 2. Features & Components
### 2.1 Technical Setup
- **Frontend:** Initialize Next.js (App Router) with TypeScript.
- **Styling:** Setup Tailwind CSS with the custom "Institute" theme.
- **Backend:** Initialize FastAPI project structure (for future use in Phase 4/5).
- **Database:** Create Supabase project & connect environment variables.

### 2.2 Design System Implementation
- **Typography:** Configure fonts (Inter/Roboto) for professional/educational feel.
- **Color Palette:** Define primary (Trust Blue/Deep Green), secondary, and accent colors.
- **UI Components:** Build reusable atoms:
    - Primary/Secondary Buttons (with hover micro-animations).
    - Input Fields (with focus states).
    - Cards (with subtle shadow and hover lift).
    - Section Headers.

### 2.3 Shared Layouts
- **Main Layout:** Wraps the Application.
- **Toast Provider:** For global notifications (Success/Error messages).
- **React Query Wrapper:** For efficient data fetching.

## 3. Technical Implementation Details
### Frontend (Next.js)
- **Directory:** `/src/app`
- **Components:** `/src/components/ui` for the Design System.
- **Lib:** Setup `utils.ts` for helper functions.

### Backend & Database
- **Supabase:** Initialize project.
- **FastAPI:** Create basic "Health Check" endpoint to verify Python env.

## 4. Deliverables & Acceptance Criteria
- [ ] Next.js + Tailwind + TypeScript project running.
- [ ] Design System variables defined in `tailwind.config.ts`.
- [ ] Reusable Button and Card components created.
- [ ] Supabase connection verified.
- [ ] Repository set up with `main` and `dev` branches.

## 5. Connection to Next Phase
Phase 1 builds the **"skeleton"**. Phase 2 will plug in the **Authentication** logic that will be triggered by the Login buttons defined in **Phase 0**.
