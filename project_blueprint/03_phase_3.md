# Phase 3: Administration & Academic Operations

## 1. Goal & Objectives
**Goal:** Enable the School Admin to manage their institute's core entities: Batches, Students, and daily Attendance.
**Focus:** CRUD Operations, Data Relationships, and Daily Workflows.

## 2. Features & Components
### 2.1 School Admin Dashboard
- **Profile Management:**
    - Edit School Name, Address.
    - **Logo Upload:** Integration with **FastAPI** Media Service to upload and store school logos.

### 2.2 Batch (Class) Management
- **List Batches:** Card view of all active batches (e.g., "Class 10 - Science").
- **Create/Edit Batch:** Simple form to define Batch Name, Start Date, Instructor (optional).
- **Backend Logic:** Store in `batches` table, linked to `school_id`.

### 2.3 Student Management
- **Student Directory:** Searchable table of all students.
- **Admissions:** Form to add new Student (Name, Parent Contact, Enrollment #).
- **Batch Assignment:** Assign students to specific batches (Many-to-Many relationship).

### 2.4 Attendance Module
- **Mark Attendance:**
    1. Select Batch.
    2. View list of students in that batch.
    3. Toggle "Present/Absent" (Defualt: Present).
    4. Save for specific date.
- **View Attendance:** Calendar view or List view of past records.

## 3. Technical Implementation Details
### Frontend (Next.js)
- **State Management:** React Query (TanStack Query) for fetching lists of Batches/Students.
- **Forms:** React Hook Form + Zod for validation.
- **UI Components:** Data Table with pagination, Modals for "Add Student".

### Backend (Supabase & FastAPI)
- **Standard CRUD:** Use **Next.js Server Actions** + Supabase Client for standard Batch/Student data.
- **Media Uploads:**
    - Frontend sends file to **FastAPI** endpoint `/upload/logo`.
    - FastAPI saves to storage (Supabase Storage or disk) and returns URL.
    - Frontend saves URL to `schools` table.

### Database Schema
- `batches`: `id`, `school_id`, `name`, `created_at`.
- `students`: `id`, `school_id`, `name`, `email`, `phone`.
- `student_batches`: Junction table for mapping.
- `attendance`: `id`, `student_id`, `batch_id`, `date`, `status`, `school_id`.

## 4. Deliverables & Acceptance Criteria
- [ ] School Admin can update School Name & Logo (FastAPI test).
- [ ] Admin can Create, Edit, and Delete Batches.
- [ ] Admin can Add Students and assign them to Batches.
- [ ] Admin can Mark Attendance for a batch and save it.
- [ ] Data remains isolated (School A cannot see School B's batches).

## 5. Connection to Next Phase
Phase 3 covers the "Daily Admin Work". Phase 4 will introduce **Communication** (Announcements) and expand the user experience to be more engaging.
