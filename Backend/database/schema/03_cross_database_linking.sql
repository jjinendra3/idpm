-- Cross-Database Linking Script
-- This script demonstrates how the school and college databases are interlinked
-- through shared company information and student transfers

-- Create a federated view that shows student transfers from school to college
-- Note: In a real implementation, this would require setting up database federation
-- or cross-database queries depending on the DBMS used

-- ==========================================
-- SHARED COMPANY DATA SYNCHRONIZATION
-- ==========================================

-- This procedure would sync company data between databases
DELIMITER //

CREATE PROCEDURE sync_company_data()
BEGIN
    -- This is a conceptual procedure showing how company data would be synchronized
    -- In practice, you might use triggers, scheduled jobs, or application logic
    
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_company_id INT;
    DECLARE v_company_name VARCHAR(255);
    DECLARE v_founded_year YEAR;
    DECLARE v_headquarters_address TEXT;
    DECLARE v_phone VARCHAR(20);
    DECLARE v_email VARCHAR(100);
    DECLARE v_website VARCHAR(255);
    DECLARE v_tax_id VARCHAR(50);
    
    -- This cursor would read from the school database
    -- DECLARE company_cursor CURSOR FOR
    -- SELECT company_id, company_name, founded_year, headquarters_address, 
    --        phone, email, website, tax_id
    -- FROM school_db.company;
    
    -- DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- OPEN company_cursor;
    
    -- read_loop: LOOP
    --     FETCH company_cursor INTO v_company_id, v_company_name, v_founded_year,
    --           v_headquarters_address, v_phone, v_email, v_website, v_tax_id;
    --     
    --     IF done THEN
    --         LEAVE read_loop;
    --     END IF;
    --     
    --     -- Update or insert into college database
    --     INSERT INTO college_db.company 
    --     (company_id, company_name, founded_year, headquarters_address, phone, email, website, tax_id)
    --     VALUES (v_company_id, v_company_name, v_founded_year, v_headquarters_address, 
    --             v_phone, v_email, v_website, v_tax_id)
    --     ON DUPLICATE KEY UPDATE
    --         company_name = VALUES(company_name),
    --         founded_year = VALUES(founded_year),
    --         headquarters_address = VALUES(headquarters_address),
    --         phone = VALUES(phone),
    --         email = VALUES(email),
    --         website = VALUES(website),
    --         tax_id = VALUES(tax_id),
    --         updated_at = CURRENT_TIMESTAMP;
    --         
    -- END LOOP;
    
    -- CLOSE company_cursor;
    
    SELECT 'Company data synchronization completed' AS status;
END //

DELIMITER ;

-- ==========================================
-- STUDENT TRANSFER TRACKING
-- ==========================================

-- Create a table to track student transfers between school and college
USE college_db;

CREATE TABLE student_transfers (
    transfer_id INT PRIMARY KEY AUTO_INCREMENT,
    college_student_id INT NOT NULL,
    school_database_name VARCHAR(50) DEFAULT 'school_db',
    school_student_id INT NOT NULL,
    school_student_number VARCHAR(20),
    transfer_date DATE NOT NULL,
    transfer_type ENUM('graduated_to_college', 'direct_transfer', 'gap_year_return') NOT NULL,
    previous_school_name VARCHAR(255),
    previous_graduation_date DATE,
    previous_gpa DECIMAL(3,2),
    credits_transferred INT DEFAULT 0,
    transfer_notes TEXT,
    verification_status ENUM('pending', 'verified', 'declined') DEFAULT 'pending',
    verified_by_staff VARCHAR(255),
    verification_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (college_student_id) REFERENCES students(student_id),
    INDEX idx_transfer_college_student (college_student_id),
    INDEX idx_transfer_school_student (school_student_id),
    INDEX idx_transfer_date (transfer_date),
    INDEX idx_transfer_type (transfer_type)
);

-- ==========================================
-- SHARED FACULTY/STAFF CONNECTIONS
-- ==========================================

-- Create a table to track faculty who work at both school and college levels
CREATE TABLE cross_institution_faculty (
    cross_faculty_id INT PRIMARY KEY AUTO_INCREMENT,
    college_faculty_id INT NOT NULL,
    school_database_name VARCHAR(50) DEFAULT 'school_db',
    school_teacher_id INT NOT NULL,
    shared_employee_id VARCHAR(20) NOT NULL,
    primary_institution ENUM('school', 'college') NOT NULL,
    employment_percentage_school DECIMAL(5,2) DEFAULT 0.00,
    employment_percentage_college DECIMAL(5,2) DEFAULT 100.00,
    start_date DATE NOT NULL,
    end_date DATE NULL,
    shared_responsibilities TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (college_faculty_id) REFERENCES faculty(faculty_id),
    UNIQUE KEY unique_shared_employee (shared_employee_id),
    INDEX idx_cross_faculty_college (college_faculty_id),
    INDEX idx_cross_faculty_school (school_teacher_id),
    INDEX idx_cross_faculty_primary (primary_institution),
    CHECK (employment_percentage_school + employment_percentage_college <= 100.00)
);

-- ==========================================
-- CURRICULUM ALIGNMENT TRACKING
-- ==========================================

-- Track how school subjects align with college courses for transfer credits
CREATE TABLE curriculum_alignment (
    alignment_id INT PRIMARY KEY AUTO_INCREMENT,
    college_course_id INT NOT NULL,
    school_database_name VARCHAR(50) DEFAULT 'school_db',
    school_subject_id INT NOT NULL,
    school_subject_code VARCHAR(20),
    alignment_type ENUM('equivalent', 'prerequisite', 'preparatory', 'advanced') NOT NULL,
    credit_transfer_ratio DECIMAL(3,2) DEFAULT 1.00, -- How many college credits per school credit
    minimum_grade_required VARCHAR(5) DEFAULT 'C',
    effective_date DATE NOT NULL,
    expiration_date DATE NULL,
    approval_status ENUM('proposed', 'approved', 'rejected', 'under_review') DEFAULT 'under_review',
    approved_by_faculty_id INT,
    approval_date DATE,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (college_course_id) REFERENCES courses(course_id),
    FOREIGN KEY (approved_by_faculty_id) REFERENCES faculty(faculty_id),
    INDEX idx_alignment_college_course (college_course_id),
    INDEX idx_alignment_school_subject (school_subject_id),
    INDEX idx_alignment_type (alignment_type),
    INDEX idx_alignment_status (approval_status)
);

-- ==========================================
-- ADVANCED PLACEMENT AND DUAL ENROLLMENT
-- ==========================================

-- Track high school students taking college courses (dual enrollment)
CREATE TABLE dual_enrollment (
    dual_enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    college_student_id INT NOT NULL,
    school_database_name VARCHAR(50) DEFAULT 'school_db',
    school_student_id INT NOT NULL,
    school_grade_level VARCHAR(10), -- From school database
    enrollment_type ENUM('dual_credit', 'advanced_placement', 'early_admission') NOT NULL,
    college_section_id INT NOT NULL,
    school_approval_required BOOLEAN DEFAULT TRUE,
    school_approval_date DATE,
    school_counselor_name VARCHAR(255),
    parent_permission_required BOOLEAN DEFAULT TRUE,
    parent_permission_date DATE,
    tuition_responsibility ENUM('student', 'school_district', 'state_program', 'scholarship') NOT NULL,
    transportation_arrangement ENUM('student', 'school_bus', 'parent', 'other') NOT NULL,
    expected_graduation_impact TEXT,
    success_probability_assessment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (college_student_id) REFERENCES students(student_id),
    FOREIGN KEY (college_section_id) REFERENCES course_sections(section_id),
    INDEX idx_dual_college_student (college_student_id),
    INDEX idx_dual_school_student (school_student_id),
    INDEX idx_dual_section (college_section_id),
    INDEX idx_dual_type (enrollment_type)
);

-- ==========================================
-- SHARED RESOURCES AND FACILITIES
-- ==========================================

-- Track shared resources between school and college (libraries, labs, etc.)
CREATE TABLE shared_resources (
    resource_id INT PRIMARY KEY AUTO_INCREMENT,
    resource_name VARCHAR(255) NOT NULL,
    resource_type ENUM('library', 'laboratory', 'auditorium', 'gymnasium', 'cafeteria', 'transportation', 'other') NOT NULL,
    location VARCHAR(255),
    primary_institution ENUM('school', 'college', 'shared') NOT NULL,
    capacity INT,
    usage_schedule JSON, -- Detailed schedule of when each institution uses it
    cost_sharing_arrangement TEXT,
    maintenance_responsibility ENUM('school', 'college', 'shared', 'third_party') NOT NULL,
    booking_system_url VARCHAR(500),
    contact_person VARCHAR(255),
    contact_email VARCHAR(255),
    contact_phone VARCHAR(20),
    special_requirements TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_shared_resource_type (resource_type),
    INDEX idx_shared_resource_primary (primary_institution),
    INDEX idx_shared_resource_active (is_active)
);

-- Track usage of shared resources by students/faculty from both institutions
CREATE TABLE shared_resource_usage (
    usage_id INT PRIMARY KEY AUTO_INCREMENT,
    resource_id INT NOT NULL,
    user_institution ENUM('school', 'college') NOT NULL,
    user_type ENUM('student', 'faculty', 'staff') NOT NULL,
    user_id INT NOT NULL, -- student_id or faculty_id depending on user_type
    usage_date DATE NOT NULL,
    start_time TIME,
    end_time TIME,
    purpose VARCHAR(255),
    group_size INT DEFAULT 1,
    special_equipment_used TEXT,
    satisfaction_rating INT CHECK (satisfaction_rating BETWEEN 1 AND 5),
    feedback TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (resource_id) REFERENCES shared_resources(resource_id),
    INDEX idx_usage_resource_date (resource_id, usage_date),
    INDEX idx_usage_institution_user (user_institution, user_type, user_id),
    INDEX idx_usage_date (usage_date)
);

-- ==========================================
-- FINANCIAL AID COORDINATION
-- ==========================================

-- Track students who receive financial aid that spans both institutions
CREATE TABLE cross_institutional_financial_aid (
    aid_id INT PRIMARY KEY AUTO_INCREMENT,
    college_student_id INT NOT NULL,
    school_database_name VARCHAR(50) DEFAULT 'school_db',
    school_student_id INT,
    aid_program_name VARCHAR(255) NOT NULL,
    aid_type ENUM('scholarship', 'grant', 'loan', 'work_study', 'tuition_waiver') NOT NULL,
    funding_source ENUM('federal', 'state', 'institutional', 'private', 'corporate') NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    school_portion DECIMAL(10,2) DEFAULT 0.00,
    college_portion DECIMAL(10,2) DEFAULT 0.00,
    academic_year_id INT NOT NULL,
    eligibility_criteria TEXT,
    renewal_requirements TEXT,
    gpa_requirement DECIMAL(3,2),
    credit_hour_requirement INT,
    community_service_hours INT DEFAULT 0,
    status ENUM('applied', 'awarded', 'disbursed', 'completed', 'cancelled') DEFAULT 'applied',
    application_date DATE,
    award_date DATE,
    disbursement_dates JSON, -- Array of disbursement dates
    coordinator_name VARCHAR(255),
    coordinator_email VARCHAR(255),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (college_student_id) REFERENCES students(student_id),
    FOREIGN KEY (academic_year_id) REFERENCES academic_years(academic_year_id),
    INDEX idx_aid_student (college_student_id),
    INDEX idx_aid_program (aid_program_name),
    INDEX idx_aid_type_source (aid_type, funding_source),
    INDEX idx_aid_status (status),
    CHECK (school_portion + college_portion <= total_amount)
);

-- ==========================================
-- VIEWS FOR CROSS-DATABASE REPORTING
-- ==========================================

-- View to show student progression from school to college
CREATE VIEW student_progression_pipeline AS
SELECT 
    st.transfer_id,
    cs.student_id AS college_student_id,
    cs.student_number AS college_student_number,
    CONCAT(cs.first_name, ' ', cs.last_name) AS student_name,
    st.school_student_id,
    st.school_student_number,
    st.transfer_date,
    st.transfer_type,
    st.previous_graduation_date,
    st.previous_gpa,
    st.credits_transferred,
    cs.gpa AS current_college_gpa,
    cs.total_credit_hours AS college_credit_hours,
    cs.academic_standing,
    dp.program_name,
    dp.degree_type
FROM student_transfers st
JOIN students cs ON st.college_student_id = cs.student_id
LEFT JOIN degree_programs dp ON cs.program_id = dp.program_id
WHERE st.verification_status = 'verified'
ORDER BY st.transfer_date DESC;

-- View to show dual enrollment students' performance
CREATE VIEW dual_enrollment_performance AS
SELECT 
    de.dual_enrollment_id,
    de.enrollment_type,
    cs.student_id AS college_student_id,
    CONCAT(cs.first_name, ' ', cs.last_name) AS student_name,
    de.school_student_id,
    de.school_grade_level,
    c.course_code,
    c.course_title,
    c.credit_hours,
    sec.section_number,
    CONCAT(f.first_name, ' ', f.last_name) AS instructor_name,
    e.final_grade,
    e.grade_points,
    e.status AS enrollment_status,
    CASE 
        WHEN e.grade_points >= 3.0 THEN 'Successful'
        WHEN e.grade_points >= 2.0 THEN 'Satisfactory'
        WHEN e.grade_points < 2.0 THEN 'Struggling'
        ELSE 'In Progress'
    END AS performance_category
FROM dual_enrollment de
JOIN students cs ON de.college_student_id = cs.student_id
JOIN course_sections sec ON de.college_section_id = sec.section_id
JOIN courses c ON sec.course_id = c.course_id
JOIN faculty f ON sec.faculty_id = f.faculty_id
LEFT JOIN enrollments e ON cs.student_id = e.student_id AND sec.section_id = e.section_id
ORDER BY de.created_at DESC;

-- View to show shared resource utilization
CREATE VIEW shared_resource_utilization AS
SELECT 
    sr.resource_name,
    sr.resource_type,
    sr.location,
    sr.primary_institution,
    COUNT(sru.usage_id) AS total_usage_count,
    COUNT(CASE WHEN sru.user_institution = 'school' THEN 1 END) AS school_usage_count,
    COUNT(CASE WHEN sru.user_institution = 'college' THEN 1 END) AS college_usage_count,
    AVG(sru.satisfaction_rating) AS avg_satisfaction_rating,
    MAX(sru.usage_date) AS last_used_date
FROM shared_resources sr
LEFT JOIN shared_resource_usage sru ON sr.resource_id = sru.resource_id
WHERE sr.is_active = TRUE
GROUP BY sr.resource_id, sr.resource_name, sr.resource_type, sr.location, sr.primary_institution
ORDER BY total_usage_count DESC;

-- View to show faculty working across both institutions
CREATE VIEW cross_institutional_faculty_summary AS
SELECT 
    cif.cross_faculty_id,
    f.faculty_id AS college_faculty_id,
    cif.school_teacher_id,
    cif.shared_employee_id,
    CONCAT(f.first_name, ' ', f.last_name) AS faculty_name,
    f.academic_rank,
    d.department_name AS college_department,
    cif.primary_institution,
    cif.employment_percentage_school,
    cif.employment_percentage_college,
    cif.shared_responsibilities,
    cif.start_date,
    cif.is_active
FROM cross_institution_faculty cif
JOIN faculty f ON cif.college_faculty_id = f.faculty_id
JOIN departments d ON f.department_id = d.department_id
WHERE cif.is_active = TRUE
ORDER BY f.last_name, f.first_name;

-- ==========================================
-- STORED PROCEDURES FOR COMMON OPERATIONS
-- ==========================================

DELIMITER //

-- Procedure to facilitate student transfer from school to college
CREATE PROCEDURE transfer_student_to_college(
    IN p_school_student_id INT,
    IN p_school_student_number VARCHAR(20),
    IN p_transfer_type ENUM('graduated_to_college', 'direct_transfer', 'gap_year_return'),
    IN p_previous_school_name VARCHAR(255),
    IN p_previous_graduation_date DATE,
    IN p_previous_gpa DECIMAL(3,2),
    IN p_program_id INT,
    IN p_campus_id INT,
    OUT p_new_college_student_id INT,
    OUT p_status_message VARCHAR(500)
)
BEGIN
    DECLARE v_student_exists INT DEFAULT 0;
    DECLARE v_new_student_number VARCHAR(20);
    DECLARE v_transfer_id INT;
    
    -- Check if student already exists in college database
    SELECT COUNT(*) INTO v_student_exists
    FROM student_transfers 
    WHERE school_student_id = p_school_student_id 
    AND verification_status = 'verified';
    
    IF v_student_exists > 0 THEN
        SET p_status_message = 'Student already transferred to college';
        SET p_new_college_student_id = NULL;
    ELSE
        -- Generate new student number for college
        SELECT CONCAT('COL', YEAR(CURDATE()), LPAD(COALESCE(MAX(CAST(SUBSTRING(student_number, 8) AS UNSIGNED)), 0) + 1, 6, '0'))
        INTO v_new_student_number
        FROM students 
        WHERE student_number LIKE CONCAT('COL', YEAR(CURDATE()), '%');
        
        -- This would typically involve creating a new student record
        -- For demonstration, we'll create a placeholder record
        INSERT INTO students (
            student_number, first_name, last_name, email, date_of_birth,
            program_id, campus_id, admission_date, student_type, 
            enrollment_status, residency_status, housing_status,
            previous_school_id
        )
        VALUES (
            v_new_student_number, 'Transfer', 'Student', 
            CONCAT('transfer.', v_new_student_number, '@college.edu'),
            '2000-01-01', -- This would come from school database
            p_program_id, p_campus_id, CURDATE(), 'freshman', 
            'full_time', 'in_state', 'commuter',
            p_school_student_id
        );
        
        SET p_new_college_student_id = LAST_INSERT_ID();
        
        -- Create transfer record
        INSERT INTO student_transfers (
            college_student_id, school_student_id, school_student_number,
            transfer_date, transfer_type, previous_school_name,
            previous_graduation_date, previous_gpa
        )
        VALUES (
            p_new_college_student_id, p_school_student_id, p_school_student_number,
            CURDATE(), p_transfer_type, p_previous_school_name,
            p_previous_graduation_date, p_previous_gpa
        );
        
        SET p_status_message = CONCAT('Student successfully transferred. New college ID: ', p_new_college_student_id);
    END IF;
END //

-- Procedure to register a dual enrollment student
CREATE PROCEDURE register_dual_enrollment(
    IN p_school_student_id INT,
    IN p_school_grade_level VARCHAR(10),
    IN p_enrollment_type ENUM('dual_credit', 'advanced_placement', 'early_admission'),
    IN p_section_id INT,
    IN p_tuition_responsibility ENUM('student', 'school_district', 'state_program', 'scholarship'),
    OUT p_college_student_id INT,
    OUT p_status_message VARCHAR(500)
)
BEGIN
    DECLARE v_section_capacity INT;
    DECLARE v_current_enrollment INT;
    DECLARE v_new_student_number VARCHAR(20);
    
    -- Check section capacity
    SELECT max_enrollment, current_enrollment
    INTO v_section_capacity, v_current_enrollment
    FROM course_sections
    WHERE section_id = p_section_id AND is_active = TRUE;
    
    IF v_section_capacity IS NULL THEN
        SET p_status_message = 'Invalid section ID or section is not active';
        SET p_college_student_id = NULL;
    ELSEIF v_current_enrollment >= v_section_capacity THEN
        SET p_status_message = 'Section is at full capacity';
        SET p_college_student_id = NULL;
    ELSE
        -- Generate dual enrollment student number
        SELECT CONCAT('DUAL', YEAR(CURDATE()), LPAD(COALESCE(MAX(CAST(SUBSTRING(student_number, 9) AS UNSIGNED)), 0) + 1, 5, '0'))
        INTO v_new_student_number
        FROM students 
        WHERE student_number LIKE CONCAT('DUAL', YEAR(CURDATE()), '%');
        
        -- Create college student record for dual enrollment
        INSERT INTO students (
            student_number, first_name, last_name, email, date_of_birth,
            campus_id, admission_date, student_type, enrollment_status, 
            residency_status, housing_status, previous_school_id
        )
        SELECT 
            v_new_student_number, 'Dual', 'Enrollment', 
            CONCAT('dual.', v_new_student_number, '@college.edu'),
            '2005-01-01', -- Typical high school student birth year
            1, CURDATE(), 'freshman', 'part_time', 
            'in_state', 'commuter', p_school_student_id;
            
        SET p_college_student_id = LAST_INSERT_ID();
        
        -- Create dual enrollment record
        INSERT INTO dual_enrollment (
            college_student_id, school_student_id, school_grade_level,
            enrollment_type, college_section_id, tuition_responsibility,
            transportation_arrangement
        )
        VALUES (
            p_college_student_id, p_school_student_id, p_school_grade_level,
            p_enrollment_type, p_section_id, p_tuition_responsibility,
            'student'
        );
        
        -- Enroll student in the section
        INSERT INTO enrollments (
            student_id, section_id, enrollment_date, enrollment_type, 
            credit_hours, status
        )
        SELECT 
            p_college_student_id, p_section_id, CURDATE(), 'regular',
            c.credit_hours, 'enrolled'
        FROM course_sections cs
        JOIN courses c ON cs.course_id = c.course_id
        WHERE cs.section_id = p_section_id;
        
        -- Update section enrollment count
        UPDATE course_sections 
        SET current_enrollment = current_enrollment + 1
        WHERE section_id = p_section_id;
        
        SET p_status_message = CONCAT('Dual enrollment successful. College Student ID: ', p_college_student_id);
    END IF;
END //

DELIMITER ;

-- ==========================================
-- SAMPLE LINKING QUERIES
-- ==========================================

-- Example query to show students who attended both school and college
/*
SELECT 
    school_data.student_name,
    school_data.graduation_date AS school_graduation,
    college_data.admission_date AS college_admission,
    college_data.program_name,
    DATEDIFF(college_data.admission_date, school_data.graduation_date) AS gap_days
FROM (
    -- This would be a federated query to school database
    SELECT student_id, CONCAT(first_name, ' ', last_name) AS student_name, graduation_date
    FROM school_db.students 
    WHERE status = 'graduated'
) school_data
JOIN student_transfers st ON school_data.student_id = st.school_student_id
JOIN (
    SELECT s.student_id, s.admission_date, dp.program_name
    FROM students s
    JOIN degree_programs dp ON s.program_id = dp.program_id
) college_data ON st.college_student_id = college_data.student_id;
*/