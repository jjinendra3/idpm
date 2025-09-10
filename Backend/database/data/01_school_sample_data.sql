-- Sample Data for School Database
-- This includes various SQL edge cases and comprehensive test data

USE school_db;

-- Disable foreign key checks temporarily for easier data insertion
SET FOREIGN_KEY_CHECKS = 0;

-- ==========================================
-- COMPANY DATA (Shared across institutions)
-- ==========================================

INSERT INTO company (company_id, company_name, founded_year, headquarters_address, phone, email, website, tax_id) VALUES
(1, 'EduCorp Excellence Group', 1985, '123 Education Blvd, Learning City, EDU 12345', '555-123-4567', 'info@educorp.edu', 'https://www.educorp.edu', '12-3456789');

-- ==========================================
-- CAMPUS DATA
-- ==========================================

INSERT INTO campuses (campus_id, company_id, campus_name, address, city, state, zip_code, phone, principal_name, capacity, established_year, campus_type, is_active) VALUES
(1, 1, 'Sunrise Elementary School', '456 Sunrise Ave', 'Learning City', 'EDU', '12345', '555-234-5678', 'Dr. Sarah Johnson', 500, 1995, 'elementary', TRUE),
(2, 1, 'Valley Middle School', '789 Valley Road', 'Learning City', 'EDU', '12346', '555-345-6789', 'Mr. David Chen', 800, 1988, 'middle', TRUE),
(3, 1, 'Mountain View High School', '321 Mountain View Dr', 'Learning City', 'EDU', '12347', '555-456-7890', 'Ms. Maria Rodriguez', 1200, 1975, 'high', TRUE),
(4, 1, 'Riverside K-12 School', '654 River St', 'Riverside', 'EDU', '12348', '555-567-8901', 'Dr. James Wilson', 600, 2005, 'combined', TRUE),
-- Edge case: Inactive campus
(5, 1, 'Old Town Elementary (Closed)', '999 Old Town Rd', 'Old Town', 'EDU', '12349', '555-999-0000', NULL, 300, 1960, 'elementary', FALSE);

-- ==========================================
-- GRADES
-- ==========================================

INSERT INTO grades (grade_id, grade_level, grade_name, sort_order, min_age, max_age) VALUES
(1, 'K', 'Kindergarten', 1, 5, 6),
(2, '1', 'First Grade', 2, 6, 7),
(3, '2', 'Second Grade', 3, 7, 8),
(4, '3', 'Third Grade', 4, 8, 9),
(5, '4', 'Fourth Grade', 5, 9, 10),
(6, '5', 'Fifth Grade', 6, 10, 11),
(7, '6', 'Sixth Grade', 7, 11, 12),
(8, '7', 'Seventh Grade', 8, 12, 13),
(9, '8', 'Eighth Grade', 9, 13, 14),
(10, '9', 'Ninth Grade', 10, 14, 15),
(11, '10', 'Tenth Grade', 11, 15, 16),
(12, '11', 'Eleventh Grade', 12, 16, 17),
(13, '12', 'Twelfth Grade', 13, 17, 18);

-- ==========================================
-- ACADEMIC YEARS AND TERMS
-- ==========================================

INSERT INTO academic_years (academic_year_id, year_name, start_date, end_date, is_current) VALUES
(1, '2022-2023', '2022-08-15', '2023-06-15', FALSE),
(2, '2023-2024', '2023-08-14', '2024-06-14', TRUE),
(3, '2024-2025', '2024-08-12', '2025-06-13', FALSE);

INSERT INTO terms (term_id, academic_year_id, term_name, term_number, start_date, end_date, is_current) VALUES
-- 2022-2023 terms
(1, 1, 'Fall 2022', 1, '2022-08-15', '2022-12-20', FALSE),
(2, 1, 'Spring 2023', 2, '2023-01-09', '2023-06-15', FALSE),
-- 2023-2024 terms (current year)
(3, 2, 'Fall 2023', 1, '2023-08-14', '2023-12-19', FALSE),
(4, 2, 'Spring 2024', 2, '2024-01-08', '2024-06-14', TRUE),
-- 2024-2025 terms
(5, 3, 'Fall 2024', 1, '2024-08-12', '2024-12-18', FALSE),
(6, 3, 'Spring 2025', 2, '2025-01-06', '2025-06-13', FALSE);

-- ==========================================
-- DEPARTMENTS
-- ==========================================

INSERT INTO departments (department_id, campus_id, department_name, department_code, budget, description, floor_number, room_numbers) VALUES
-- Sunrise Elementary
(1, 1, 'Early Elementary', 'EE', 50000.00, 'Kindergarten through 2nd grade', 1, '["101", "102", "103", "104", "105"]'),
(2, 1, 'Upper Elementary', 'UE', 60000.00, '3rd through 5th grade', 2, '["201", "202", "203", "204", "205"]'),
(3, 1, 'Special Education', 'SPED', 75000.00, 'Special needs and intervention programs', 1, '["110", "111"]'),
-- Valley Middle School
(4, 2, 'English Language Arts', 'ELA', 80000.00, 'Reading, writing, literature, and communication', 2, '["201", "202", "203", "204"]'),
(5, 2, 'Mathematics', 'MATH', 85000.00, 'Algebra, geometry, and advanced math', 3, '["301", "302", "303", "304"]'),
(6, 2, 'Science', 'SCI', 95000.00, 'Biology, chemistry, physics, and earth science', 1, '["101", "102", "103", "104"]'),
(7, 2, 'Social Studies', 'SS', 70000.00, 'History, geography, civics, and culture', 2, '["205", "206", "207"]'),
-- Mountain View High School
(8, 3, 'English Department', 'ENG', 120000.00, 'Literature, composition, speech, and drama', 2, '["201", "202", "203", "204", "205"]'),
(9, 3, 'Mathematics Department', 'MATH', 130000.00, 'Algebra through calculus and statistics', 3, '["301", "302", "303", "304", "305"]'),
(10, 3, 'Science Department', 'SCI', 150000.00, 'Biology, chemistry, physics, and environmental science', 1, '["101", "102", "103", "104", "105"]'),
(11, 3, 'Social Studies Department', 'SS', 100000.00, 'World history, US history, government, and economics', 2, '["206", "207", "208", "209"]'),
(12, 3, 'World Languages', 'WL', 90000.00, 'Spanish, French, German, and ESL', 4, '["401", "402", "403"]'),
(13, 3, 'Fine Arts', 'FA', 110000.00, 'Music, art, theater, and media production', 1, '["106", "107", "108", "109"]'),
(14, 3, 'Physical Education', 'PE', 80000.00, 'Health, fitness, and sports', 1, '["Gym A", "Gym B", "Weight Room"]'),
(15, 3, 'Career and Technical Education', 'CTE', 140000.00, 'Computer science, engineering, culinary arts', 3, '["306", "307", "308", "309"]'),
-- Riverside K-12
(16, 4, 'Elementary Division', 'ELEM', 100000.00, 'K-5 integrated curriculum', 1, '["101", "102", "103", "104", "105", "106"]'),
(17, 4, 'Secondary Division', 'SEC', 120000.00, '6-12 subject areas', 2, '["201", "202", "203", "204", "205", "206"]');

-- ==========================================
-- TEACHERS
-- ==========================================

INSERT INTO teachers (teacher_id, employee_id, first_name, last_name, middle_name, email, phone, address, city, state, zip_code, date_of_birth, hire_date, salary, department_id, campus_id, position_title, employment_status, education_level, certifications, emergency_contact_name, emergency_contact_phone, is_active) VALUES
-- Sunrise Elementary Teachers
(1, 'T001', 'Jennifer', 'Williams', 'Anne', 'j.williams@educorp.edu', '555-111-1001', '123 Teacher Lane', 'Learning City', 'EDU', '12350', '1985-03-15', '2010-08-01', 52000.00, 1, 1, 'Kindergarten Teacher', 'full_time', 'bachelor', '["Elementary Education", "Early Childhood"]', 'Michael Williams', '555-111-1002', TRUE),
(2, 'T002', 'Michael', 'Davis', 'James', 'm.davis@educorp.edu', '555-111-1003', '456 Educator St', 'Learning City', 'EDU', '12350', '1978-07-22', '2008-08-15', 54000.00, 1, 1, 'First Grade Teacher', 'full_time', 'master', '["Elementary Education", "Reading Specialist"]', 'Sarah Davis', '555-111-1004', TRUE),
(3, 'T003', 'Sarah', 'Brown', 'Elizabeth', 's.brown@educorp.edu', '555-111-1005', '789 School Ave', 'Learning City', 'EDU', '12350', '1990-11-08', '2015-08-01', 50000.00, 2, 1, 'Third Grade Teacher', 'full_time', 'bachelor', '["Elementary Education"]', 'David Brown', '555-111-1006', TRUE),
(4, 'T004', 'Robert', 'Miller', 'John', 'r.miller@educorp.edu', '555-111-1007', '321 Learning Blvd', 'Learning City', 'EDU', '12350', '1982-05-20', '2012-08-01', 53000.00, 2, 1, 'Fourth Grade Teacher', 'full_time', 'master', '["Elementary Education", "Mathematics Specialist"]', 'Lisa Miller', '555-111-1008', TRUE),
(5, 'T005', 'Lisa', 'Garcia', 'Maria', 'l.garcia@educorp.edu', '555-111-1009', '654 Education Way', 'Learning City', 'EDU', '12350', '1987-09-12', '2014-08-01', 55000.00, 3, 1, 'Special Education Teacher', 'full_time', 'master', '["Special Education", "Autism Specialist"]', 'Carlos Garcia', '555-111-1010', TRUE),

-- Valley Middle School Teachers
(6, 'T006', 'David', 'Wilson', 'Andrew', 'd.wilson@educorp.edu', '555-222-2001', '111 Middle School Dr', 'Learning City', 'EDU', '12351', '1975-12-03', '2005-08-01', 58000.00, 4, 2, 'English Teacher', 'full_time', 'master', '["English Education", "Literacy Specialist"]', 'Karen Wilson', '555-222-2002', TRUE),
(7, 'T007', 'Karen', 'Anderson', 'Lynn', 'k.anderson@educorp.edu', '555-222-2003', '222 Teaching Terrace', 'Learning City', 'EDU', '12351', '1980-04-17', '2009-08-01', 59000.00, 5, 2, 'Mathematics Teacher', 'full_time', 'master', '["Mathematics Education", "Algebra Specialist"]', 'Mark Anderson', '555-222-2004', TRUE),
(8, 'T008', 'Mark', 'Taylor', 'Steven', 'm.taylor@educorp.edu', '555-222-2005', '333 Science Circle', 'Learning City', 'EDU', '12351', '1983-08-25', '2011-08-01', 60000.00, 6, 2, 'Science Teacher', 'full_time', 'master', '["Science Education", "Biology Specialist"]', 'Jennifer Taylor', '555-222-2006', TRUE),
(9, 'T009', 'Jennifer', 'Clark', 'Nicole', 'j.clark@educorp.edu', '555-222-2007', '444 History Hill', 'Learning City', 'EDU', '12351', '1986-01-14', '2013-08-01', 57000.00, 7, 2, 'Social Studies Teacher', 'full_time', 'bachelor', '["Social Studies Education", "History"]', 'Robert Clark', '555-222-2008', TRUE),

-- Mountain View High School Teachers  
(10, 'T010', 'Christopher', 'Lewis', 'Michael', 'c.lewis@educorp.edu', '555-333-3001', '101 High School Blvd', 'Learning City', 'EDU', '12352', '1972-06-30', '2000-08-01', 65000.00, 8, 3, 'English Department Chair', 'full_time', 'master', '["English Literature", "Composition", "Department Leadership"]', 'Michelle Lewis', '555-333-3002', TRUE),
(11, 'T011', 'Michelle', 'Rodriguez', 'Carmen', 'm.rodriguez@educorp.edu', '555-333-3003', '202 Math Mountain', 'Learning City', 'EDU', '12352', '1979-10-11', '2007-08-01', 66000.00, 9, 3, 'Mathematics Department Chair', 'full_time', 'master', '["Mathematics Education", "Calculus", "Statistics"]', 'Antonio Rodriguez', '555-333-3004', TRUE),
(12, 'T012', 'James', 'Thompson', 'William', 'j.thompson@educorp.edu', '555-333-3005', '303 Science Summit', 'Learning City', 'EDU', '12352', '1977-02-28', '2005-08-01', 67000.00, 10, 3, 'Science Department Chair', 'full_time', 'doctorate', '["Chemistry", "Science Education", "Research"]', 'Patricia Thompson', '555-333-3006', TRUE),
(13, 'T013', 'Patricia', 'White', 'Jane', 'p.white@educorp.edu', '555-333-3007', '404 Language Lane', 'Learning City', 'EDU', '12352', '1981-12-05', '2010-08-01', 61000.00, 12, 3, 'Spanish Teacher', 'full_time', 'master', '["Spanish Language", "Foreign Language Education"]', 'Richard White', '555-333-3008', TRUE),
(14, 'T014', 'Richard', 'Harris', 'Paul', 'r.harris@educorp.edu', '555-333-3009', '505 Arts Avenue', 'Learning City', 'EDU', '12352', '1984-04-18', '2012-08-01', 59000.00, 13, 3, 'Music Teacher', 'full_time', 'bachelor', '["Music Education", "Band Direction"]', 'Susan Harris', '555-333-3010', TRUE),
(15, 'T015', 'Susan', 'Martin', 'Kay', 's.martin@educorp.edu', '555-333-3011', '606 Sports Street', 'Learning City', 'EDU', '12352', '1988-08-07', '2015-08-01', 56000.00, 14, 3, 'Physical Education Teacher', 'full_time', 'bachelor', '["Physical Education", "Health", "Athletic Training"]', 'Thomas Martin', '555-333-3012', TRUE),
-- Edge case: Part-time teacher
(16, 'T016', 'Thomas', 'Jackson', 'Lee', 't.jackson@educorp.edu', '555-333-3013', '707 Tech Trail', 'Learning City', 'EDU', '12352', '1992-03-21', '2020-08-01', 35000.00, 15, 3, 'Computer Science Teacher', 'part_time', 'bachelor', '["Computer Science", "Information Technology"]', 'Emily Jackson', '555-333-3014', TRUE),
-- Edge case: Terminated teacher
(17, 'T017', 'Emily', 'Moore', 'Rose', 'e.moore@educorp.edu', '555-333-3015', '808 Former Faculty Rd', 'Learning City', 'EDU', '12352', '1985-07-16', '2018-08-01', 58000.00, 8, 3, 'English Teacher', 'full_time', 'master', '["English Literature"]', 'Daniel Moore', '555-333-3016', FALSE),

-- Riverside K-12 Teachers
(18, 'T018', 'Daniel', 'Robinson', 'Scott', 'd.robinson@educorp.edu', '555-444-4001', '909 Riverside Road', 'Riverside', 'EDU', '12353', '1976-11-29', '2003-08-01', 62000.00, 16, 4, 'Elementary Principal/Teacher', 'full_time', 'master', '["Elementary Education", "Educational Leadership"]', 'Angela Robinson', '555-444-4002', TRUE),
(19, 'T019', 'Angela', 'Young', 'Marie', 'a.young@educorp.edu', '555-444-4003', '1010 River View Ct', 'Riverside', 'EDU', '12353', '1989-05-03', '2016-08-01', 54000.00, 17, 4, 'Secondary Math/Science Teacher', 'full_time', 'master', '["Mathematics", "Science Education"]', 'Kevin Young', '555-444-4004', TRUE),
-- Edge case: NULL values for optional fields
(20, 'T020', 'Kevin', 'Allen', NULL, 'k.allen@educorp.edu', NULL, NULL, NULL, NULL, NULL, '1991-01-01', '2021-08-01', 48000.00, 17, 4, 'Substitute Teacher', 'part_time', 'bachelor', NULL, NULL, NULL, TRUE);

-- Update department head assignments
UPDATE departments SET head_teacher_id = 1 WHERE department_id = 1;  -- Jennifer Williams for Early Elementary
UPDATE departments SET head_teacher_id = 3 WHERE department_id = 2;  -- Sarah Brown for Upper Elementary  
UPDATE departments SET head_teacher_id = 5 WHERE department_id = 3;  -- Lisa Garcia for Special Education
UPDATE departments SET head_teacher_id = 6 WHERE department_id = 4;  -- David Wilson for ELA
UPDATE departments SET head_teacher_id = 7 WHERE department_id = 5;  -- Karen Anderson for Math
UPDATE departments SET head_teacher_id = 8 WHERE department_id = 6;  -- Mark Taylor for Science
UPDATE departments SET head_teacher_id = 9 WHERE department_id = 7;  -- Jennifer Clark for Social Studies
UPDATE departments SET head_teacher_id = 10 WHERE department_id = 8; -- Christopher Lewis for English
UPDATE departments SET head_teacher_id = 11 WHERE department_id = 9; -- Michelle Rodriguez for Math
UPDATE departments SET head_teacher_id = 12 WHERE department_id = 10; -- James Thompson for Science
UPDATE departments SET head_teacher_id = 9 WHERE department_id = 11; -- Jennifer Clark for Social Studies (shared)
UPDATE departments SET head_teacher_id = 13 WHERE department_id = 12; -- Patricia White for World Languages
UPDATE departments SET head_teacher_id = 14 WHERE department_id = 13; -- Richard Harris for Fine Arts
UPDATE departments SET head_teacher_id = 15 WHERE department_id = 14; -- Susan Martin for PE
UPDATE departments SET head_teacher_id = 16 WHERE department_id = 15; -- Thomas Jackson for CTE
UPDATE departments SET head_teacher_id = 18 WHERE department_id = 16; -- Daniel Robinson for Elementary
UPDATE departments SET head_teacher_id = 19 WHERE department_id = 17; -- Angela Young for Secondary

-- ==========================================
-- SUBJECTS
-- ==========================================

INSERT INTO subjects (subject_id, subject_code, subject_name, description, department_id, credits, is_core_subject, grade_levels, prerequisites) VALUES
-- Elementary Subjects
(1, 'K-READ', 'Kindergarten Reading', 'Basic reading and phonics skills', 1, 1.00, TRUE, '["K"]', NULL),
(2, 'K-MATH', 'Kindergarten Mathematics', 'Number recognition and basic counting', 1, 1.00, TRUE, '["K"]', NULL),
(3, 'K-SCI', 'Kindergarten Science', 'Observation and exploration of the natural world', 1, 0.50, FALSE, '["K"]', NULL),
(4, '1-READ', 'First Grade Reading', 'Reading comprehension and fluency', 1, 1.00, TRUE, '["1"]', '[1]'),
(5, '1-MATH', 'First Grade Mathematics', 'Addition, subtraction, and place value', 1, 1.00, TRUE, '["1"]', '[2]'),
(6, '2-READ', 'Second Grade Reading', 'Advanced reading and writing skills', 1, 1.00, TRUE, '["2"]', '[4]'),
(7, '2-MATH', 'Second Grade Mathematics', 'Multi-digit arithmetic and word problems', 1, 1.00, TRUE, '["2"]', '[5]'),
(8, '3-READ', 'Third Grade Reading', 'Literature and informational text analysis', 2, 1.00, TRUE, '["3"]', '[6]'),
(9, '3-MATH', 'Third Grade Mathematics', 'Multiplication, division, and fractions', 2, 1.00, TRUE, '["3"]', '[7]'),
(10, '4-READ', 'Fourth Grade Reading', 'Complex text comprehension and writing', 2, 1.00, TRUE, '["4"]', '[8]'),
(11, '4-MATH', 'Fourth Grade Mathematics', 'Multi-step problems and decimals', 2, 1.00, TRUE, '["4"]', '[9]'),
(12, '5-READ', 'Fifth Grade Reading', 'Research skills and literary analysis', 2, 1.00, TRUE, '["5"]', '[10]'),
(13, '5-MATH', 'Fifth Grade Mathematics', 'Algebraic thinking and geometry', 2, 1.00, TRUE, '["5"]', '[11]'),

-- Middle School Subjects
(14, 'MS-ELA6', 'Sixth Grade English Language Arts', 'Reading, writing, speaking, and listening', 4, 1.00, TRUE, '["6"]', '[12]'),
(15, 'MS-MATH6', 'Sixth Grade Mathematics', 'Ratios, proportions, and basic algebra', 5, 1.00, TRUE, '["6"]', '[13]'),
(16, 'MS-SCI6', 'Sixth Grade Science', 'Earth and space science', 6, 1.00, TRUE, '["6"]', NULL),
(17, 'MS-SS6', 'Sixth Grade Social Studies', 'Ancient civilizations', 7, 1.00, TRUE, '["6"]', NULL),
(18, 'MS-ELA7', 'Seventh Grade English Language Arts', 'Literary analysis and argumentative writing', 4, 1.00, TRUE, '["7"]', '[14]'),
(19, 'MS-MATH7', 'Seventh Grade Mathematics', 'Pre-algebra and geometry concepts', 5, 1.00, TRUE, '["7"]', '[15]'),
(20, 'MS-SCI7', 'Seventh Grade Science', 'Life science and biology', 6, 1.00, TRUE, '["7"]', '[16]'),
(21, 'MS-SS7', 'Seventh Grade Social Studies', 'World geography and cultures', 7, 1.00, TRUE, '["7"]', '[17]'),
(22, 'MS-ELA8', 'Eighth Grade English Language Arts', 'Research and advanced composition', 4, 1.00, TRUE, '["8"]', '[18]'),
(23, 'MS-MATH8', 'Eighth Grade Mathematics', 'Algebra I foundations', 5, 1.00, TRUE, '["8"]', '[19]'),
(24, 'MS-SCI8', 'Eighth Grade Science', 'Physical science and chemistry', 6, 1.00, TRUE, '["8"]', '[20]'),
(25, 'MS-SS8', 'Eighth Grade Social Studies', 'United States history', 7, 1.00, TRUE, '["8"]', '[21]'),

-- High School Core Subjects
(26, 'HS-ENG9', 'English 9', 'Literature and composition foundations', 8, 1.00, TRUE, '["9"]', '[22]'),
(27, 'HS-ALG1', 'Algebra I', 'Linear equations and functions', 9, 1.00, TRUE, '["9", "10"]', '[23]'),
(28, 'HS-BIO', 'Biology', 'Introduction to biological sciences', 10, 1.00, TRUE, '["9", "10"]', '[24]'),
(29, 'HS-WHIST', 'World History', 'Global historical perspectives', 11, 1.00, TRUE, '["9", "10"]', '[25]'),
(30, 'HS-ENG10', 'English 10', 'World literature and research writing', 8, 1.00, TRUE, '["10"]', '[26]'),
(31, 'HS-GEOM', 'Geometry', 'Plane and solid geometry', 9, 1.00, TRUE, '["10", "11"]', '[27]'),
(32, 'HS-CHEM', 'Chemistry', 'Chemical principles and laboratory work', 10, 1.00, TRUE, '["10", "11"]', '[28]'),
(33, 'HS-USHIST', 'US History', 'American history and government', 11, 1.00, TRUE, '["10", "11"]', '[29]'),
(34, 'HS-ENG11', 'English 11', 'American literature and advanced writing', 8, 1.00, TRUE, '["11"]', '[30]'),
(35, 'HS-ALG2', 'Algebra II', 'Advanced algebraic concepts', 9, 1.00, TRUE, '["11", "12"]', '[31]'),
(36, 'HS-PHYS', 'Physics', 'Mechanics, waves, and electricity', 10, 1.00, TRUE, '["11", "12"]', '[32]'),
(37, 'HS-GOV', 'Government/Economics', 'Civics and economic principles', 11, 1.00, TRUE, '["12"]', '[33]'),
(38, 'HS-ENG12', 'English 12', 'British literature and college preparation', 8, 1.00, TRUE, '["12"]', '[34]'),

-- Advanced Placement and Electives
(39, 'HS-APCALC', 'AP Calculus', 'Advanced placement calculus', 9, 1.00, FALSE, '["11", "12"]', '[35]'),
(40, 'HS-APBIO', 'AP Biology', 'Advanced placement biology', 10, 1.00, FALSE, '["11", "12"]', '[28]'),
(41, 'HS-SPAN1', 'Spanish I', 'Introduction to Spanish language', 12, 1.00, FALSE, '["9", "10", "11", "12"]', NULL),
(42, 'HS-SPAN2', 'Spanish II', 'Intermediate Spanish language', 12, 1.00, FALSE, '["10", "11", "12"]', '[41]'),
(43, 'HS-ART1', 'Art I', 'Basic drawing and painting techniques', 13, 0.50, FALSE, '["9", "10", "11", "12"]', NULL),
(44, 'HS-MUSIC', 'Concert Band', 'Instrumental music performance', 13, 0.50, FALSE, '["9", "10", "11", "12"]', NULL),
(45, 'HS-PE', 'Physical Education', 'Health and fitness', 14, 0.50, TRUE, '["9", "10", "11", "12"]', NULL),
(46, 'HS-COMPSC1', 'Computer Science I', 'Introduction to programming', 15, 1.00, FALSE, '["10", "11", "12"]', NULL),
-- Edge case: Subject with complex prerequisites
(47, 'HS-COMPSC2', 'Computer Science II', 'Advanced programming and data structures', 15, 1.00, FALSE, '["11", "12"]', '[46, 35]'), -- Requires both CompSci I and Algebra II

-- Riverside K-12 Integrated Subjects
(48, 'RIV-ELEM', 'Elementary Integrated Curriculum', 'Multi-subject elementary program', 16, 5.00, TRUE, '["K", "1", "2", "3", "4", "5"]', NULL),
(49, 'RIV-SEC', 'Secondary Integrated Program', 'Cross-curricular secondary education', 17, 6.00, TRUE, '["6", "7", "8", "9", "10", "11", "12"]', '[48]');

-- ==========================================
-- STUDENTS (Including various edge cases)
-- ==========================================

-- Note: Using realistic birth dates for age-appropriate grade levels
INSERT INTO students (student_id, student_number, first_name, last_name, middle_name, email, date_of_birth, gender, address, city, state, zip_code, phone, current_grade_id, campus_id, enrollment_date, status, parent_guardian_1_name, parent_guardian_1_phone, parent_guardian_1_email, parent_guardian_1_relationship, parent_guardian_2_name, parent_guardian_2_phone, parent_guardian_2_email, parent_guardian_2_relationship, emergency_contact_name, emergency_contact_phone, medical_conditions, allergies, special_needs, transportation_method, lunch_program) VALUES

-- Sunrise Elementary Students (Grades K-5)
(1, 'SUN2024001', 'Emma', 'Johnson', 'Grace', 'emma.johnson.parent@email.com', '2018-09-15', 'female', '123 Sunshine St', 'Learning City', 'EDU', '12345', '555-101-0001', 1, 1, '2023-08-14', 'active', 'John Johnson', '555-101-0002', 'john.johnson@email.com', 'father', 'Mary Johnson', '555-101-0003', 'mary.johnson@email.com', 'mother', 'Grandma Johnson', '555-101-0004', NULL, 'Peanuts', NULL, 'bus', 'free'),
(2, 'SUN2024002', 'Liam', 'Smith', 'Alexander', 'liam.smith.parent@email.com', '2018-03-22', 'male', '456 Bright Ave', 'Learning City', 'EDU', '12345', '555-101-0005', 1, 1, '2023-08-14', 'active', 'Robert Smith', '555-101-0006', 'robert.smith@email.com', 'father', 'Lisa Smith', '555-101-0007', 'lisa.smith@email.com', 'mother', 'Uncle Tom', '555-101-0008', 'ADHD', NULL, 'Requires quiet environment for testing', 'car', 'reduced'),
(3, 'SUN2024003', 'Olivia', 'Brown', 'Rose', 'olivia.brown.parent@email.com', '2017-12-10', 'female', '789 Morning Dr', 'Learning City', 'EDU', '12345', '555-101-0009', 2, 1, '2023-08-14', 'active', 'David Brown', '555-101-0010', 'david.brown@email.com', 'father', 'Sarah Brown', '555-101-0011', 'sarah.brown@email.com', 'mother', 'Aunt Sarah', '555-101-0012', NULL, 'Dairy', NULL, 'walk', 'paid'),
(4, 'SUN2024004', 'Noah', 'Davis', 'James', 'noah.davis.parent@email.com', '2016-11-05', 'male', '321 Dawn Blvd', 'Learning City', 'EDU', '12345', '555-101-0013', 3, 1, '2023-08-14', 'active', 'Michael Davis', '555-101-0014', 'michael.davis@email.com', 'father', 'Jennifer Davis', '555-101-0015', 'jennifer.davis@email.com', 'mother', 'Grandpa Davis', '555-101-0016', NULL, NULL, NULL, 'bus', 'free'),
(5, 'SUN2024005', 'Ava', 'Wilson', 'Marie', 'ava.wilson.parent@email.com', '2015-08-18', 'female', '654 Sunrise Ct', 'Learning City', 'EDU', '12345', '555-101-0017', 4, 1, '2023-08-14', 'active', 'James Wilson', '555-101-0018', 'james.wilson@email.com', 'father', 'Linda Wilson', '555-101-0019', 'linda.wilson@email.com', 'mother', 'Family Friend', '555-101-0020', 'Type 1 Diabetes', NULL, 'Requires blood sugar monitoring', 'car', 'paid'),
-- Edge case: Student with single parent
(6, 'SUN2024006', 'William', 'Martinez', 'Carlos', 'william.martinez.parent@email.com', '2014-07-30', 'male', '987 Sunbeam Ln', 'Learning City', 'EDU', '12345', '555-101-0021', 5, 1, '2023-08-14', 'active', 'Maria Martinez', '555-101-0022', 'maria.martinez@email.com', 'mother', NULL, NULL, NULL, NULL, 'Cousin Pedro', '555-101-0023', NULL, 'Shellfish', NULL, 'bus', 'free'),
-- Edge case: Student who transferred mid-year
(7, 'SUN2024007', 'Sofia', 'Anderson', 'Elena', 'sofia.anderson.parent@email.com', '2016-04-12', 'female', '111 Transfer St', 'Learning City', 'EDU', '12345', '555-101-0024', 3, 1, '2024-01-15', 'active', 'Erik Anderson', '555-101-0025', 'erik.anderson@email.com', 'father', 'Carmen Anderson', '555-101-0026', 'carmen.anderson@email.com', 'mother', 'School Counselor', '555-101-0027', NULL, NULL, 'ESL Support', 'car', 'reduced'),

-- Valley Middle School Students (Grades 6-8)
(8, 'VAL2024001', 'Mason', 'Taylor', 'Joseph', 'mason.taylor.parent@email.com', '2012-05-20', 'male', '222 Valley View', 'Learning City', 'EDU', '12346', '555-201-0001', 7, 2, '2023-08-14', 'active', 'Joseph Taylor', '555-201-0002', 'joseph.taylor@email.com', 'father', 'Rebecca Taylor', '555-201-0003', 'rebecca.taylor@email.com', 'mother', 'Coach Taylor', '555-201-0004', NULL, NULL, NULL, 'bike', 'paid'),
(9, 'VAL2024002', 'Isabella', 'Garcia', 'Lucia', 'isabella.garcia.parent@email.com', '2011-09-08', 'female', '333 Middle Ridge', 'Learning City', 'EDU', '12346', '555-201-0005', 8, 2, '2023-08-14', 'active', 'Carlos Garcia', '555-201-0006', 'carlos.garcia@email.com', 'father', 'Rosa Garcia', '555-201-0007', 'rosa.garcia@email.com', 'mother', 'Tia Rosa', '555-201-0008', NULL, NULL, NULL, 'car', 'reduced'),
(10, 'VAL2024003', 'Ethan', 'Rodriguez', 'Miguel', 'ethan.rodriguez.parent@email.com', '2010-12-25', 'male', '444 Scholar Street', 'Learning City', 'EDU', '12346', '555-201-0009', 9, 2, '2023-08-14', 'active', 'Miguel Rodriguez', '555-201-0010', 'miguel.rodriguez@email.com', 'father', 'Ana Rodriguez', '555-201-0011', 'ana.rodriguez@email.com', 'mother', 'Neighbor Jim', '555-201-0012', 'Anxiety', NULL, 'Counseling support', 'walk', 'free'),
-- Edge case: Student with behavior issues
(11, 'VAL2024004', 'Charlotte', 'Lewis', 'Ann', 'charlotte.lewis.parent@email.com', '2011-06-14', 'female', '555 Challenge Ave', 'Learning City', 'EDU', '12346', '555-201-0013', 8, 2, '2023-08-14', 'active', 'Richard Lewis', '555-201-0014', 'richard.lewis@email.com', 'father', 'Susan Lewis', '555-201-0015', 'susan.lewis@email.com', 'mother', 'School Psychologist', '555-201-0016', 'ODD', NULL, 'Behavior intervention plan', 'bus', 'paid'),

-- Mountain View High School Students (Grades 9-12)
(12, 'MTV2024001', 'Alexander', 'Thompson', 'David', 'alexander.thompson.student@email.com', '2008-03-10', 'male', '666 Mountain Peak', 'Learning City', 'EDU', '12347', '555-301-0001', 10, 3, '2023-08-14', 'active', 'David Thompson', '555-301-0002', 'david.thompson@email.com', 'father', 'Michelle Thompson', '555-301-0003', 'michelle.thompson@email.com', 'mother', 'Family Doctor', '555-301-0004', NULL, NULL, NULL, 'car', 'paid'),
(13, 'MTV2024002', 'Mia', 'White', 'Grace', 'mia.white.student@email.com', '2007-08-15', 'female', '777 Summit Circle', 'Learning City', 'EDU', '12347', '555-301-0005', 11, 3, '2023-08-14', 'active', 'Robert White', '555-301-0006', 'robert.white@email.com', 'father', 'Karen White', '555-301-0007', 'karen.white@email.com', 'mother', 'Dr. Smith', '555-301-0008', NULL, 'Gluten', NULL, 'car', 'paid'),
(14, 'MTV2024003', 'Benjamin', 'Harris', 'Lee', 'benjamin.harris.student@email.com', '2006-11-22', 'male', '888 Scholar Heights', 'Learning City', 'EDU', '12347', '555-301-0009', 12, 3, '2023-08-14', 'active', 'Paul Harris', '555-301-0010', 'paul.harris@email.com', 'father', 'Nancy Harris', '555-301-0011', 'nancy.harris@email.com', 'mother', 'Athletic Trainer', '555-301-0012', NULL, NULL, NULL, 'car', 'paid'),
(15, 'MTV2024004', 'Harper', 'Martin', 'Joy', 'harper.martin.student@email.com', '2005-12-03', 'female', '999 Academic Ave', 'Learning City', 'EDU', '12347', '555-301-0013', 13, 3, '2023-08-14', 'active', 'Thomas Martin', '555-301-0014', 'thomas.martin@email.com', 'father', 'Linda Martin', '555-301-0015', 'linda.martin@email.com', 'mother', 'College Counselor', '555-301-0016', NULL, NULL, NULL, 'car', 'none'),
-- Edge case: Student who graduated  
(16, 'MTV2023001', 'Jacob', 'Young', 'William', 'jacob.young.alumni@email.com', '2005-04-18', 'male', '1010 Graduate Lane', 'Learning City', 'EDU', '12347', '555-301-0017', 13, 3, '2019-08-15', 'graduated', 'William Young', '555-301-0018', 'william.young@email.com', 'father', 'Sandra Young', '555-301-0019', 'sandra.young@email.com', 'mother', 'Alumni Office', '555-301-0020', NULL, NULL, NULL, 'car', 'none'),
-- Edge case: Student who transferred out
(17, 'MTV2024005', 'Emily', 'Allen', 'Claire', 'emily.allen.former@email.com', '2007-01-28', 'female', '1111 Transfer Road', 'New City', 'EDU', '54321', '555-301-0021', 11, 3, '2023-08-14', 'transferred', 'Mark Allen', '555-301-0022', 'mark.allen@email.com', 'father', 'Jessica Allen', '555-301-0023', 'jessica.allen@email.com', 'mother', 'School Office', '555-301-0024', NULL, NULL, NULL, 'car', 'paid'),

-- Riverside K-12 Students
(18, 'RIV2024001', 'Lucas', 'King', 'Matthew', 'lucas.king.parent@email.com', '2016-10-11', 'male', '1212 Riverside Dr', 'Riverside', 'EDU', '12348', '555-401-0001', 3, 4, '2023-08-14', 'active', 'Matthew King', '555-401-0002', 'matthew.king@email.com', 'father', 'Amy King', '555-401-0003', 'amy.king@email.com', 'mother', 'Family Friend', '555-401-0004', NULL, NULL, NULL, 'car', 'paid'),
(19, 'RIV2024002', 'Grace', 'Scott', 'Rose', 'grace.scott.parent@email.com', '2009-07-26', 'female', '1313 River Bend', 'Riverside', 'EDU', '12348', '555-401-0005', 10, 4, '2023-08-14', 'active', 'Daniel Scott', '555-401-0006', 'daniel.scott@email.com', 'father', 'Rachel Scott', '555-401-0007', 'rachel.scott@email.com', 'mother', 'Dr. Johnson', '555-401-0008', NULL, NULL, NULL, 'bus', 'reduced'),
-- Edge case: Student with NULL optional fields
(20, 'RIV2024003', 'Aiden', 'Green', NULL, NULL, '2011-02-14', 'prefer_not_to_say', NULL, NULL, NULL, NULL, NULL, 8, 4, '2023-08-14', 'active', 'Guardian Green', '555-401-0009', 'guardian.green@email.com', 'guardian', NULL, NULL, NULL, NULL, 'Emergency Contact', '555-401-0010', NULL, NULL, NULL, 'other', 'free');

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;