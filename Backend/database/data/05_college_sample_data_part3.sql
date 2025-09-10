-- College Sample Data Part 3
-- Course Sections, Enrollments, Assignments, and Complex Relationships

USE college_db;

SET FOREIGN_KEY_CHECKS = 0;

-- ==========================================
-- COURSE SECTIONS (Current Spring 2024 semester)
-- ==========================================

INSERT INTO course_sections (section_id, course_id, semester_id, section_number, faculty_id, room_location, max_enrollment, current_enrollment, waitlist_count, schedule_days, start_time, end_time, start_date, end_date, delivery_method, special_notes, is_active) VALUES

-- English sections
(1, 1, 5, '001', 1, 'Humanities Hall 101', 25, 22, 0, '["monday", "wednesday", "friday"]', '09:00:00', '09:50:00', '2024-01-16', '2024-05-10', 'in_person', 'Writing intensive course', TRUE),
(2, 1, 5, '002', 2, 'Humanities Hall 102', 25, 24, 1, '["tuesday", "thursday"]', '11:00:00', '12:15:00', '2024-01-16', '2024-05-10', 'in_person', NULL, TRUE),
(3, 2, 5, '001', 1, 'Humanities Hall 101', 25, 20, 0, '["monday", "wednesday", "friday"]', '10:00:00', '10:50:00', '2024-01-16', '2024-05-10', 'in_person', 'Prerequisite: ENGL1101', TRUE),
(4, 3, 5, '001', 2, 'Humanities Hall 201', 30, 28, 0, '["tuesday", "thursday"]', '14:00:00', '15:15:00', '2024-01-16', '2024-05-10', 'in_person', 'Literature survey course', TRUE),
(5, 4, 5, '001', 1, 'Humanities Hall 202', 20, 15, 0, '["monday", "wednesday"]', '15:30:00', '16:45:00', '2024-01-16', '2024-05-10', 'in_person', 'Advanced undergraduate seminar', TRUE),

-- Mathematics sections
(6, 7, 5, '001', 3, 'Science Complex 201', 35, 32, 2, '["monday", "wednesday", "friday"]', '08:00:00', '08:50:00', '2024-01-16', '2024-05-10', 'in_person', 'Basic algebra review available', TRUE),
(7, 7, 5, '002', 4, 'Science Complex 202', 35, 30, 0, '["tuesday", "thursday"]', '09:30:00', '10:45:00', '2024-01-16', '2024-05-10', 'in_person', NULL, TRUE),
(8, 8, 5, '001', 3, 'Science Complex 201', 30, 28, 1, '["monday", "wednesday", "friday"]', '10:00:00', '10:50:00', '2024-01-16', '2024-05-10', 'in_person', 'Graphing calculator required', TRUE),
(9, 9, 5, '001', 3, 'Science Complex 301', 28, 25, 0, '["monday", "wednesday", "friday"]', '11:00:00', '11:50:00', '2024-01-16', '2024-05-10', 'in_person', 'Calculus I - main section', TRUE),
(10, 9, 5, '002', 4, 'Science Complex 302', 28, 22, 0, '["tuesday", "thursday"]', '12:30:00', '13:45:00', '2024-01-16', '2024-05-10', 'in_person', 'Evening section available', TRUE),
(11, 10, 5, '001', 3, 'Science Complex 301', 25, 20, 0, '["monday", "wednesday", "friday"]', '13:00:00', '13:50:00', '2024-01-16', '2024-05-10', 'in_person', 'Calculus II', TRUE),
(12, 11, 5, '001', 4, 'Science Complex 303', 20, 18, 0, '["tuesday", "thursday"]', '15:30:00', '16:45:00', '2024-01-16', '2024-05-10', 'in_person', 'Linear Algebra', TRUE),
(13, 12, 5, '001', 4, 'Science Complex 304', 25, 23, 0, '["monday", "wednesday"]', '14:00:00', '15:15:00', '2024-01-16', '2024-05-10', 'hybrid', 'Statistics with lab component', TRUE),

-- Biology sections
(14, 13, 5, '001', 5, 'Science Complex 101', 24, 22, 1, '["tuesday", "thursday"]', '09:30:00', '10:45:00', '2024-01-16', '2024-05-10', 'in_person', 'Biology I lecture', TRUE),
(15, 14, 5, '001', 5, 'Science Complex Lab 1', 24, 22, 0, '["tuesday"]', '14:00:00', '16:50:00', '2024-01-16', '2024-05-10', 'in_person', 'Biology I lab - required', TRUE),
(16, 15, 5, '001', 5, 'Science Complex 102', 24, 20, 0, '["monday", "wednesday", "friday"]', '10:00:00', '10:50:00', '2024-01-16', '2024-05-10', 'in_person', 'Biology II lecture', TRUE),
(17, 16, 5, '001', 5, 'Science Complex Lab 2', 24, 20, 0, '["wednesday"]', '14:00:00', '16:50:00', '2024-01-16', '2024-05-10', 'in_person', 'Biology II lab', TRUE),
(18, 17, 5, '001', 5, 'Science Complex 103', 20, 18, 0, '["tuesday", "thursday"]', '11:00:00', '12:15:00', '2024-01-16', '2024-05-10', 'in_person', 'Genetics course', TRUE),

-- Computer Science sections
(19, 18, 5, '001', 6, 'Engineering Building 201', 25, 24, 2, '["monday", "wednesday", "friday"]', '09:00:00', '09:50:00', '2024-01-16', '2024-05-10', 'in_person', 'Intro Programming lecture', TRUE),
(20, 19, 5, '001', 6, 'Engineering Building Lab 1', 25, 24, 0, '["monday"]', '14:00:00', '15:50:00', '2024-01-16', '2024-05-10', 'in_person', 'Programming lab', TRUE),
(21, 20, 5, '001', 6, 'Engineering Building 202', 24, 22, 0, '["tuesday", "thursday"]', '10:00:00', '11:15:00', '2024-01-16', '2024-05-10', 'in_person', 'Software Development', TRUE),
(22, 21, 5, '001', 6, 'Engineering Building Lab 2', 24, 22, 0, '["thursday"]', '14:00:00', '15:50:00', '2024-01-16', '2024-05-10', 'in_person', 'Software Dev lab', TRUE),
(23, 22, 5, '001', 6, 'Engineering Building 301', 20, 18, 0, '["monday", "wednesday", "friday"]', '11:00:00', '11:50:00', '2024-01-16', '2024-05-10', 'in_person', 'Data Structures & Algorithms', TRUE),
(24, 23, 5, '001', 6, 'Engineering Building 302', 18, 15, 0, '["tuesday", "thursday"]', '15:30:00', '16:45:00', '2024-01-16', '2024-05-10', 'in_person', 'Artificial Intelligence', TRUE),

-- Business sections
(25, 24, 5, '001', 7, 'Business Building 101', 30, 28, 1, '["monday", "wednesday", "friday"]', '08:00:00', '08:50:00', '2024-01-16', '2024-05-10', 'in_person', 'Accounting I', TRUE),
(26, 24, 5, '002', 7, 'Business Building 102', 30, 25, 0, '["tuesday", "thursday"]', '12:30:00', '13:45:00', '2024-01-16', '2024-05-10', 'in_person', 'Evening section', TRUE),
(27, 25, 5, '001', 7, 'Business Building 101', 30, 24, 0, '["monday", "wednesday", "friday"]', '10:00:00', '10:50:00', '2024-01-16', '2024-05-10', 'in_person', 'Accounting II', TRUE),
(28, 26, 5, '001', 7, 'Business Building 201', 35, 32, 2, '["tuesday", "thursday"]', '09:30:00', '10:45:00', '2024-01-16', '2024-05-10', 'in_person', 'Management principles', TRUE),
(29, 27, 5, '001', 11, 'Business Building 202', 35, 30, 0, '["monday", "wednesday", "friday"]', '13:00:00', '13:50:00', '2024-01-16', '2024-05-10', 'in_person', 'Marketing basics', TRUE),
(30, 28, 5, '001', 7, 'Business Building 301', 25, 22, 0, '["tuesday", "thursday"]', '14:00:00', '15:15:00', '2024-01-16', '2024-05-10', 'in_person', 'Corporate Finance', TRUE),

-- Education sections
(31, 29, 5, '001', 8, 'Education Building 101', 20, 18, 0, '["monday", "wednesday"]', '09:00:00', '10:15:00', '2024-01-16', '2024-05-10', 'in_person', 'Elementary methods', TRUE),
(32, 30, 5, '001', 8, 'Local Elementary Schools', 20, 18, 0, '["tuesday", "thursday"]', '08:00:00', '11:00:00', '2024-01-16', '2024-05-10', 'in_person', 'Field experience required', TRUE),
(33, 31, 5, '001', 8, 'Education Building 201', 18, 16, 0, '["tuesday", "thursday"]', '15:30:00', '16:45:00', '2024-01-16', '2024-05-10', 'in_person', 'Secondary methods', TRUE),
(34, 32, 5, '001', 8, 'Local High Schools', 18, 16, 0, '["monday", "wednesday", "friday"]', '08:00:00', '11:00:00', '2024-01-16', '2024-05-10', 'in_person', 'High school field work', TRUE),

-- Nursing sections
(35, 33, 5, '001', 9, 'Health Sciences 101', 16, 15, 1, '["monday", "wednesday", "friday"]', '08:00:00', '08:50:00', '2024-01-16', '2024-05-10', 'in_person', 'Nursing fundamentals', TRUE),
(36, 34, 5, '001', 9, 'Nursing Skills Lab', 16, 15, 0, '["tuesday"]', '09:00:00', '11:50:00', '2024-01-16', '2024-05-10', 'in_person', 'Skills lab required', TRUE),
(37, 35, 5, '001', 9, 'Health Sciences 201', 14, 12, 0, '["monday", "wednesday", "friday"]', '10:00:00', '10:50:00', '2024-01-16', '2024-05-10', 'in_person', 'Med-Surg Nursing', TRUE),
(38, 36, 5, '001', 9, 'University Hospital', 14, 12, 0, '["tuesday", "thursday"]', '07:00:00', '15:00:00', '2024-01-16', '2024-05-10', 'in_person', 'Hospital clinical', TRUE),

-- Graduate sections
(39, 37, 5, '001', 1, 'Graduate Seminar Room', 10, 8, 0, '["wednesday"]', '18:00:00', '20:30:00', '2024-01-16', '2024-05-10', 'in_person', 'Graduate seminar', TRUE),
(40, 38, 5, '001', 3, 'Science Complex 401', 8, 6, 0, '["monday"]', '19:00:00', '21:30:00', '2024-01-16', '2024-05-10', 'in_person', 'Advanced mathematics', TRUE),
(41, 39, 5, '001', 6, 'Engineering Building 401', 12, 10, 0, '["thursday"]', '18:30:00', '21:00:00', '2024-01-16', '2024-05-10', 'in_person', 'Advanced algorithms', TRUE),
(42, 40, 5, '001', 7, 'Business Building 401', 15, 13, 0, '["tuesday"]', '18:00:00', '20:30:00', '2024-01-16', '2024-05-10', 'in_person', 'MBA Strategic Management', TRUE),

-- Online sections
(43, 1, 5, 'ON1', 1, 'Online Platform', 50, 35, 0, '["asynchronous"]', NULL, NULL, '2024-01-16', '2024-05-10', 'online', 'Fully online composition', TRUE),
(44, 26, 5, 'ON1', 7, 'Online Platform', 40, 28, 0, '["asynchronous"]', NULL, NULL, '2024-01-16', '2024-05-10', 'online', 'Online management course', TRUE),

-- Edge case: Section with very low enrollment
(45, 5, 5, '001', 2, 'Humanities Hall 301', 15, 4, 0, '["friday"]', '14:00:00', '16:30:00', '2024-01-16', '2024-05-10', 'in_person', 'Low enrollment - may cancel', TRUE),

-- Edge case: Waitlisted section
(46, 22, 5, '002', 6, 'Engineering Building 303', 20, 20, 8, '["monday", "wednesday", "friday"]', '14:00:00', '14:50:00', '2024-01-16', '2024-05-10', 'in_person', 'High demand course', TRUE);

-- ==========================================
-- STUDENT ENROLLMENTS
-- ==========================================

INSERT INTO enrollments (enrollment_id, student_id, section_id, enrollment_date, enrollment_type, final_grade, grade_points, credit_hours, status, midterm_grade, attendance_percentage, participation_score, notes, tuition_charged, payment_status) VALUES

-- Emma Johnson (junior, English major) - student_id = 1
(1, 1, 5, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'A-', 96.5, 85.0, 'Excellent student, strong writer', 1350.00, 'paid'),
(2, 1, 18, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'B+', 94.2, 90.0, 'Good participation in genetics', 1350.00, 'paid'),
(3, 1, 29, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'A', 98.1, 95.0, 'Strong marketing sense', 1350.00, 'paid'),
(4, 1, 12, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'B', 91.3, 75.0, 'Struggles with linear algebra', 1350.00, 'paid'),

-- Liam Smith (junior, Computer Science) - student_id = 2
(5, 2, 21, '2024-01-16', 'regular', NULL, NULL, 4, 'enrolled', 'A-', 89.7, 88.0, 'Great programmer, attendance issues', 1800.00, 'paid'),
(6, 2, 22, '2024-01-16', 'regular', NULL, NULL, 1, 'enrolled', 'A', 89.7, 90.0, 'Excellent in lab work', 450.00, 'paid'),
(7, 2, 23, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'B+', 87.4, 85.0, 'Good algorithmic thinking', 1350.00, 'paid'),
(8, 2, 13, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'B', 92.1, 70.0, 'Math is challenging', 1350.00, 'paid'),

-- Olivia Brown (sophomore, Biology) - student_id = 3
(9, 3, 16, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'A', 97.8, 95.0, 'Outstanding biology student', 1350.00, 'paid'),
(10, 3, 17, '2024-01-16', 'regular', NULL, NULL, 1, 'enrolled', 'A', 97.8, 98.0, 'Excellent lab skills', 450.00, 'paid'),
(11, 3, 11, '2024-01-16', 'regular', NULL, NULL, 4, 'enrolled', 'A-', 95.6, 90.0, 'Strong in calculus II', 1800.00, 'paid'),
(12, 3, 3, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'B+', 94.2, 88.0, 'Good writing skills', 1350.00, 'paid'),

-- Noah Davis (freshman, Accounting) - student_id = 4
(13, 4, 1, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'B-', 85.3, 75.0, 'Needs writing improvement', 1350.00, 'paid'),
(14, 4, 6, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'C+', 82.7, 70.0, 'Math foundation needs work', 1350.00, 'paid'),
(15, 4, 25, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'B', 88.9, 80.0, 'Good business aptitude', 1350.00, 'paid'),
(16, 4, 28, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'B+', 90.1, 85.0, 'Shows management potential', 1350.00, 'paid'),

-- Ava Wilson (sophomore, Nursing) - student_id = 5
(17, 5, 35, '2024-01-16', 'regular', NULL, NULL, 4, 'enrolled', 'A', 98.7, 98.0, 'Exceptional nursing student', 1800.00, 'paid'),
(18, 5, 36, '2024-01-16', 'regular', NULL, NULL, 1, 'enrolled', 'A', 98.7, 100.0, 'Perfect lab performance', 450.00, 'paid'),
(19, 5, 14, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'A-', 96.4, 92.0, 'Strong science background', 1350.00, 'paid'),
(20, 5, 15, '2024-01-16', 'regular', NULL, NULL, 1, 'enrolled', 'A', 96.4, 95.0, 'Excellent lab work', 450.00, 'paid'),

-- William Martinez (junior transfer, Computer Science) - student_id = 6
(21, 6, 23, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'B+', 91.2, 85.0, 'Transfer student adjusting well', 1350.00, 'paid'),
(22, 6, 24, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'A-', 93.5, 90.0, 'Strong AI interest', 1350.00, 'paid'),
(23, 6, 12, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'B', 89.8, 80.0, 'Math skills developing', 1350.00, 'paid'),

-- Sofia Anderson (sophomore, English, international) - student_id = 7
(24, 7, 3, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'B+', 92.1, 88.0, 'ESL student improving', 1350.00, 'paid'),
(25, 7, 4, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'A-', 94.7, 92.0, 'Good cultural perspective', 1350.00, 'paid'),
(26, 7, 8, '2024-01-16', 'regular', NULL, NULL, 4, 'enrolled', 'B', 88.3, 75.0, 'Math challenge for humanities student', 1800.00, 'paid'),

-- Mason Taylor (graduate student, English MA) - student_id = 8
(27, 8, 39, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'A', 96.8, 95.0, 'Excellent graduate student', 1350.00, 'paid'),
(28, 8, 5, '2024-01-16', 'audit', NULL, NULL, 0, 'enrolled', NULL, 85.2, 70.0, 'Auditing for background', 0.00, 'not_required'),

-- Isabella Garcia (graduate student, Computer Science MS) - student_id = 9
(29, 9, 41, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'A-', 94.6, 90.0, 'Strong research potential', 1350.00, 'paid'),
(30, 9, 24, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'A', 97.2, 95.0, 'AI research assistant', 1350.00, 'paid'),

-- Ethan Rodriguez (non-traditional, part-time Business) - student_id = 10
(31, 10, 26, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'B+', 79.5, 85.0, 'Veteran bringing work experience', 1350.00, 'partial'),
(32, 10, 44, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'A-', 91.8, 90.0, 'Excellent online participation', 1350.00, 'partial'),

-- Charlotte Lewis (freshman, North Campus) - student_id = 11
(33, 11, 43, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'C+', 76.3, 65.0, 'Struggling with college transition', 1350.00, 'paid'),

-- Alexander Thompson (sophomore, North Campus) - student_id = 12
(34, 12, 43, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'B-', 83.7, 75.0, 'Anxiety affecting performance', 1350.00, 'paid'),

-- Mia White (online student) - student_id = 13
(35, 13, 43, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'B+', 92.5, 88.0, 'Good online learner', 1350.00, 'paid'),
(36, 13, 44, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'A-', 94.1, 90.0, 'Excellent online engagement', 1350.00, 'paid'),

-- Benjamin Harris (online, working professional) - student_id = 14
(37, 14, 43, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'A', 88.9, 95.0, 'Mature student, work experience', 1350.00, 'paid'),
(38, 14, 44, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'A-', 90.2, 92.0, 'Applies concepts to work', 1350.00, 'paid'),

-- Harper Martin (junior, English honors) - student_id = 15
(39, 15, 5, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'A+', 99.1, 100.0, 'Outstanding honors student', 1350.00, 'paid'),
(40, 15, 4, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'A+', 98.9, 98.0, 'Exceptional literary analysis', 1350.00, 'paid'),
(41, 15, 39, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'A', 97.8, 95.0, 'Advanced undergraduate in grad course', 1350.00, 'paid'),

-- Grace Scott (dual enrollment high school student) - student_id = 19
(42, 19, 1, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'A', 98.5, 92.0, 'Exceptional high school student', 0.00, 'not_required'),
(43, 19, 6, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'A-', 96.7, 88.0, 'Strong in mathematics', 0.00, 'not_required'),

-- Aiden Green (freshman with academic challenges) - student_id = 20
(44, 20, 1, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'D+', 68.4, 60.0, 'Struggling, needs support services', 1350.00, 'overdue'),
(45, 20, 7, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'C-', 72.1, 65.0, 'Math difficulties', 1350.00, 'overdue'),

-- Edge cases and special enrollments
-- Student who dropped mid-semester
(46, 17, 1, '2024-01-16', 'regular', 'W', 0.00, 3, 'withdrawn', 'F', 45.2, 40.0, 'Withdrew due to personal issues', 1350.00, 'refunded'),
(47, 17, 6, '2024-01-16', 'regular', 'W', 0.00, 3, 'withdrawn', 'D', 45.2, 35.0, 'Withdrew same time', 1350.00, 'refunded'),

-- Graduate student with incomplete
(48, 9, 23, '2023-08-21', 'regular', 'I', 0.00, 3, 'incomplete', 'B+', 92.0, 85.0, 'Incomplete due to research obligations', 1350.00, 'paid'),

-- Student retaking a course
(49, 4, 7, '2024-01-16', 'regular', NULL, NULL, 3, 'enrolled', 'C', 78.9, 70.0, 'Retaking course for better grade', 1350.00, 'paid');

-- ==========================================
-- ASSIGNMENTS
-- ==========================================

INSERT INTO assignments (assignment_id, section_id, assignment_name, description, assignment_type, total_points, weight_percentage, due_date, assigned_date, late_policy, submission_format, group_assignment, max_group_size, rubric, instructions, resources_needed, estimated_hours, is_extra_credit) VALUES

-- English Composition assignments
(1, 1, 'Personal Narrative Essay', 'Write a 750-word personal narrative essay', 'paper', 100.00, 15.00, '2024-02-15 23:59:00', '2024-01-22 09:00:00', '10% deduction per day late', 'online', FALSE, 1, '{"content": 30, "organization": 25, "style": 25, "mechanics": 20}', 'Follow MLA format, submit via learning management system', 'Computer with word processor, MLA handbook', 4.0, FALSE),
(2, 1, 'Research Paper', 'Write a 1500-word argumentative research paper', 'paper', 200.00, 25.00, '2024-04-01 23:59:00', '2024-02-20 09:00:00', 'No late submissions accepted', 'online', FALSE, 1, '{"thesis": 25, "evidence": 30, "analysis": 25, "documentation": 20}', 'Minimum 5 scholarly sources required', 'Library access, research databases', 8.0, FALSE),
(3, 1, 'Midterm Exam', 'Comprehensive grammar and writing concepts exam', 'exam', 150.00, 20.00, '2024-03-15 11:00:00', '2024-03-01 09:00:00', 'Make-up only with documentation', 'paper', FALSE, 1, '{"grammar": 40, "writing_concepts": 35, "analysis": 25}', 'Bring blue books and pencils', 'Study guide provided', 3.0, FALSE),
(4, 1, 'Final Portfolio', 'Compilation of revised essays from semester', 'portfolio', 200.00, 25.00, '2024-05-10 17:00:00', '2024-04-15 09:00:00', 'Late penalty: full letter grade', 'both', FALSE, 1, '{"revision_quality": 40, "reflection": 30, "presentation": 30}', 'Include reflection letter and all drafts', 'Binder or folder for physical copy', 6.0, FALSE),

-- Victorian Literature assignments  
(5, 5, 'Character Analysis Paper', 'Analyze character development in Dickens novel', 'paper', 100.00, 20.00, '2024-03-01 23:59:00', '2024-02-12 15:30:00', '5% per day late, max 3 days', 'online', FALSE, 1, '{"analysis_depth": 35, "textual_evidence": 30, "writing_quality": 35}', 'Use primary text evidence extensively', 'Novel text, literary criticism resources', 5.0, FALSE),
(6, 5, 'Group Presentation', 'Present on Victorian social contexts', 'presentation', 150.00, 25.00, '2024-04-05 15:30:00', '2024-03-15 15:30:00', 'Must present on assigned date', 'presentation', TRUE, 4, '{"content_knowledge": 40, "presentation_skills": 30, "visual_aids": 30}', '15-20 minutes, all members must participate', 'Presentation software, projection capability', 8.0, FALSE),

-- Calculus assignments
(7, 9, 'Homework Set 1', 'Limits and continuity problems', 'homework', 50.00, 5.00, '2024-02-02 23:59:00', '2024-01-26 11:00:00', '50% credit if late, 0% after solutions posted', 'paper', FALSE, 1, '{"correctness": 70, "work_shown": 30}', 'Show all work for partial credit', 'Textbook, graphing calculator', 3.0, FALSE),
(8, 9, 'Exam 1', 'First exam covering limits and derivatives', 'exam', 100.00, 15.00, '2024-02-20 11:00:00', '2024-02-15 11:00:00', 'No make-ups without prior arrangement', 'paper', FALSE, 1, '{"problem_solving": 60, "computation": 25, "conceptual": 15}', 'Bring calculator, show all work', 'Graphing calculator (specific models allowed)', 2.0, FALSE),
(9, 9, 'Application Project', 'Real-world calculus application', 'project', 75.00, 10.00, '2024-04-15 23:59:00', '2024-03-25 11:00:00', '10% per day late', 'both', FALSE, 1, '{"mathematical_content": 40, "real_world_connection": 30, "presentation": 30}', 'Choose from approved topics list', 'Research materials, presentation software', 6.0, FALSE),

-- Computer Science assignments
(10, 19, 'Programming Assignment 1', 'Basic Python programming exercises', 'homework', 100.00, 15.00, '2024-02-10 23:59:00', '2024-01-30 09:00:00', 'Late submission closes 48 hours after due date', 'online', FALSE, 1, '{"correctness": 50, "style": 25, "documentation": 25}', 'Submit .py files via course portal', 'Python IDE, course textbook', 8.0, FALSE),
(11, 21, 'Software Design Project', 'Design and implement object-oriented system', 'project', 200.00, 25.00, '2024-04-20 23:59:00', '2024-03-01 10:00:00', 'No extensions without prior approval', 'online', TRUE, 3, '{"design": 30, "implementation": 40, "documentation": 20, "presentation": 10}', 'Follow software engineering practices', 'Development environment, version control', 20.0, FALSE),
(12, 23, 'Algorithm Analysis', 'Analyze time and space complexity', 'homework', 75.00, 10.00, '2024-03-10 23:59:00', '2024-02-28 11:00:00', 'Solutions posted 24 hours after due date', 'paper', FALSE, 1, '{"analysis_correctness": 60, "explanation_clarity": 40}', 'Show mathematical analysis', 'Algorithm textbook, mathematical notation', 4.0, FALSE),

-- Biology assignments
(13, 14, 'Lab Report 1', 'Microscopy and cell structure observations', 'lab', 50.00, 8.00, '2024-02-08 23:59:00', '2024-01-30 14:00:00', '10% per day late', 'online', FALSE, 1, '{"observations": 30, "analysis": 35, "conclusions": 35}', 'Include detailed drawings and measurements', 'Lab notebook, microscope images', 3.0, FALSE),
(14, 16, 'Ecology Field Study', 'Biodiversity assessment project', 'project', 100.00, 15.00, '2024-03-30 23:59:00', '2024-03-05 10:00:00', 'Field work must be completed by due date', 'both', TRUE, 4, '{"data_collection": 30, "analysis": 35, "report": 35}', 'Conduct fieldwork at designated sites', 'Field equipment, identification guides', 12.0, FALSE),
(15, 18, 'Genetics Problem Set', 'Inheritance pattern calculations', 'homework', 75.00, 12.00, '2024-03-25 23:59:00', '2024-03-15 11:00:00', '50% credit if up to 2 days late', 'paper', FALSE, 1, '{"problem_solving": 70, "showing_work": 30}', 'Use Punnett squares and probability', 'Genetics textbook, calculator', 4.0, FALSE),

-- Business assignments
(16, 25, 'Financial Statement Analysis', 'Analyze real company financial statements', 'homework', 100.00, 15.00, '2024-03-15 23:59:00', '2024-02-26 08:00:00', '5% per day late', 'online', FALSE, 1, '{"analysis_accuracy": 40, "interpretation": 35, "presentation": 25}', 'Use provided ratio analysis template', 'Annual reports, spreadsheet software', 6.0, FALSE),
(17, 28, 'Management Case Study', 'Analyze leadership challenges in case study', 'homework', 75.00, 12.00, '2024-04-01 23:59:00', '2024-03-18 09:30:00', 'Late work not accepted', 'online', TRUE, 2, '{"problem_identification": 30, "solutions": 40, "implementation": 30}', 'Apply management theories from course', 'Case study materials, management textbook', 5.0, FALSE),
(18, 29, 'Marketing Campaign Project', 'Develop comprehensive marketing campaign', 'project', 150.00, 20.00, '2024-04-30 23:59:00', '2024-03-20 13:00:00', 'Presentation component cannot be late', 'both', TRUE, 4, '{"strategy": 25, "creativity": 25, "feasibility": 25, "presentation": 25}', 'Present to panel of industry professionals', 'Marketing research, presentation materials', 15.0, FALSE),

-- Nursing assignments
(19, 35, 'Nursing Care Plan', 'Develop care plan for patient scenario', 'homework', 100.00, 20.00, '2024-02-25 23:59:00', '2024-02-10 08:00:00', 'Patient safety critical - no late work', 'paper', FALSE, 1, '{"assessment": 25, "diagnosis": 25, "planning": 25, "implementation": 25}', 'Use NANDA-I format', 'Nursing diagnosis handbook, care plan template', 6.0, FALSE),
(20, 36, 'Skills Competency', 'Demonstrate nursing procedures', 'lab', 100.00, 25.00, '2024-03-20 16:00:00', '2024-02-15 09:00:00', 'Must pass to continue in program', 'presentation', FALSE, 1, '{"technique": 40, "safety": 40, "professionalism": 20}', 'Perform on simulated patients', 'Lab supplies, uniform requirement', 8.0, FALSE),

-- Graduate level assignments
(21, 39, 'Seminar Paper', 'Original research in literary theory', 'paper', 200.00, 40.00, '2024-04-15 23:59:00', '2024-02-01 18:00:00', 'Extensions granted for research delays', 'online', FALSE, 1, '{"originality": 30, "research_depth": 30, "argumentation": 25, "documentation": 15}', 'Minimum 15 scholarly sources', 'Graduate library privileges, research databases', 25.0, FALSE),
(22, 41, 'Algorithm Implementation', 'Implement and test advanced algorithm', 'project', 150.00, 30.00, '2024-04-10 23:59:00', '2024-02-20 18:30:00', 'Code must compile and run', 'online', FALSE, 1, '{"correctness": 40, "efficiency": 30, "documentation": 20, "testing": 10}', 'Provide comprehensive test suite', 'Programming environment, testing framework', 20.0, FALSE),

-- Extra credit assignment
(23, 1, 'Grammar Workshop Attendance', 'Attend optional grammar workshop', 'other', 10.00, 2.00, '2024-03-30 17:00:00', '2024-03-01 09:00:00', 'Must attend full session', 'other', FALSE, 1, '{"attendance": 100}', 'Sign in required, reflection paragraph', 'Workshop materials provided', 2.0, TRUE);

-- ==========================================
-- ASSIGNMENT SUBMISSIONS
-- ==========================================

INSERT INTO assignment_submissions (submission_id, assignment_id, student_id, submission_date, points_earned, letter_grade, percentage_score, feedback, is_late, days_late, late_penalty, attempts_count, time_spent_hours, status, file_path, plagiarism_score, comments_for_student, graded_by_faculty_id, graded_date) VALUES

-- Emma Johnson submissions (excellent student)
(1, 1, 1, '2024-02-15 20:30:00', 95.00, 'A', 95.00, 'Excellent narrative structure and voice. Minor grammar issues.', FALSE, 0, 0.00, 1, 4.5, 'graded', '/submissions/emma_johnson_narrative.docx', 2.5, 'Outstanding work! Keep up the excellent writing.', 1, '2024-02-18 14:30:00'),
(2, 3, 1, '2024-03-15 10:45:00', 142.00, 'A-', 94.67, 'Strong performance on exam, minor issues with grammar section.', FALSE, 0, 0.00, 1, 2.5, 'graded', NULL, NULL, 'Great understanding of concepts.', 1, '2024-03-18 16:00:00'),
(3, 5, 1, '2024-03-01 21:15:00', 88.00, 'B+', 88.00, 'Good analysis but needs stronger textual evidence.', FALSE, 0, 0.00, 1, 5.0, 'graded', '/submissions/emma_johnson_dickens.docx', 5.2, 'Consider more close reading techniques.', 1, '2024-03-05 11:20:00'),

-- Liam Smith submissions (CS student with attendance issues)
(4, 10, 2, '2024-02-12 23:45:00', 85.00, 'B', 85.00, 'Code works but lacks documentation and style.', TRUE, 2, 5.00, 1, 10.0, 'graded', '/submissions/liam_smith_python1.py', 0.0, 'Good logic, improve commenting and style.', 6, '2024-02-15 09:30:00'),
(5, 12, 2, '2024-03-10 22:30:00', 68.00, 'C+', 90.67, 'Good mathematical analysis, needs clearer explanations.', FALSE, 0, 0.00, 1, 3.5, 'graded', '/submissions/liam_smith_algorithm.pdf', NULL, 'Show more work in your analysis.', 6, '2024-03-13 14:15:00'),

-- Olivia Brown submissions (Biology student)
(6, 13, 3, '2024-02-08 19:20:00', 47.00, 'A-', 94.00, 'Excellent observations and detailed drawings.', FALSE, 0, 0.00, 1, 3.5, 'graded', '/submissions/olivia_brown_lab1.pdf', 1.8, 'Outstanding lab technique and reporting.', 5, '2024-02-12 10:45:00'),
(7, 15, 3, '2024-03-25 20:10:00', 72.00, 'A-', 96.00, 'Perfect problem solving, excellent Punnett squares.', FALSE, 0, 0.00, 1, 4.0, 'graded', '/submissions/olivia_brown_genetics.pdf', NULL, 'Exceptional understanding of genetics!', 5, '2024-03-28 13:20:00'),

-- Noah Davis submissions (struggling freshman)
(8, 1, 4, '2024-02-17 23:59:00', 72.00, 'C+', 72.00, 'Basic narrative structure present, needs development.', TRUE, 2, 10.00, 1, 3.0, 'graded', '/submissions/noah_davis_narrative.docx', 8.5, 'Visit writing center for help with organization.', 1, '2024-02-20 16:30:00'),
(9, 16, 4, '2024-03-17 22:15:00', 78.00, 'B-', 78.00, 'Good effort on analysis, some calculation errors.', TRUE, 2, 5.00, 1, 7.0, 'graded', '/submissions/noah_davis_financial.xlsx', 12.3, 'Double-check your ratio calculations.', 7, '2024-03-20 11:00:00'),

-- Ava Wilson submissions (nursing student)
(10, 19, 5, '2024-02-25 18:30:00', 96.00, 'A', 96.00, 'Comprehensive care plan with excellent rationales.', FALSE, 0, 0.00, 1, 6.5, 'graded', '/submissions/ava_wilson_careplan.pdf', 1.2, 'Exceptional nursing assessment skills!', 9, '2024-02-28 14:15:00'),
(11, 20, 5, '2024-03-20 15:45:00', 98.00, 'A+', 98.00, 'Flawless technique and professional demeanor.', FALSE, 0, 0.00, 1, 8.0, 'graded', NULL, NULL, 'Outstanding clinical performance!', 9, '2024-03-20 16:00:00'),

-- Harper Martin submissions (honors student)
(12, 5, 15, '2024-03-01 19:45:00', 98.00, 'A+', 98.00, 'Sophisticated analysis with insightful interpretations.', FALSE, 0, 0.00, 1, 6.0, 'graded', '/submissions/harper_martin_dickens.docx', 0.8, 'Exceptional work worthy of publication!', 1, '2024-03-04 10:30:00'),
(13, 21, 15, '2024-04-15 21:00:00', 195.00, 'A+', 97.50, 'Graduate-level work with original insights.', FALSE, 0, 0.00, 1, 28.0, 'graded', '/submissions/harper_martin_seminar.pdf', 1.5, 'Consider submitting to conference!', 1, '2024-04-20 15:45:00'),

-- Grace Scott submissions (dual enrollment student)
(14, 1, 19, '2024-02-15 16:20:00', 92.00, 'A-', 92.00, 'Impressive work for high school student.', FALSE, 0, 0.00, 1, 4.0, 'graded', '/submissions/grace_scott_narrative.docx', 3.1, 'Exceptional maturity in writing!', 1, '2024-02-18 11:15:00'),
(15, 7, 19, '2024-02-02 20:45:00', 48.00, 'A-', 96.00, 'Perfect homework, excellent mathematical reasoning.', FALSE, 0, 0.00, 1, 2.5, 'graded', '/submissions/grace_scott_hw1.pdf', NULL, 'Outstanding math skills for your age!', 3, '2024-02-05 09:30:00'),

-- Aiden Green submissions (struggling student)
(16, 1, 20, '2024-02-18 23:30:00', 58.00, 'D+', 58.00, 'Weak organization and many grammar errors.', TRUE, 3, 15.00, 2, 2.5, 'graded', '/submissions/aiden_green_narrative_v2.docx', 25.8, 'Please work with academic support services.', 1, '2024-02-22 13:45:00'),
(17, 7, 20, '2024-02-04 23:59:00', 28.00, 'D', 56.00, 'Many computational errors, basic concepts unclear.', TRUE, 2, 10.00, 1, 5.0, 'graded', '/submissions/aiden_green_hw1.pdf', NULL, 'Attend tutoring sessions immediately.', 3, '2024-02-07 14:20:00'),

-- Group assignment submissions
(18, 6, 1, '2024-04-05 15:30:00', 142.00, 'A-', 94.67, 'Excellent group presentation on Victorian society.', FALSE, 0, 0.00, 1, 8.0, 'graded', '/submissions/group_victorian_presentation.pptx', NULL, 'Great teamwork and content knowledge.', 1, '2024-04-05 16:30:00'),
(19, 6, 7, '2024-04-05 15:30:00', 142.00, 'A-', 94.67, 'Excellent group presentation on Victorian society.', FALSE, 0, 0.00, 1, 8.0, 'graded', '/submissions/group_victorian_presentation.pptx', NULL, 'Great teamwork and content knowledge.', 1, '2024-04-05 16:30:00'),

-- Late submission with penalty
(20, 8, 2, '2024-02-22 10:30:00', 75.00, 'C', 75.00, 'Good problem solving but late submission.', TRUE, 2, 10.00, 1, 2.0, 'graded', NULL, NULL, 'Work on time management skills.', 3, '2024-02-25 11:00:00'),

-- Not yet submitted
(21, 2, 1, NULL, NULL, NULL, NULL, NULL, FALSE, 0, 0.00, 0, 0.0, 'not_submitted', NULL, NULL, NULL, NULL, NULL),
(22, 4, 1, NULL, NULL, NULL, NULL, NULL, FALSE, 0, 0.00, 0, 0.0, 'not_submitted', NULL, NULL, NULL, NULL, NULL),

-- Incomplete/Missing submission
(23, 16, 20, NULL, 0.00, 'F', 0.00, 'No submission received.', FALSE, 0, 0.00, 0, 0.0, 'not_submitted', NULL, NULL, 'Assignment not submitted - see me during office hours.', 7, '2024-03-18 17:00:00'),

-- Extra credit submission
(24, 23, 4, '2024-03-30 16:45:00', 9.00, 'B+', 90.00, 'Good attendance and reflection.', FALSE, 0, 0.00, 1, 2.0, 'graded', '/submissions/noah_davis_workshop_reflection.pdf', 5.2, 'Great participation in extra help!', 1, '2024-04-01 10:15:00');

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;