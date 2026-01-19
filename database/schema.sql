-- Institute Management SaaS Database Schema
-- Multi-tenant architecture with Row Level Security (RLS)

-- Enable necessary extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- =============================================
-- CORE TABLES
-- =============================================

-- Schools/Institutes table (Each school is a tenant)
CREATE TABLE schools (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    logo_url TEXT,
    subscription_plan VARCHAR(50) DEFAULT 'basic', -- 'basic', 'pro'
    subscription_status VARCHAR(50) DEFAULT 'inactive', -- 'active', 'inactive', 'suspended'
    subscription_expires_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- School admins (Users who manage schools)
CREATE TABLE school_admins (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    school_id UUID REFERENCES schools(id) ON DELETE CASCADE,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    email VARCHAR(255) NOT NULL,
    full_name VARCHAR(255),
    role VARCHAR(50) DEFAULT 'admin', -- 'admin', 'teacher'
    is_primary BOOLEAN DEFAULT FALSE, -- Primary admin who signed up
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(school_id, user_id)
);

-- Batches/Classes
CREATE TABLE batches (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    school_id UUID REFERENCES schools(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    start_date DATE,
    end_date DATE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Students
CREATE TABLE students (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    school_id UUID REFERENCES schools(id) ON DELETE CASCADE,
    batch_id UUID REFERENCES batches(id) ON DELETE SET NULL,
    student_id VARCHAR(50), -- Custom student ID
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(20),
    parent_name VARCHAR(255),
    parent_phone VARCHAR(20),
    parent_email VARCHAR(255),
    address TEXT,
    date_of_birth DATE,
    admission_date DATE DEFAULT CURRENT_DATE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(school_id, student_id)
);

-- Attendance records
CREATE TABLE attendance (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    school_id UUID REFERENCES schools(id) ON DELETE CASCADE,
    student_id UUID REFERENCES students(id) ON DELETE CASCADE,
    batch_id UUID REFERENCES batches(id) ON DELETE CASCADE,
    date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'present', -- 'present', 'absent', 'late'
    marked_by UUID REFERENCES school_admins(id),
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(student_id, date)
);

-- Announcements
CREATE TABLE announcements (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    school_id UUID REFERENCES schools(id) ON DELETE CASCADE,
    batch_id UUID REFERENCES batches(id) ON DELETE SET NULL, -- NULL means for all batches
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    created_by UUID REFERENCES school_admins(id),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Academic content/assignments
CREATE TABLE academic_content (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    school_id UUID REFERENCES schools(id) ON DELETE CASCADE,
    batch_id UUID REFERENCES batches(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    content_type VARCHAR(50) DEFAULT 'assignment', -- 'assignment', 'material', 'homework'
    file_url TEXT,
    due_date DATE,
    created_by UUID REFERENCES school_admins(id),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- =============================================
-- PLATFORM ADMIN TABLES
-- =============================================

-- Platform admins (Super admins who manage the SaaS)
CREATE TABLE platform_admins (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    email VARCHAR(255) UNIQUE NOT NULL,
    full_name VARCHAR(255),
    role VARCHAR(50) DEFAULT 'super_admin',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- =============================================
-- ROW LEVEL SECURITY (RLS) POLICIES
-- =============================================

-- Enable RLS on all tables
ALTER TABLE schools ENABLE ROW LEVEL SECURITY;
ALTER TABLE school_admins ENABLE ROW LEVEL SECURITY;
ALTER TABLE batches ENABLE ROW LEVEL SECURITY;
ALTER TABLE students ENABLE ROW LEVEL SECURITY;
ALTER TABLE attendance ENABLE ROW LEVEL SECURITY;
ALTER TABLE announcements ENABLE ROW LEVEL SECURITY;
ALTER TABLE academic_content ENABLE ROW LEVEL SECURITY;
ALTER TABLE platform_admins ENABLE ROW LEVEL SECURITY;

-- Schools policies
CREATE POLICY "Schools can view own data" ON schools
    FOR SELECT USING (
        id IN (
            SELECT school_id FROM school_admins 
            WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Schools can update own data" ON schools
    FOR UPDATE USING (
        id IN (
            SELECT school_id FROM school_admins 
            WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Anyone can create a school" ON schools
    FOR INSERT WITH CHECK (true);

CREATE POLICY "Platform admins can view all schools" ON schools
    FOR ALL USING (
        auth.uid() IN (SELECT user_id FROM platform_admins)
    );

-- School admins policies
CREATE POLICY "School admins can view own school data" ON school_admins
    FOR SELECT USING (
        school_id IN (
            SELECT school_id FROM school_admins 
            WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "School admins can update own school data" ON school_admins
    FOR UPDATE USING (
        school_id IN (
            SELECT school_id FROM school_admins 
            WHERE user_id = auth.uid()
        )
    );

CREATE POLICY "Anyone can create school admin for themselves" ON school_admins
    FOR INSERT WITH CHECK (user_id = auth.uid());

CREATE POLICY "Platform admins can view all school admins" ON school_admins
    FOR ALL USING (
        auth.uid() IN (SELECT user_id FROM platform_admins)
    );

-- Batches policies
CREATE POLICY "School admins can manage own school batches" ON batches
    FOR ALL USING (
        school_id IN (
            SELECT school_id FROM school_admins 
            WHERE user_id = auth.uid()
        )
    );

-- Students policies
CREATE POLICY "School admins can manage own school students" ON students
    FOR ALL USING (
        school_id IN (
            SELECT school_id FROM school_admins 
            WHERE user_id = auth.uid()
        )
    );

-- Attendance policies
CREATE POLICY "School admins can manage own school attendance" ON attendance
    FOR ALL USING (
        school_id IN (
            SELECT school_id FROM school_admins 
            WHERE user_id = auth.uid()
        )
    );

-- Announcements policies
CREATE POLICY "School admins can manage own school announcements" ON announcements
    FOR ALL USING (
        school_id IN (
            SELECT school_id FROM school_admins 
            WHERE user_id = auth.uid()
        )
    );

-- Academic content policies
CREATE POLICY "School admins can manage own school content" ON academic_content
    FOR ALL USING (
        school_id IN (
            SELECT school_id FROM school_admins 
            WHERE user_id = auth.uid()
        )
    );

-- Platform admins policies
CREATE POLICY "Platform admins can view own data" ON platform_admins
    FOR ALL USING (user_id = auth.uid());

-- =============================================
-- FUNCTIONS AND TRIGGERS
-- =============================================

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Add updated_at triggers
CREATE TRIGGER update_schools_updated_at BEFORE UPDATE ON schools
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_school_admins_updated_at BEFORE UPDATE ON school_admins
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_batches_updated_at BEFORE UPDATE ON batches
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_students_updated_at BEFORE UPDATE ON students
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_announcements_updated_at BEFORE UPDATE ON announcements
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_academic_content_updated_at BEFORE UPDATE ON academic_content
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- =============================================
-- INDEXES FOR PERFORMANCE
-- =============================================

-- Schools indexes
CREATE INDEX idx_schools_email ON schools(email);
CREATE INDEX idx_schools_subscription_status ON schools(subscription_status);

-- School admins indexes
CREATE INDEX idx_school_admins_school_id ON school_admins(school_id);
CREATE INDEX idx_school_admins_user_id ON school_admins(user_id);

-- Students indexes
CREATE INDEX idx_students_school_id ON students(school_id);
CREATE INDEX idx_students_batch_id ON students(batch_id);
CREATE INDEX idx_students_student_id ON students(school_id, student_id);

-- Batches indexes
CREATE INDEX idx_batches_school_id ON batches(school_id);

-- Attendance indexes
CREATE INDEX idx_attendance_student_date ON attendance(student_id, date);
CREATE INDEX idx_attendance_school_date ON attendance(school_id, date);
CREATE INDEX idx_attendance_batch_date ON attendance(batch_id, date);

-- Announcements indexes
CREATE INDEX idx_announcements_school_id ON announcements(school_id);
CREATE INDEX idx_announcements_batch_id ON announcements(batch_id);
CREATE INDEX idx_announcements_created_at ON announcements(created_at DESC);

-- Academic content indexes
CREATE INDEX idx_academic_content_school_id ON academic_content(school_id);
CREATE INDEX idx_academic_content_batch_id ON academic_content(batch_id);

-- =============================================
-- SAMPLE DATA (Optional - for development)
-- =============================================

-- Insert sample platform admin (replace with your actual email)
-- INSERT INTO platform_admins (user_id, email, full_name) 
-- VALUES ('your-auth-user-id', 'admin@institutesaas.com', 'Platform Admin');