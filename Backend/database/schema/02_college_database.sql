-- College Database Schema
-- This database contains all college/university-related data

CREATE DATABASE IF NOT EXISTS college_db;
USE college_db;

-- Company information (shared between school and college)
-- This mirrors the company table from school database
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

-- College campuses
CREATE TABLE campuses (
    campus_id INT PRIMARY KEY AUTO_INCREMENT,
    company_id INT NOT NULL,
    campus_name VARCHAR(255) NOT NULL,
    address TEXT,
    city VARCHAR(100),
    state VARCHAR(50),
    zip_code VARCHAR(10),
    phone VARCHAR(20),
    president_name VARCHAR(255),
    dean_name VARCHAR(255),
    total_capacity INT,
    current_enrollment INT DEFAULT 0,
    established_year YEAR,
    campus_type ENUM('main', 'branch', 'satellite', 'online') NOT NULL,
    accreditation VARCHAR(255),
    ranking INT,
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (company_id) REFERENCES company(company_id),
    INDEX idx_campus_type (campus_type),
    INDEX idx_company_campus (company_id, campus_id),
    CHECK (current_enrollment <= total_capacity)
);

-- Colleges within university (like School of Engineering, School of Medicine)
CREATE TABLE colleges (
    college_id INT PRIMARY KEY AUTO_INCREMENT,
    campus_id INT NOT NULL,
    college_name VARCHAR(255) NOT NULL,
    college_code VARCHAR(10) UNIQUE,
    dean_id INT NULL, -- Will be set after faculty table
    established_year YEAR,
    description TEXT,
    building_names JSON, -- Array of building names
    total_faculty INT DEFAULT 0,
    total_students INT DEFAULT 0,
    budget DECIMAL(15,2),
    accreditation VARCHAR(255),
    website VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (campus_id) REFERENCES campuses(campus_id),
    INDEX idx_college_campus (campus_id)
);

-- Departments within colleges
CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    college_id INT NOT NULL,
    department_name VARCHAR(255) NOT NULL,
    department_code VARCHAR(20) UNIQUE,
    chair_id INT NULL, -- Will be set after faculty table
    description TEXT,
    research_areas JSON, -- Array of research focus areas
    building_name VARCHAR(255),
    floor_number INT,
    office_numbers JSON, -- Array of office numbers
    budget DECIMAL(12,2),
    total_faculty INT DEFAULT 0,
    total_students INT DEFAULT 0,
    website VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (college_id) REFERENCES colleges(college_id),
    INDEX idx_dept_college (college_id)
);

-- Academic years and semesters
CREATE TABLE academic_years (
    academic_year_id INT PRIMARY KEY AUTO_INCREMENT,
    year_name VARCHAR(20) NOT NULL, -- e.g., "2023-2024"
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    is_current BOOLEAN DEFAULT FALSE,
    tuition_rate DECIMAL(10,2), -- Base tuition per credit hour
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_current_year (is_current),
    CHECK (end_date > start_date)
);

CREATE TABLE semesters (
    semester_id INT PRIMARY KEY AUTO_INCREMENT,
    academic_year_id INT NOT NULL,
    semester_name VARCHAR(50) NOT NULL, -- e.g., "Fall", "Spring", "Summer"
    semester_number INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    registration_start_date DATE,
    registration_end_date DATE,
    add_drop_deadline DATE,
    withdrawal_deadline DATE,
    final_exams_start_date DATE,
    final_exams_end_date DATE,
    is_current BOOLEAN DEFAULT FALSE,
    max_credit_hours INT DEFAULT 18,
    FOREIGN KEY (academic_year_id) REFERENCES academic_years(academic_year_id),
    UNIQUE KEY unique_year_semester (academic_year_id, semester_number),
    CHECK (end_date > start_date),
    CHECK (registration_end_date >= registration_start_date)
);

-- Degree programs
CREATE TABLE degree_programs (
    program_id INT PRIMARY KEY AUTO_INCREMENT,
    department_id INT NOT NULL,
    program_name VARCHAR(255) NOT NULL,
    program_code VARCHAR(20) UNIQUE NOT NULL,
    degree_type ENUM('associate', 'bachelor', 'master', 'doctorate', 'certificate') NOT NULL,
    degree_title VARCHAR(255), -- e.g., "Bachelor of Science in Computer Science"
    total_credit_hours INT NOT NULL,
    duration_years DECIMAL(3,1), -- e.g., 2.0, 4.0, 1.5
    description TEXT,
    admission_requirements TEXT,
    career_outcomes TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    INDEX idx_program_dept (department_id),
    INDEX idx_program_type (degree_type),
    INDEX idx_program_active (is_active)
);

-- Faculty and staff
CREATE TABLE faculty (
    faculty_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id VARCHAR(20) UNIQUE NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100),
    title VARCHAR(100), -- Prof., Dr., Mr., Ms., etc.
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(20),
    office_location VARCHAR(255),
    address TEXT,
    city VARCHAR(100),
    state VARCHAR(50),
    zip_code VARCHAR(10),
    date_of_birth DATE,
    hire_date DATE NOT NULL,
    termination_date DATE NULL,
    tenure_date DATE NULL,
    salary DECIMAL(12,2),
    department_id INT NOT NULL,
    campus_id INT NOT NULL,
    position_title VARCHAR(255),
    academic_rank ENUM('instructor', 'assistant_professor', 'associate_professor', 'professor', 'emeritus') NOT NULL,
    employment_status ENUM('full_time', 'part_time', 'adjunct', 'visiting', 'emeritus') DEFAULT 'full_time',
    education_background JSON, -- Array of degrees with institutions
    research_interests JSON, -- Array of research areas
    publications_count INT DEFAULT 0,
    office_hours JSON, -- Array of office hour schedules
    biography TEXT,
    website VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (campus_id) REFERENCES campuses(campus_id),
    INDEX idx_faculty_campus (campus_id),
    INDEX idx_faculty_dept (department_id),
    INDEX idx_faculty_rank (academic_rank),
    INDEX idx_faculty_status (employment_status, is_active)
);

-- Add foreign key constraints for department chairs and college deans
ALTER TABLE departments 
ADD CONSTRAINT fk_dept_chair_faculty 
FOREIGN KEY (chair_id) REFERENCES faculty(faculty_id);

ALTER TABLE colleges 
ADD CONSTRAINT fk_college_dean_faculty 
FOREIGN KEY (dean_id) REFERENCES faculty(faculty_id);

-- Courses
CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    course_title VARCHAR(255) NOT NULL,
    description TEXT,
    department_id INT NOT NULL,
    credit_hours INT NOT NULL DEFAULT 3,
    lecture_hours DECIMAL(3,1),
    lab_hours DECIMAL(3,1),
    prerequisites JSON, -- Array of prerequisite course_ids
    corequisites JSON, -- Array of corequisite course_ids
    course_level ENUM('undergraduate', 'graduate', 'both') NOT NULL,
    difficulty_level INT CHECK (difficulty_level BETWEEN 1 AND 5),
    max_enrollment INT,
    is_active BOOLEAN DEFAULT TRUE,
    syllabus_url VARCHAR(500),
    learning_outcomes TEXT,
    assessment_methods TEXT,
    required_textbooks JSON, -- Array of textbook information
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    INDEX idx_course_dept (department_id),
    INDEX idx_course_level (course_level),
    INDEX idx_course_active (is_active),
    INDEX idx_course_credit (credit_hours)
);

-- Students
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_number VARCHAR(20) UNIQUE NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100),
    preferred_name VARCHAR(100),
    email VARCHAR(255) UNIQUE,
    date_of_birth DATE NOT NULL,
    gender ENUM('male', 'female', 'other', 'prefer_not_to_say'),
    address TEXT,
    city VARCHAR(100),
    state VARCHAR(50),
    zip_code VARCHAR(10),
    country VARCHAR(100),
    phone VARCHAR(20),
    emergency_contact_name VARCHAR(255),
    emergency_contact_phone VARCHAR(20),
    emergency_contact_relationship VARCHAR(50),
    program_id INT,
    campus_id INT NOT NULL,
    admission_date DATE NOT NULL,
    expected_graduation_date DATE,
    actual_graduation_date DATE,
    graduation_status ENUM('enrolled', 'graduated', 'withdrawn', 'suspended', 'transferred') DEFAULT 'enrolled',
    student_type ENUM('freshman', 'sophomore', 'junior', 'senior', 'graduate', 'doctoral') NOT NULL,
    enrollment_status ENUM('full_time', 'part_time', 'audit') DEFAULT 'full_time',
    residency_status ENUM('in_state', 'out_of_state', 'international') NOT NULL,
    gpa DECIMAL(3,2) DEFAULT 0.00,
    total_credit_hours INT DEFAULT 0,
    completed_credit_hours INT DEFAULT 0,
    academic_standing ENUM('good', 'probation', 'suspension', 'dismissal') DEFAULT 'good',
    advisor_faculty_id INT,
    financial_aid_eligible BOOLEAN DEFAULT FALSE,
    work_study_eligible BOOLEAN DEFAULT FALSE,
    housing_status ENUM('on_campus', 'off_campus', 'commuter') NOT NULL,
    dietary_restrictions TEXT,
    medical_conditions TEXT,
    disabilities TEXT,
    veteran_status BOOLEAN DEFAULT FALSE,
    first_generation_college BOOLEAN DEFAULT FALSE,
    ethnicity VARCHAR(100),
    religion VARCHAR(100),
    marital_status ENUM('single', 'married', 'divorced', 'widowed'),
    social_security_number VARCHAR(11), -- Encrypted in real implementation
    passport_number VARCHAR(20),
    visa_status VARCHAR(50),
    previous_school_name VARCHAR(255), -- Link to school database
    previous_school_id INT, -- Reference to school database student_id
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (program_id) REFERENCES degree_programs(program_id),
    FOREIGN KEY (campus_id) REFERENCES campuses(campus_id),
    FOREIGN KEY (advisor_faculty_id) REFERENCES faculty(faculty_id),
    INDEX idx_student_program (program_id),
    INDEX idx_student_campus (campus_id),
    INDEX idx_student_status (graduation_status, enrollment_status),
    INDEX idx_student_type (student_type),
    INDEX idx_student_advisor (advisor_faculty_id),
    INDEX idx_student_previous_school (previous_school_id),
    CHECK (gpa BETWEEN 0.00 AND 4.00),
    CHECK (completed_credit_hours <= total_credit_hours)
);

-- Course sections (specific instances of courses)
CREATE TABLE course_sections (
    section_id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT NOT NULL,
    semester_id INT NOT NULL,
    section_number VARCHAR(10) NOT NULL,
    faculty_id INT NOT NULL,
    room_location VARCHAR(255),
    max_enrollment INT NOT NULL,
    current_enrollment INT DEFAULT 0,
    waitlist_count INT DEFAULT 0,
    schedule_days JSON, -- Array of days: ["monday", "wednesday", "friday"]
    start_time TIME,
    end_time TIME,
    start_date DATE,
    end_date DATE,
    delivery_method ENUM('in_person', 'online', 'hybrid') DEFAULT 'in_person',
    special_notes TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (semester_id) REFERENCES semesters(semester_id),
    FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id),
    UNIQUE KEY unique_course_semester_section (course_id, semester_id, section_number),
    INDEX idx_section_course (course_id),
    INDEX idx_section_semester (semester_id),
    INDEX idx_section_faculty (faculty_id),
    INDEX idx_section_schedule (start_time, end_time),
    CHECK (current_enrollment <= max_enrollment),
    CHECK (end_time > start_time)
);

-- Student enrollments in course sections
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    section_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    enrollment_type ENUM('regular', 'audit', 'credit_no_credit') DEFAULT 'regular',
    drop_date DATE NULL,
    withdrawal_date DATE NULL,
    final_grade VARCHAR(5), -- A+, A, A-, B+, B, etc.
    grade_points DECIMAL(3,2), -- 4.0 scale
    credit_hours INT,
    status ENUM('enrolled', 'dropped', 'withdrawn', 'completed', 'incomplete', 'failed') DEFAULT 'enrolled',
    midterm_grade VARCHAR(5),
    attendance_percentage DECIMAL(5,2),
    participation_score DECIMAL(5,2),
    notes TEXT,
    tuition_charged DECIMAL(10,2),
    payment_status ENUM('pending', 'paid', 'partial', 'overdue') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (section_id) REFERENCES course_sections(section_id),
    UNIQUE KEY unique_student_section (student_id, section_id),
    INDEX idx_enrollment_student (student_id),
    INDEX idx_enrollment_section (section_id),
    INDEX idx_enrollment_status (status),
    INDEX idx_enrollment_grade (final_grade),
    CHECK (grade_points BETWEEN 0.00 AND 4.00)
);

-- Assignments and assessments
CREATE TABLE assignments (
    assignment_id INT PRIMARY KEY AUTO_INCREMENT,
    section_id INT NOT NULL,
    assignment_name VARCHAR(255) NOT NULL,
    description TEXT,
    assignment_type ENUM('homework', 'quiz', 'exam', 'project', 'presentation', 'paper', 'lab', 'discussion', 'other') NOT NULL,
    total_points DECIMAL(8,2) NOT NULL,
    weight_percentage DECIMAL(5,2), -- Percentage of final grade
    due_date DATETIME,
    assigned_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    late_policy TEXT,
    submission_format ENUM('online', 'paper', 'both', 'presentation') DEFAULT 'online',
    group_assignment BOOLEAN DEFAULT FALSE,
    max_group_size INT DEFAULT 1,
    rubric JSON, -- Detailed grading rubric
    instructions TEXT,
    resources_needed TEXT,
    estimated_hours DECIMAL(4,1), -- Estimated time to complete
    is_extra_credit BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (section_id) REFERENCES course_sections(section_id),
    INDEX idx_assignment_section (section_id),
    INDEX idx_assignment_due_date (due_date),
    INDEX idx_assignment_type (assignment_type),
    INDEX idx_assignment_weight (weight_percentage),
    CHECK (weight_percentage BETWEEN 0.00 AND 100.00)
);

-- Student assignment submissions and grades
CREATE TABLE assignment_submissions (
    submission_id INT PRIMARY KEY AUTO_INCREMENT,
    assignment_id INT NOT NULL,
    student_id INT NOT NULL,
    submission_date DATETIME,
    points_earned DECIMAL(8,2),
    letter_grade VARCHAR(5),
    percentage_score DECIMAL(5,2),
    feedback TEXT,
    is_late BOOLEAN DEFAULT FALSE,
    days_late INT DEFAULT 0,
    late_penalty DECIMAL(5,2) DEFAULT 0.00,
    attempts_count INT DEFAULT 1,
    time_spent_hours DECIMAL(4,1),
    status ENUM('not_submitted', 'submitted', 'graded', 'returned', 'resubmission_requested') DEFAULT 'not_submitted',
    file_path VARCHAR(500), -- Path to submitted file
    plagiarism_score DECIMAL(5,2), -- Percentage similarity
    comments_for_student TEXT,
    graded_by_faculty_id INT,
    graded_date DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (assignment_id) REFERENCES assignments(assignment_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (graded_by_faculty_id) REFERENCES faculty(faculty_id),
    UNIQUE KEY unique_student_assignment (student_id, assignment_id),
    INDEX idx_submission_assignment (assignment_id),
    INDEX idx_submission_student (student_id),
    INDEX idx_submission_status (status),
    INDEX idx_submission_grade (points_earned),
    CHECK (percentage_score BETWEEN 0.00 AND 100.00)
);

-- Attendance tracking
CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    section_id INT NOT NULL,
    class_date DATE NOT NULL,
    status ENUM('present', 'absent', 'tardy', 'excused') NOT NULL,
    arrival_time TIME,
    departure_time TIME,
    minutes_late INT DEFAULT 0,
    notes TEXT,
    marked_by_faculty_id INT,
    participation_points DECIMAL(4,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (section_id) REFERENCES course_sections(section_id),
    FOREIGN KEY (marked_by_faculty_id) REFERENCES faculty(faculty_id),
    UNIQUE KEY unique_student_section_date (student_id, section_id, class_date),
    INDEX idx_attendance_student_date (student_id, class_date),
    INDEX idx_attendance_section_date (section_id, class_date),
    INDEX idx_attendance_status (status)
);

-- Student academic records (transcripts)
CREATE TABLE academic_records (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    semester_id INT NOT NULL,
    semester_gpa DECIMAL(3,2),
    semester_credit_hours INT,
    cumulative_gpa DECIMAL(3,2),
    cumulative_credit_hours INT,
    academic_standing ENUM('good', 'probation', 'suspension', 'dismissal', 'dean_list', 'honor_roll') NOT NULL,
    credits_attempted INT,
    credits_earned INT,
    quality_points DECIMAL(8,2),
    graduation_eligible BOOLEAN DEFAULT FALSE,
    notes TEXT,
    calculated_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (semester_id) REFERENCES semesters(semester_id),
    UNIQUE KEY unique_student_semester (student_id, semester_id),
    INDEX idx_record_student (student_id),
    INDEX idx_record_semester (semester_id),
    INDEX idx_record_standing (academic_standing),
    CHECK (semester_gpa BETWEEN 0.00 AND 4.00),
    CHECK (cumulative_gpa BETWEEN 0.00 AND 4.00),
    CHECK (credits_earned <= credits_attempted)
);

-- Research projects
CREATE TABLE research_projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    project_title VARCHAR(500) NOT NULL,
    description TEXT,
    principal_investigator_id INT NOT NULL,
    department_id INT NOT NULL,
    start_date DATE,
    end_date DATE,
    budget DECIMAL(15,2),
    funding_source VARCHAR(255),
    grant_number VARCHAR(100),
    status ENUM('proposed', 'active', 'completed', 'cancelled', 'on_hold') DEFAULT 'proposed',
    research_area VARCHAR(255),
    publications_count INT DEFAULT 0,
    website VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (principal_investigator_id) REFERENCES faculty(faculty_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    INDEX idx_project_pi (principal_investigator_id),
    INDEX idx_project_dept (department_id),
    INDEX idx_project_status (status),
    INDEX idx_project_dates (start_date, end_date)
);

-- Faculty participation in research projects
CREATE TABLE research_participants (
    participation_id INT PRIMARY KEY AUTO_INCREMENT,
    project_id INT NOT NULL,
    faculty_id INT NOT NULL,
    role ENUM('principal_investigator', 'co_investigator', 'researcher', 'consultant') NOT NULL,
    start_date DATE,
    end_date DATE,
    effort_percentage DECIMAL(5,2), -- Percentage of time dedicated
    salary_support DECIMAL(10,2),
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (project_id) REFERENCES research_projects(project_id),
    FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id),
    UNIQUE KEY unique_project_faculty (project_id, faculty_id),
    INDEX idx_participant_project (project_id),
    INDEX idx_participant_faculty (faculty_id),
    CHECK (effort_percentage BETWEEN 0.00 AND 100.00)
);

-- Student research participation
CREATE TABLE student_research (
    participation_id INT PRIMARY KEY AUTO_INCREMENT,
    project_id INT NOT NULL,
    student_id INT NOT NULL,
    role ENUM('undergraduate_researcher', 'graduate_assistant', 'research_assistant', 'volunteer') NOT NULL,
    start_date DATE,
    end_date DATE,
    hours_per_week DECIMAL(4,1),
    stipend_amount DECIMAL(8,2),
    credit_hours INT DEFAULT 0,
    course_section_id INT NULL, -- If receiving academic credit
    is_active BOOLEAN DEFAULT TRUE,
    performance_rating ENUM('excellent', 'good', 'satisfactory', 'needs_improvement') NULL,
    FOREIGN KEY (project_id) REFERENCES research_projects(project_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_section_id) REFERENCES course_sections(section_id),
    INDEX idx_student_research_project (project_id),
    INDEX idx_student_research_student (student_id)
);

-- Library resources
CREATE TABLE library_resources (
    resource_id INT PRIMARY KEY AUTO_INCREMENT,
    isbn VARCHAR(20),
    title VARCHAR(500) NOT NULL,
    author VARCHAR(500),
    publisher VARCHAR(255),
    publication_year YEAR,
    edition VARCHAR(50),
    resource_type ENUM('book', 'journal', 'database', 'digital', 'multimedia', 'thesis', 'other') NOT NULL,
    subject_area VARCHAR(255),
    call_number VARCHAR(100),
    location VARCHAR(255), -- Floor, section, shelf
    total_copies INT DEFAULT 1,
    available_copies INT DEFAULT 1,
    condition_status ENUM('excellent', 'good', 'fair', 'poor', 'damaged', 'lost') DEFAULT 'good',
    purchase_date DATE,
    purchase_price DECIMAL(10,2),
    digital_access_url VARCHAR(500),
    access_restrictions TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_resource_title (title(100)),
    INDEX idx_resource_author (author(100)),
    INDEX idx_resource_isbn (isbn),
    INDEX idx_resource_type_subject (resource_type, subject_area),
    INDEX idx_resource_call_number (call_number),
    CHECK (available_copies <= total_copies)
);

-- Library resource checkouts
CREATE TABLE resource_checkouts (
    checkout_id INT PRIMARY KEY AUTO_INCREMENT,
    resource_id INT NOT NULL,
    student_id INT NULL,
    faculty_id INT NULL,
    checkout_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE NULL,
    renewal_count INT DEFAULT 0,
    fine_amount DECIMAL(8,2) DEFAULT 0.00,
    status ENUM('checked_out', 'returned', 'overdue', 'lost', 'damaged') DEFAULT 'checked_out',
    notes TEXT,
    checked_out_by_staff VARCHAR(255),
    returned_to_staff VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (resource_id) REFERENCES library_resources(resource_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id),
    INDEX idx_checkout_resource (resource_id),
    INDEX idx_checkout_student (student_id),
    INDEX idx_checkout_faculty (faculty_id),
    INDEX idx_checkout_status_due (status, due_date),
    CHECK (due_date >= checkout_date),
    CHECK (student_id IS NOT NULL OR faculty_id IS NOT NULL)
);

-- Campus events
CREATE TABLE campus_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    campus_id INT NOT NULL,
    event_name VARCHAR(255) NOT NULL,
    description TEXT,
    event_type ENUM('academic', 'cultural', 'sports', 'social', 'career', 'lecture', 'conference', 'graduation', 'orientation', 'other') NOT NULL,
    start_datetime DATETIME NOT NULL,
    end_datetime DATETIME,
    location VARCHAR(255),
    building_name VARCHAR(255),
    room_number VARCHAR(50),
    organizer_name VARCHAR(255),
    organizer_email VARCHAR(255),
    organizer_phone VARCHAR(20),
    max_capacity INT,
    current_registrations INT DEFAULT 0,
    registration_required BOOLEAN DEFAULT FALSE,
    registration_deadline DATETIME,
    cost DECIMAL(8,2) DEFAULT 0.00,
    target_audience JSON, -- Array of target groups
    dress_code VARCHAR(255),
    parking_info TEXT,
    catering_info TEXT,
    av_requirements TEXT,
    status ENUM('planned', 'active', 'completed', 'cancelled', 'postponed') DEFAULT 'planned',
    website VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (campus_id) REFERENCES campuses(campus_id),
    INDEX idx_event_campus_date (campus_id, start_datetime),
    INDEX idx_event_type (event_type),
    INDEX idx_event_status (status),
    CHECK (end_datetime IS NULL OR end_datetime >= start_datetime),
    CHECK (current_registrations <= max_capacity)
);

-- Event registrations
CREATE TABLE event_registrations (
    registration_id INT PRIMARY KEY AUTO_INCREMENT,
    event_id INT NOT NULL,
    student_id INT NULL,
    faculty_id INT NULL,
    external_name VARCHAR(255), -- For non-student/faculty attendees
    external_email VARCHAR(255),
    external_phone VARCHAR(20),
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    attendance_status ENUM('registered', 'attended', 'no_show', 'cancelled') DEFAULT 'registered',
    dietary_restrictions TEXT,
    special_accommodations TEXT,
    payment_status ENUM('not_required', 'pending', 'paid', 'refunded') DEFAULT 'not_required',
    confirmation_sent BOOLEAN DEFAULT FALSE,
    reminder_sent BOOLEAN DEFAULT FALSE,
    feedback_rating INT CHECK (feedback_rating BETWEEN 1 AND 5),
    feedback_comments TEXT,
    FOREIGN KEY (event_id) REFERENCES campus_events(event_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id),
    INDEX idx_registration_event (event_id),
    INDEX idx_registration_student (student_id),
    INDEX idx_registration_faculty (faculty_id),
    CHECK (student_id IS NOT NULL OR faculty_id IS NOT NULL OR external_name IS NOT NULL)
);

-- Housing facilities
CREATE TABLE housing_facilities (
    facility_id INT PRIMARY KEY AUTO_INCREMENT,
    campus_id INT NOT NULL,
    facility_name VARCHAR(255) NOT NULL,
    facility_type ENUM('dormitory', 'apartment', 'house', 'suite') NOT NULL,
    address TEXT,
    building_year_built YEAR,
    total_capacity INT NOT NULL,
    current_occupancy INT DEFAULT 0,
    floor_count INT,
    amenities JSON, -- Array of amenities
    room_types JSON, -- Array of room type configurations
    cost_per_semester DECIMAL(8,2),
    utilities_included BOOLEAN DEFAULT TRUE,
    parking_available BOOLEAN DEFAULT FALSE,
    pets_allowed BOOLEAN DEFAULT FALSE,
    smoking_allowed BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    contact_person VARCHAR(255),
    contact_phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (campus_id) REFERENCES campuses(campus_id),
    INDEX idx_housing_campus (campus_id),
    INDEX idx_housing_type (facility_type),
    CHECK (current_occupancy <= total_capacity)
);

-- Student housing assignments
CREATE TABLE housing_assignments (
    assignment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    facility_id INT NOT NULL,
    room_number VARCHAR(20),
    semester_id INT NOT NULL,
    move_in_date DATE,
    move_out_date DATE,
    cost_per_semester DECIMAL(8,2),
    security_deposit DECIMAL(8,2),
    payment_status ENUM('pending', 'paid', 'partial', 'overdue') DEFAULT 'pending',
    roommate_preferences TEXT,
    special_accommodations TEXT,
    key_issued BOOLEAN DEFAULT FALSE,
    status ENUM('assigned', 'confirmed', 'checked_in', 'checked_out', 'cancelled') DEFAULT 'assigned',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (facility_id) REFERENCES housing_facilities(facility_id),
    FOREIGN KEY (semester_id) REFERENCES semesters(semester_id),
    INDEX idx_housing_student (student_id),
    INDEX idx_housing_facility (facility_id),
    INDEX idx_housing_semester (semester_id)
);

-- Create indexes for better performance
CREATE INDEX idx_students_fullname ON students(last_name, first_name);
CREATE INDEX idx_faculty_fullname ON faculty(last_name, first_name);
CREATE INDEX idx_sections_schedule ON course_sections(start_time, end_time);
CREATE INDEX idx_enrollments_semester_grade ON enrollments(section_id, final_grade);
CREATE INDEX idx_assignments_due_section ON assignments(section_id, due_date);
CREATE INDEX idx_students_gpa ON students(gpa DESC);

-- Create views for common queries
CREATE VIEW active_students_summary AS
SELECT 
    s.student_id,
    s.student_number,
    CONCAT(s.first_name, ' ', s.last_name) AS full_name,
    s.email,
    dp.program_name,
    dp.degree_type,
    s.student_type,
    s.gpa,
    s.total_credit_hours,
    s.academic_standing,
    c.campus_name
FROM students s
JOIN degree_programs dp ON s.program_id = dp.program_id
JOIN campuses c ON s.campus_id = c.campus_id
WHERE s.graduation_status = 'enrolled';

CREATE VIEW faculty_teaching_load AS
SELECT 
    f.faculty_id,
    CONCAT(f.first_name, ' ', f.last_name) AS faculty_name,
    f.academic_rank,
    d.department_name,
    COUNT(cs.section_id) AS sections_taught,
    SUM(cs.current_enrollment) AS total_students,
    AVG(cs.current_enrollment) AS avg_class_size,
    SUM(c.credit_hours) AS total_credit_hours_taught
FROM faculty f
LEFT JOIN course_sections cs ON f.faculty_id = cs.faculty_id AND cs.is_active = TRUE
LEFT JOIN courses c ON cs.course_id = c.course_id
JOIN departments d ON f.department_id = d.department_id
WHERE f.is_active = TRUE
GROUP BY f.faculty_id, f.first_name, f.last_name, f.academic_rank, d.department_name;

CREATE VIEW student_academic_performance AS
SELECT 
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    s.gpa,
    s.total_credit_hours,
    s.academic_standing,
    COUNT(e.enrollment_id) AS total_enrollments,
    AVG(e.grade_points) AS avg_grade_points,
    SUM(CASE WHEN e.status = 'completed' THEN 1 ELSE 0 END) AS completed_courses,
    SUM(CASE WHEN e.status = 'failed' THEN 1 ELSE 0 END) AS failed_courses,
    SUM(CASE WHEN e.final_grade IN ('A+', 'A', 'A-') THEN 1 ELSE 0 END) AS a_grades
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
WHERE s.graduation_status = 'enrolled'
GROUP BY s.student_id, s.first_name, s.last_name, s.gpa, s.total_credit_hours, s.academic_standing;

CREATE VIEW course_enrollment_stats AS
SELECT 
    c.course_id,
    c.course_code,
    c.course_title,
    d.department_name,
    COUNT(cs.section_id) AS sections_offered,
    SUM(cs.current_enrollment) AS total_enrollment,
    AVG(cs.current_enrollment) AS avg_enrollment_per_section,
    SUM(cs.max_enrollment) AS total_capacity,
    ROUND((SUM(cs.current_enrollment) / SUM(cs.max_enrollment)) * 100, 2) AS capacity_utilization_percent
FROM courses c
JOIN departments d ON c.department_id = d.department_id
LEFT JOIN course_sections cs ON c.course_id = cs.course_id AND cs.is_active = TRUE
WHERE c.is_active = TRUE
GROUP BY c.course_id, c.course_code, c.course_title, d.department_name;