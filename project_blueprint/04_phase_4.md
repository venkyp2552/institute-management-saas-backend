# Phase 4: Communication & Student Engagement

## 1. Goal & Objectives
**Goal:** Improve engagement by enabling digital communication (Announcements) and academic resource sharing.
**Focus:** Announcements, Assignments, and Dashboard Widgets.

## 2. Features & Components
### 2.1 Communication Module (Announcements)
- **Create Announcement:**
    - Title, Message Body (Rich Text or multi-line plain text).
    - Target: "All School" or "Specific Batch".
- **View Announcements:**
    - **Dashboard Widget:** "Latest Updates" section on the School Admin Dashboard.
    - **Full List:** Dedicated page/modal to see history.

### 2.2 Academic Content & Assignments
- **Create Assignment:**
    - Title, Description, Due Date.
    - **File Attachment:** PDF/Image upload for reference material.
- **Frontend:** Upload file -> Receive URL -> Save Assignment.
- **Backend (FastAPI):**
    - `POST /upload/assignment`: Accepts file, validates type (PDF/IMG), saves to storage, returns URL.

### 2.3 Dashboard Enhancements
- **Widgets:**
    - "Today's Attendance": Summary count.
    - "Recent Announcements": Top 3 list.
    - "Batch Stats": Total active batches.

## 3. Technical Implementation Details
### Database
- `announcements`: `id`, `school_id`, `title`, `message`, `target_batch_id` (nullable).
- `assignments`: `id`, `school_id`, `batch_id`, `title`, `file_url`, `due_date`.

### API & Backend
- **FastAPI Service:**
    - Expand the `Upload Service` to handle Assignment documents.
    - Implement file size validation (e.g., max 5MB).
- **Supabase Realtime (Optional):**
    - Listen for new `announcements` to show a toast notification to Admin.

### Frontend
- **Rich Text / Text Area:** For announcement body.
- **File Picker:** Custom UI component for selecting files.

## 4. Deliverables & Acceptance Criteria
- [ ] Admin can post an Announcement to a specific batch.
- [ ] Dashboard shows the latest generated Announcement.
- [ ] Admin can create an Assignment and attach a PDF (via FastAPI).
- [ ] Uploaded file is accessible via the returned URL.

## 5. Connection to Next Phase
Phase 4 completes the "Operating System" of the school. Phase 5 handles the critical business aspect: **Payments** (collecting fees or paying for the SaaS) and advanced Media handling.
