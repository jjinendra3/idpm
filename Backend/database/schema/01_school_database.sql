-- School Database Schema
-- This database contains all school-related data for grades K-12

CREATE DATABASE IF NOT EXISTS school_db;
USE school_db;

-- Company information (shared between school and college)
CREATE TABLE company (
    company_id INT PRIMARY KEY AUTO_INCREMENT,
    company_name VARCHAR(255) NOT NULL,
    founded_year YEAR,
    headquarters_address TEXT,
    phone VARCHAR(20),
    email VARCHAR(100),
    website VARCHAR(255),
    tax_id VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- School campus information
CREATE TABLE campuses (
    campus_id INT PRIMARY KEY AUTO_INCREMENT,
    company_id INT NOT NULL,
    campus_name VARCHAR(255) NOT NULL,
    address TEXT,
    city VARCHAR(100),
    state VARCHAR(50),
    zip_code VARCHAR(10),
    phone VARCHAR(20),
    principal_name VARCHAR(255),
    capacity INT,
    established_year YEAR,
    campus_type ENUM('elementary', 'middle', 'high', 'combined') NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (company_id) REFERENCES company(company_id),
    INDEX idx_campus_type (campus_type),
    INDEX idx_company_campus (company_id, campus_id)
);

-- Departments within schools
CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    campus_id INT NOT NULL,
    department_name VARCHAR(255) NOT NULL,
    department_code VARCHAR(10) UNIQUE,
    head_teacher_id INT NULL, -- Will be set after teachers table
    budget DECIMAL(12,2),
    description TEXT,
    floor_number INT,
    room_numbers JSON, -- Array of room numbers
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (campus_id) REFERENCES campuses(campus_id),
    INDEX idx_dept_campus (campus_id)
);

-- Academic years and terms
CREATE TABLE academic_years (
    academic_year_id INT PRIMARY KEY AUTO_INCREMENT,
    year_name VARCHAR(20) NOT NULL, -- e.g., "2023-2024"
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    is_current BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_current_year (is_current),
    CHECK (end_date > start_date)
);

CREATE TABLE terms (
    term_id INT PRIMARY KEY AUTO_INCREMENT,
    academic_year_id INT NOT NULL,
    term_name VARCHAR(50) NOT NULL, -- e.g., "Fall", "Spring", "Summer"
    term_number INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    is_current BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (academic_year_id) REFERENCES academic_years(academic_year_id),
    UNIQUE KEY unique_year_term (academic_year_id, term_number),
    CHECK (end_date > start_date)
);

-- Grades/Classes in school
CREATE TABLE grades (
    grade_id INT PRIMARY KEY AUTO_INCREMENT,
    grade_level VARCHAR(10) NOT NULL, -- K, 1, 2, ..., 12
    grade_name VARCHAR(50), -- "Kindergarten", "First Grade", etc.
    sort_order INT,
    min_age INT,
    max_age INT,
    INDEX idx_grade_level (grade_level)
);

-- Teachers and staff
CREATE TABLE teachers (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id VARCHAR(20) UNIQUE NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100),
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(20),
    address TEXT,
    city VARCHAR(100),
    state VARCHAR(50),
    zip_code VARCHAR(10),
    date_of_birth DATE,
    hire_date DATE NOT NULL,
    termination_date DATE NULL,
    salary DECIMAL(10,2),
    department_id INT,
    campus_id INT NOT NULL,
    position_title VARCHAR(255),
    employment_status ENUM('full_time', 'part_time', 'contract', 'substitute') DEFAULT 'full_time',
    education_level ENUM('bachelor', 'master', 'doctorate', 'other'),
    certifications JSON, -- Array of certifications
    emergency_contact_name VARCHAR(255),
    emergency_contact_phone VARCHAR(20),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (campus_id) REFERENCES campuses(campus_id),
    INDEX idx_teacher_campus (campus_id),
    INDEX idx_teacher_dept (department_id),
    INDEX idx_teacher_status (employment_status, is_active)
);

-- Add foreign key constraint for department head
ALTER TABLE departments 
ADD CONSTRAINT fk_dept_head_teacher 
FOREIGN KEY (head_teacher_id) REFERENCES teachers(teacher_id);

-- Subjects
CREATE TABLE subjects (
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_code VARCHAR(20) UNIQUE NOT NULL,
    subject_name VARCHAR(255) NOT NULL,
    description TEXT,
    department_id INT,
    credits DECIMAL(3,2) DEFAULT 1.00,
    is_core_subject BOOLEAN DEFAULT FALSE,
    grade_levels JSON, -- Array of applicable grade levels
    prerequisites JSON, -- Array of prerequisite subject_ids
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    INDEX idx_subject_dept (department_id),
    INDEX idx_subject_core (is_core_subject)
);

-- Students
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_number VARCHAR(20) UNIQUE NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100),
    email VARCHAR(255),
    date_of_birth DATE NOT NULL,
    gender ENUM('male', 'female', 'other', 'prefer_not_to_say'),
    address TEXT,
    city VARCHAR(100),
    state VARCHAR(50),
    zip_code VARCHAR(10),
    phone VARCHAR(20),
    current_grade_id INT,
    campus_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    graduation_date DATE NULL,
    status ENUM('active', 'inactive', 'graduated', 'transferred', 'expelled') DEFAULT 'active',
    parent_guardian_1_name VARCHAR(255),
    parent_guardian_1_phone VARCHAR(20),
    parent_guardian_1_email VARCHAR(255),
    parent_guardian_1_relationship ENUM('father', 'mother', 'guardian', 'other'),
    parent_guardian_2_name VARCHAR(255),
    parent_guardian_2_phone VARCHAR(20),
    parent_guardian_2_email VARCHAR(255),
    parent_guardian_2_relationship ENUM('father', 'mother', 'guardian', 'other'),
    emergency_contact_name VARCHAR(255),
    emergency_contact_phone VARCHAR(20),
    medical_conditions TEXT,
    allergies TEXT,
    special_needs TEXT,
    transportation_method ENUM('bus', 'car', 'walk', 'bike', 'other'),
    lunch_program ENUM('free', 'reduced', 'paid', 'none'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (current_grade_id) REFERENCES grades(grade_id),
    FOREIGN KEY (campus_id) REFERENCES campuses(campus_id),
    INDEX idx_student_campus_grade (campus_id, current_grade_id),
    INDEX idx_student_status (status),
    INDEX idx_student_enrollment (enrollment_date)
);

-- Classes/Sections
CREATE TABLE classes (
    class_id INT PRIMARY KEY AUTO_INCREMENT,
    class_code VARCHAR(20) UNIQUE NOT NULL,
    class_name VARCHAR(255) NOT NULL,
    subject_id INT NOT NULL,
    teacher_id INT NOT NULL,
    campus_id INT NOT NULL,
    grade_id INT NOT NULL,
    term_id INT NOT NULL,
    room_number VARCHAR(20),
    max_students INT DEFAULT 30,
    current_enrollment INT DEFAULT 0,
    schedule_time TIME,
    schedule_days JSON, -- Array of days: ["monday", "tuesday", etc.]
    start_date DATE,
    end_date DATE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id),
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id),
    FOREIGN KEY (campus_id) REFERENCES campuses(campus_id),
    FOREIGN KEY (grade_id) REFERENCES grades(grade_id),
    FOREIGN KEY (term_id) REFERENCES terms(term_id),
    INDEX idx_class_teacher (teacher_id),
    INDEX idx_class_campus_grade (campus_id, grade_id),
    INDEX idx_class_term (term_id),
    CHECK (current_enrollment <= max_students)
);

-- Student enrollments in classes
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    class_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    drop_date DATE NULL,
    final_grade VARCHAR(5),
    grade_points DECIMAL(3,2),
    attendance_percentage DECIMAL(5,2),
    status ENUM('enrolled', 'dropped', 'completed', 'failed') DEFAULT 'enrolled',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (class_id) REFERENCES classes(class_id),
    UNIQUE KEY unique_student_class (student_id, class_id),
    INDEX idx_enrollment_student (student_id),
    INDEX idx_enrollment_class (class_id),
    INDEX idx_enrollment_status (status)
);

-- Assignments and assessments
CREATE TABLE assignments (
    assignment_id INT PRIMARY KEY AUTO_INCREMENT,
    class_id INT NOT NULL,
    assignment_name VARCHAR(255) NOT NULL,
    description TEXT,
    assignment_type ENUM('homework', 'quiz', 'test', 'project', 'presentation', 'other') NOT NULL,
    total_points DECIMAL(6,2) NOT NULL,
    due_date DATETIME,
    assigned_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_extra_credit BOOLEAN DEFAULT FALSE,
    weight DECIMAL(3,2) DEFAULT 1.00, -- For weighted grading
    rubric JSON, -- Grading rubric details
    instructions TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (class_id) REFERENCES classes(class_id),
    INDEX idx_assignment_class (class_id),
    INDEX idx_assignment_due_date (due_date),
    INDEX idx_assignment_type (assignment_type)
);

-- Student assignment submissions and grades
CREATE TABLE assignment_submissions (
    submission_id INT PRIMARY KEY AUTO_INCREMENT,
    assignment_id INT NOT NULL,
    student_id INT NOT NULL,
    submission_date DATETIME,
    points_earned DECIMAL(6,2),
    letter_grade VARCHAR(5),
    feedback TEXT,
    is_late BOOLEAN DEFAULT FALSE,
    late_penalty DECIMAL(5,2) DEFAULT 0.00,
    attempts INT DEFAULT 1,
    status ENUM('not_submitted', 'submitted', 'graded', 'returned') DEFAULT 'not_submitted',
    file_path VARCHAR(500), -- Path to submitted file
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (assignment_id) REFERENCES assignments(assignment_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    UNIQUE KEY unique_student_assignment (student_id, assignment_id),
    INDEX idx_submission_assignment (assignment_id),
    INDEX idx_submission_student (student_id),
    INDEX idx_submission_status (status)
);

-- Attendance tracking
CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    class_id INT NOT NULL,
    attendance_date DATE NOT NULL,
    status ENUM('present', 'absent', 'tardy', 'excused') NOT NULL,
    arrival_time TIME,
    departure_time TIME,
    notes TEXT,
    marked_by_teacher_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (class_id) REFERENCES classes(class_id),
    FOREIGN KEY (marked_by_teacher_id) REFERENCES teachers(teacher_id),
    UNIQUE KEY unique_student_class_date (student_id, class_id, attendance_date),
    INDEX idx_attendance_student_date (student_id, attendance_date),
    INDEX idx_attendance_class_date (class_id, attendance_date),
    INDEX idx_attendance_status (status)
);

-- Disciplinary incidents
CREATE TABLE disciplinary_incidents (
    incident_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    reported_by_teacher_id INT NOT NULL,
    incident_date DATETIME NOT NULL,
    location VARCHAR(255),
    incident_type ENUM('tardiness', 'absence', 'disruption', 'fighting', 'vandalism', 'cheating', 'other') NOT NULL,
    severity ENUM('minor', 'major', 'severe') NOT NULL,
    description TEXT NOT NULL,
    action_taken TEXT,
    parent_contacted BOOLEAN DEFAULT FALSE,
    parent_contact_date DATETIME,
    follow_up_required BOOLEAN DEFAULT FALSE,
    follow_up_date DATE,
    resolved BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (reported_by_teacher_id) REFERENCES teachers(teacher_id),
    INDEX idx_incident_student (student_id),
    INDEX idx_incident_date (incident_date),
    INDEX idx_incident_type_severity (incident_type, severity),
    INDEX idx_incident_resolved (resolved)
);

-- Library books and resources
CREATE TABLE library_books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    isbn VARCHAR(20) UNIQUE,
    title VARCHAR(500) NOT NULL,
    author VARCHAR(255),
    publisher VARCHAR(255),
    publication_year YEAR,
    genre VARCHAR(100),
    reading_level VARCHAR(20),
    total_copies INT NOT NULL DEFAULT 1,
    available_copies INT NOT NULL DEFAULT 1,
    location VARCHAR(100), -- Shelf location
    condition_status ENUM('excellent', 'good', 'fair', 'poor', 'damaged') DEFAULT 'good',
    purchase_date DATE,
    purchase_price DECIMAL(8,2),
    is_digital BOOLEAN DEFAULT FALSE,
    digital_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_book_title (title(100)),
    INDEX idx_book_author (author),
    INDEX idx_book_isbn (isbn),
    INDEX idx_book_genre_level (genre, reading_level),
    CHECK (available_copies <= total_copies)
);

-- Library book checkouts
CREATE TABLE book_checkouts (
    checkout_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT NOT NULL,
    student_id INT NOT NULL,
    checkout_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE NULL,
    fine_amount DECIMAL(6,2) DEFAULT 0.00,
    status ENUM('checked_out', 'returned', 'overdue', 'lost') DEFAULT 'checked_out',
    notes TEXT,
    checked_out_by_teacher_id INT,
    returned_to_teacher_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (book_id) REFERENCES library_books(book_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (checked_out_by_teacher_id) REFERENCES teachers(teacher_id),
    FOREIGN KEY (returned_to_teacher_id) REFERENCES teachers(teacher_id),
    INDEX idx_checkout_student (student_id),
    INDEX idx_checkout_book (book_id),
    INDEX idx_checkout_status_due (status, due_date),
    CHECK (due_date >= checkout_date)
);

-- School events and activities
CREATE TABLE school_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    campus_id INT NOT NULL,
    event_name VARCHAR(255) NOT NULL,
    description TEXT,
    event_type ENUM('academic', 'sports', 'arts', 'social', 'fundraising', 'meeting', 'other') NOT NULL,
    start_datetime DATETIME NOT NULL,
    end_datetime DATETIME,
    location VARCHAR(255),
    organizer_teacher_id INT,
    max_participants INT,
    current_participants INT DEFAULT 0,
    cost DECIMAL(8,2) DEFAULT 0.00,
    is_mandatory BOOLEAN DEFAULT FALSE,
    grade_restrictions JSON, -- Array of grade_ids that can participate
    requires_permission BOOLEAN DEFAULT FALSE,
    status ENUM('planned', 'active', 'completed', 'cancelled') DEFAULT 'planned',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (campus_id) REFERENCES campuses(campus_id),
    FOREIGN KEY (organizer_teacher_id) REFERENCES teachers(teacher_id),
    INDEX idx_event_campus_date (campus_id, start_datetime),
    INDEX idx_event_type (event_type),
    INDEX idx_event_status (status),
    CHECK (end_datetime IS NULL OR end_datetime >= start_datetime)
);

-- Student participation in events
CREATE TABLE event_participants (
    participation_id INT PRIMARY KEY AUTO_INCREMENT,
    event_id INT NOT NULL,
    student_id INT NOT NULL,
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    attendance_status ENUM('registered', 'attended', 'no_show', 'cancelled') DEFAULT 'registered',
    permission_form_received BOOLEAN DEFAULT FALSE,
    payment_status ENUM('not_required', 'pending', 'paid', 'refunded') DEFAULT 'not_required',
    notes TEXT,
    FOREIGN KEY (event_id) REFERENCES school_events(event_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    UNIQUE KEY unique_student_event (student_id, event_id),
    INDEX idx_participant_event (event_id),
    INDEX idx_participant_student (student_id)
);

-- Transportation (school buses)
CREATE TABLE buses (
    bus_id INT PRIMARY KEY AUTO_INCREMENT,
    bus_number VARCHAR(20) UNIQUE NOT NULL,
    license_plate VARCHAR(20),
    driver_name VARCHAR(255),
    driver_phone VARCHAR(20),
    capacity INT NOT NULL,
    current_riders INT DEFAULT 0,
    route_description TEXT,
    morning_route_start_time TIME,
    afternoon_route_start_time TIME,
    is_active BOOLEAN DEFAULT TRUE,
    maintenance_due_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_bus_number (bus_number),
    INDEX idx_bus_driver (driver_name),
    CHECK (current_riders <= capacity)
);

-- Student bus assignments
CREATE TABLE student_transportation (
    transport_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    bus_id INT NOT NULL,
    pickup_location VARCHAR(255),
    pickup_time TIME,
    dropoff_location VARCHAR(255),
    dropoff_time TIME,
    effective_date DATE NOT NULL,
    end_date DATE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (bus_id) REFERENCES buses(bus_id),
    INDEX idx_transport_student (student_id),
    INDEX idx_transport_bus (bus_id),
    INDEX idx_transport_active (is_active, effective_date)
);

-- Create indexes for better performance
CREATE INDEX idx_students_fullname ON students(last_name, first_name);
CREATE INDEX idx_teachers_fullname ON teachers(last_name, first_name);
CREATE INDEX idx_classes_schedule ON classes(schedule_time, schedule_days(1));
CREATE INDEX idx_assignments_due_class ON assignments(class_id, due_date);

-- Create views for common queries
CREATE VIEW active_students AS
SELECT s.*, g.grade_level, c.campus_name
FROM students s
JOIN grades g ON s.current_grade_id = g.grade_id
JOIN campuses c ON s.campus_id = c.campus_id
WHERE s.status = 'active';

CREATE VIEW teacher_workload AS
SELECT 
    t.teacher_id,
    CONCAT(t.first_name, ' ', t.last_name) AS teacher_name,
    t.department_id,
    COUNT(cl.class_id) AS classes_taught,
    SUM(cl.current_enrollment) AS total_students,
    AVG(cl.current_enrollment) AS avg_class_size
FROM teachers t
LEFT JOIN classes cl ON t.teacher_id = cl.teacher_id AND cl.is_active = TRUE
WHERE t.is_active = TRUE
GROUP BY t.teacher_id, t.first_name, t.last_name, t.department_id;

CREATE VIEW student_grades_summary AS
SELECT 
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    COUNT(e.enrollment_id) AS total_classes,
    AVG(e.grade_points) AS gpa,
    SUM(CASE WHEN e.status = 'completed' THEN 1 ELSE 0 END) AS completed_classes,
    SUM(CASE WHEN e.status = 'failed' THEN 1 ELSE 0 END) AS failed_classes
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
WHERE s.status = 'active'
GROUP BY s.student_id, s.first_name, s.last_name;