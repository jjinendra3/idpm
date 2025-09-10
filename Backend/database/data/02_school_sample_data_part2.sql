-- Additional Sample Data for School Database (Part 2)
-- Classes, Enrollments, Assignments, Attendance, and More

USE school_db;

SET FOREIGN_KEY_CHECKS = 0;

-- ==========================================
-- CLASSES/SECTIONS
-- ==========================================

INSERT INTO classes (class_id, class_code, class_name, subject_id, teacher_id, campus_id, grade_id, term_id, room_number, max_students, current_enrollment, schedule_time, schedule_days, start_date, end_date, is_active) VALUES

-- Sunrise Elementary Classes (Current Spring 2024 term)
(1, 'SUN-K-READ-001', 'Kindergarten Reading - Section A', 1, 1, 1, 1, 4, '101', 20, 18, '09:00:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),
(2, 'SUN-K-MATH-001', 'Kindergarten Math - Section A', 2, 1, 1, 1, 4, '101', 20, 18, '10:30:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),
(3, 'SUN-1-READ-001', 'First Grade Reading - Section A', 4, 2, 1, 2, 4, '102', 22, 20, '09:00:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),
(4, 'SUN-1-MATH-001', 'First Grade Math - Section A', 5, 2, 1, 2, 4, '102', 22, 20, '10:30:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),
(5, 'SUN-2-READ-001', 'Second Grade Reading - Section A', 6, 2, 1, 3, 4, '103', 24, 22, '09:00:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),
(6, 'SUN-3-READ-001', 'Third Grade Reading - Section A', 8, 3, 1, 4, 4, '201', 25, 23, '09:00:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),
(7, 'SUN-3-MATH-001', 'Third Grade Math - Section A', 9, 3, 1, 4, 4, '201', 25, 23, '10:30:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),
(8, 'SUN-4-READ-001', 'Fourth Grade Reading - Section A', 10, 4, 1, 5, 4, '202', 26, 24, '09:00:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),
(9, 'SUN-4-MATH-001', 'Fourth Grade Math - Section A', 11, 4, 1, 5, 4, '202', 26, 24, '10:30:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),
(10, 'SUN-5-READ-001', 'Fifth Grade Reading - Section A', 12, 4, 1, 6, 4, '203', 28, 25, '09:00:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),

-- Valley Middle School Classes
(11, 'VAL-6-ELA-001', 'Sixth Grade ELA - Period 1', 14, 6, 2, 7, 4, '201', 30, 28, '08:00:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),
(12, 'VAL-6-MATH-001', 'Sixth Grade Math - Period 2', 15, 7, 2, 7, 4, '301', 30, 28, '09:15:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),
(13, 'VAL-6-SCI-001', 'Sixth Grade Science - Period 3', 16, 8, 2, 7, 4, '101', 30, 28, '10:45:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),
(14, 'VAL-7-ELA-001', 'Seventh Grade ELA - Period 1', 18, 6, 2, 8, 4, '202', 30, 26, '08:00:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),
(15, 'VAL-7-MATH-001', 'Seventh Grade Math - Period 2', 19, 7, 2, 8, 4, '302', 30, 26, '09:15:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),
(16, 'VAL-8-ELA-001', 'Eighth Grade ELA - Period 1', 22, 6, 2, 9, 4, '203', 30, 24, '08:00:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),
(17, 'VAL-8-MATH-001', 'Eighth Grade Math - Period 2', 23, 7, 2, 9, 4, '303', 30, 24, '09:15:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),

-- Mountain View High School Classes
(18, 'MTV-ENG9-001', 'English 9 - Period 1', 26, 10, 3, 10, 4, '201', 32, 30, '07:30:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),
(19, 'MTV-ALG1-001', 'Algebra I - Period 2', 27, 11, 3, 10, 4, '301', 32, 30, '08:45:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),
(20, 'MTV-BIO-001', 'Biology - Period 3', 28, 12, 3, 10, 4, '101', 32, 30, '10:15:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),
(21, 'MTV-ENG10-001', 'English 10 - Period 1', 30, 10, 3, 11, 4, '202', 32, 28, '07:30:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),
(22, 'MTV-GEOM-001', 'Geometry - Period 2', 31, 11, 3, 11, 4, '302', 32, 28, '08:45:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),
(23, 'MTV-ENG11-001', 'English 11 - Period 1', 34, 10, 3, 12, 4, '203', 32, 26, '07:30:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),
(24, 'MTV-ALG2-001', 'Algebra II - Period 2', 35, 11, 3, 12, 4, '303', 32, 26, '08:45:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),
(25, 'MTV-ENG12-001', 'English 12 - Period 1', 38, 10, 3, 13, 4, '204', 32, 24, '07:30:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),
(26, 'MTV-APCALC-001', 'AP Calculus - Period 2', 39, 11, 3, 13, 4, '304', 25, 18, '08:45:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),
-- Edge case: Class with low enrollment
(27, 'MTV-SPAN2-001', 'Spanish II - Period 4', 42, 13, 3, 11, 4, '401', 25, 8, '13:00:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),
-- Edge case: Inactive class from previous term
(28, 'MTV-ART1-FALL', 'Art I - Fall 2023', 43, 14, 3, 10, 3, '106', 25, 22, '14:15:00', '["monday", "wednesday", "friday"]', '2023-08-14', '2023-12-19', FALSE),

-- Riverside K-12 Classes
(29, 'RIV-ELEM-001', 'Elementary Integrated - Grades K-2', 48, 18, 4, 1, 4, '101', 15, 12, '08:30:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),
(30, 'RIV-ELEM-002', 'Elementary Integrated - Grades 3-5', 48, 18, 4, 4, 4, '102', 18, 15, '08:30:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),
(31, 'RIV-SEC-001', 'Secondary Integrated - Grades 6-8', 49, 19, 4, 8, 4, '201', 20, 18, '08:30:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE),
(32, 'RIV-SEC-002', 'Secondary Integrated - Grades 9-12', 49, 19, 4, 10, 4, '202', 22, 20, '08:30:00', '["monday", "tuesday", "wednesday", "thursday", "friday"]', '2024-01-08', '2024-06-14', TRUE);

-- ==========================================
-- STUDENT ENROLLMENTS
-- ==========================================

INSERT INTO enrollments (enrollment_id, student_id, class_id, enrollment_date, final_grade, grade_points, attendance_percentage, status, notes) VALUES

-- Sunrise Elementary Enrollments
(1, 1, 1, '2024-01-08', NULL, NULL, 95.5, 'enrolled', 'Excellent reading progress'),
(2, 1, 2, '2024-01-08', NULL, NULL, 95.5, 'enrolled', 'Strong math skills'),
(3, 2, 1, '2024-01-08', NULL, NULL, 87.2, 'enrolled', 'Needs extra reading support'),
(4, 2, 2, '2024-01-08', NULL, NULL, 87.2, 'enrolled', 'Good with numbers'),
(5, 3, 3, '2024-01-08', NULL, NULL, 98.1, 'enrolled', 'Advanced reader'),
(6, 3, 4, '2024-01-08', NULL, NULL, 98.1, 'enrolled', 'Math comes naturally'),
(7, 4, 6, '2024-01-08', NULL, NULL, 91.8, 'enrolled', 'Steady improvement'),
(8, 4, 7, '2024-01-08', NULL, NULL, 91.8, 'enrolled', 'Enjoys problem solving'),
(9, 5, 8, '2024-01-08', NULL, NULL, 96.3, 'enrolled', 'Strong academic performance'),
(10, 5, 9, '2024-01-08', NULL, NULL, 96.3, 'enrolled', 'Excellent math student'),
(11, 6, 10, '2024-01-08', NULL, NULL, 89.7, 'enrolled', 'Improving reading fluency'),
(12, 7, 6, '2024-01-15', NULL, NULL, 88.5, 'enrolled', 'Transfer student - adjusting well'),

-- Valley Middle School Enrollments  
(13, 8, 11, '2024-01-08', NULL, NULL, 94.2, 'enrolled', 'Strong writer'),
(14, 8, 12, '2024-01-08', NULL, NULL, 94.2, 'enrolled', 'Good with pre-algebra'),
(15, 8, 13, '2024-01-08', NULL, NULL, 94.2, 'enrolled', 'Curious about science'),
(16, 9, 14, '2024-01-08', NULL, NULL, 92.8, 'enrolled', 'Creative writing talent'),
(17, 9, 15, '2024-01-08', NULL, NULL, 92.8, 'enrolled', 'Solid math foundation'),
(18, 10, 16, '2024-01-08', NULL, NULL, 85.4, 'enrolled', 'Struggles with attention'),
(19, 10, 17, '2024-01-08', NULL, NULL, 85.4, 'enrolled', 'Better in hands-on activities'),
(20, 11, 16, '2024-01-08', NULL, NULL, 78.9, 'enrolled', 'Behavior intervention in place'),
(21, 11, 17, '2024-01-08', NULL, NULL, 78.9, 'enrolled', 'Shows improvement with structure'),

-- Mountain View High School Enrollments
(22, 12, 18, '2024-01-08', NULL, NULL, 96.8, 'enrolled', 'Excellent student'),
(23, 12, 19, '2024-01-08', NULL, NULL, 96.8, 'enrolled', 'Strong in algebra'),
(24, 12, 20, '2024-01-08', NULL, NULL, 96.8, 'enrolled', 'Interested in pre-med'),
(25, 13, 21, '2024-01-08', NULL, NULL, 94.1, 'enrolled', 'Good analytical skills'),
(26, 13, 22, '2024-01-08', NULL, NULL, 94.1, 'enrolled', 'Geometry comes easily'),
(27, 14, 23, '2024-01-08', NULL, NULL, 97.5, 'enrolled', 'College prep track'),
(28, 14, 24, '2024-01-08', NULL, NULL, 97.5, 'enrolled', 'Advanced math student'),
(29, 15, 25, '2024-01-08', NULL, NULL, 99.2, 'enrolled', 'Valedictorian candidate'),
(30, 15, 26, '2024-01-08', NULL, NULL, 99.2, 'enrolled', 'Exceptional in calculus'),
-- Edge case: Student with mixed performance
(31, 13, 27, '2024-01-08', NULL, NULL, 73.6, 'enrolled', 'Attendance issues affecting grade'),
-- Edge case: Completed enrollment from previous term
(32, 16, 28, '2023-08-14', 'A', 4.00, 98.5, 'completed', 'Graduated - excellent art portfolio'),

-- Riverside K-12 Enrollments
(33, 18, 29, '2024-01-08', NULL, NULL, 93.7, 'enrolled', 'Enjoys integrated learning'),
(34, 19, 32, '2024-01-08', NULL, NULL, 91.4, 'enrolled', 'Strong in all subjects'),
(35, 20, 31, '2024-01-08', NULL, NULL, 82.1, 'enrolled', 'Quiet but engaged');

-- ==========================================
-- ASSIGNMENTS
-- ==========================================

INSERT INTO assignments (assignment_id, class_id, assignment_name, description, assignment_type, total_points, due_date, assigned_date, is_extra_credit, weight, rubric, instructions) VALUES

-- Elementary Assignments
(1, 1, 'Letter Recognition Quiz', 'Identify uppercase and lowercase letters A-M', 'quiz', 26.00, '2024-02-15 23:59:00', '2024-02-08 08:00:00', FALSE, 1.00, '{"criteria": ["accuracy", "speed", "letter formation"]}', 'Circle the matching letters and write your name'),
(2, 1, 'Phonics Worksheet', 'Match pictures to beginning sounds', 'homework', 20.00, '2024-02-20 23:59:00', '2024-02-15 08:00:00', FALSE, 1.00, '{"criteria": ["correct matches", "neatness"]}', 'Draw lines to connect pictures with sounds'),
(3, 2, 'Counting to 20', 'Count objects and write numbers', 'homework', 20.00, '2024-02-18 23:59:00', '2024-02-12 08:00:00', FALSE, 1.00, '{"criteria": ["accurate counting", "number writing"]}', 'Count the items in each group and write the number'),
(4, 6, 'Reading Comprehension Test', 'Answer questions about "Charlotte\'s Web" Chapter 1', 'test', 50.00, '2024-03-01 14:00:00', '2024-02-20 08:00:00', FALSE, 2.00, '{"criteria": ["comprehension", "vocabulary", "inference"]}', 'Read carefully and answer in complete sentences'),
(5, 8, 'Multiplication Facts Quiz', 'Timed quiz on 3x and 4x tables', 'quiz', 30.00, '2024-02-25 10:00:00', '2024-02-18 08:00:00', FALSE, 1.50, '{"criteria": ["accuracy", "speed"]}', 'Complete as many as you can in 5 minutes'),

-- Middle School Assignments
(6, 11, 'Persuasive Essay', 'Write a 3-paragraph essay on school uniforms', 'homework', 100.00, '2024-03-05 23:59:00', '2024-02-20 08:00:00', FALSE, 3.00, '{"criteria": ["thesis statement", "supporting evidence", "conclusion", "grammar"]}', 'Use the persuasive essay format we practiced in class'),
(7, 12, 'Pre-Algebra Project', 'Create a poster showing real-world uses of algebra', 'project', 75.00, '2024-03-10 23:59:00', '2024-02-25 08:00:00', FALSE, 2.50, '{"criteria": ["creativity", "mathematical accuracy", "presentation"]}', 'Include at least 5 examples with explanations'),
(8, 13, 'Science Fair Experiment', 'Design and conduct a simple experiment', 'project', 150.00, '2024-04-15 23:59:00', '2024-03-01 08:00:00', FALSE, 4.00, '{"criteria": ["hypothesis", "methodology", "results", "conclusion", "presentation"]}', 'Follow the scientific method steps we learned'),
(9, 16, 'Book Report', 'Analysis of a biography', 'homework', 80.00, '2024-03-15 23:59:00', '2024-03-01 08:00:00', FALSE, 2.00, '{"criteria": ["summary", "analysis", "personal connection"]}', 'Choose from the approved biography list'),

-- High School Assignments
(10, 18, 'Shakespearean Sonnet Analysis', 'Detailed analysis of Sonnet 18', 'homework', 100.00, '2024-03-12 23:59:00', '2024-03-05 08:00:00', FALSE, 2.00, '{"criteria": ["literary devices", "theme analysis", "structure", "writing quality"]}', 'Use MLA format and include works cited'),
(11, 19, 'Quadratic Functions Test', 'Comprehensive test on quadratic equations and graphs', 'test', 100.00, '2024-03-08 10:15:00', '2024-02-28 08:00:00', FALSE, 3.00, '{"criteria": ["problem solving", "graphing accuracy", "algebraic manipulation"]}', 'Show all work for partial credit'),
(12, 20, 'Cell Structure Lab Report', 'Microscope observation of plant and animal cells', 'lab', 75.00, '2024-03-20 23:59:00', '2024-03-13 08:00:00', FALSE, 2.50, '{"criteria": ["observations", "drawings", "comparisons", "conclusions"]}', 'Include detailed labeled diagrams'),
(13, 25, 'Senior Research Paper', 'Choose any topic in American literature', 'paper', 200.00, '2024-05-01 23:59:00', '2024-03-15 08:00:00', FALSE, 5.00, '{"criteria": ["thesis", "research quality", "argumentation", "citations", "grammar"]}', 'Minimum 8 pages, 10 scholarly sources'),
-- Edge case: Extra credit assignment
(14, 26, 'Calculus Challenge Problem', 'Solve advanced integration problem', 'homework', 25.00, '2024-03-25 23:59:00', '2024-03-18 08:00:00', TRUE, 1.00, '{"criteria": ["mathematical reasoning", "solution accuracy"]}', 'This is optional for extra credit'),
-- Edge case: Group assignment
(15, 27, 'Spanish Cultural Presentation', 'Group presentation on Hispanic country', 'presentation', 100.00, '2024-04-10 14:00:00', '2024-03-20 08:00:00', FALSE, 3.00, '{"criteria": ["content accuracy", "language use", "visual aids", "participation"]}', 'Groups of 3-4 students, 10 minutes each');

-- ==========================================
-- ASSIGNMENT SUBMISSIONS
-- ==========================================

INSERT INTO assignment_submissions (submission_id, assignment_id, student_id, submission_date, points_earned, letter_grade, feedback, is_late, late_penalty, attempts, status) VALUES

-- Kindergarten submissions
(1, 1, 1, '2024-02-15 15:30:00', 24.00, 'A-', 'Excellent work! Missed 2 letters but great effort', FALSE, 0.00, 1, 'graded'),
(2, 1, 2, '2024-02-16 10:15:00', 18.00, 'C+', 'Good progress, practice lowercase letters more', TRUE, 1.00, 1, 'graded'),
(3, 2, 1, '2024-02-20 14:20:00', 20.00, 'A', 'Perfect! Great understanding of phonics', FALSE, 0.00, 1, 'graded'),
(4, 3, 1, '2024-02-18 16:45:00', 19.00, 'A-', 'Very good counting, number 15 was backwards', FALSE, 0.00, 1, 'graded'),
(5, 3, 2, '2024-02-19 18:30:00', 15.00, 'C', 'Counted correctly, work on number formation', TRUE, 2.00, 1, 'graded'),

-- Third grade submissions
(6, 4, 4, '2024-03-01 13:45:00', 46.00, 'A-', 'Great comprehension! Work on spelling', FALSE, 0.00, 1, 'graded'),
(7, 4, 7, '2024-03-01 13:50:00', 38.00, 'B', 'Good understanding, expand your answers more', FALSE, 0.00, 1, 'graded'),

-- Fourth grade submissions  
(8, 5, 5, '2024-02-25 09:45:00', 28.00, 'A-', 'Excellent speed and accuracy!', FALSE, 0.00, 1, 'graded'),

-- Middle school submissions
(9, 6, 8, '2024-03-05 22:15:00', 92.00, 'A-', 'Strong argument and good evidence. Watch grammar.', FALSE, 0.00, 1, 'graded'),
(10, 7, 8, '2024-03-10 20:30:00', 70.00, 'B', 'Creative poster but some math errors', FALSE, 0.00, 1, 'graded'),
(11, 8, 9, '2024-04-15 16:00:00', 135.00, 'A', 'Outstanding experiment design and execution!', FALSE, 0.00, 1, 'graded'),
(12, 9, 10, '2024-03-17 19:45:00', 65.00, 'C+', 'Good summary but analysis was shallow', TRUE, 5.00, 1, 'graded'),

-- High school submissions
(13, 10, 12, '2024-03-12 21:30:00', 95.00, 'A', 'Excellent analysis of literary devices and themes', FALSE, 0.00, 1, 'graded'),
(14, 11, 12, '2024-03-08 10:15:00', 88.00, 'B+', 'Good problem solving, minor graphing errors', FALSE, 0.00, 1, 'graded'),
(15, 12, 12, '2024-03-20 23:45:00', 72.00, 'B', 'Good observations, drawings need more detail', FALSE, 0.00, 1, 'graded'),
(16, 13, 15, NULL, NULL, NULL, NULL, FALSE, 0.00, 0, 'not_submitted'), -- Not yet submitted
-- Edge case: Late submission with penalty
(17, 11, 13, '2024-03-10 14:30:00', 75.00, 'C+', 'Good work but 2 days late', TRUE, 10.00, 1, 'graded'),
-- Edge case: Extra credit submission
(18, 14, 15, '2024-03-25 20:15:00', 23.00, 'A-', 'Excellent problem solving approach!', FALSE, 0.00, 1, 'graded'),
-- Edge case: Multiple attempts (resubmission)
(19, 6, 10, '2024-03-07 23:59:00', 78.00, 'B-', 'Much improved from first draft', TRUE, 2.00, 2, 'graded');

-- ==========================================
-- ATTENDANCE RECORDS
-- ==========================================

INSERT INTO attendance (attendance_id, student_id, class_id, attendance_date, status, arrival_time, departure_time, notes, marked_by_teacher_id) VALUES

-- Sample attendance for various students over several days
-- Emma Johnson (student_id = 1) - Kindergarten
(1, 1, 1, '2024-03-01', 'present', '08:55:00', '11:30:00', NULL, 1),
(2, 1, 2, '2024-03-01', 'present', '10:25:00', '11:30:00', NULL, 1),
(3, 1, 1, '2024-03-04', 'present', '09:00:00', '11:30:00', NULL, 1),
(4, 1, 1, '2024-03-05', 'tardy', '09:15:00', '11:30:00', 'Doctor appointment', 1),
(5, 1, 1, '2024-03-06', 'absent', NULL, NULL, 'Sick with flu', 1),
(6, 1, 1, '2024-03-07', 'excused', '09:00:00', '11:30:00', 'Return from illness', 1),

-- Liam Smith (student_id = 2) - Kindergarten with ADHD
(7, 2, 1, '2024-03-01', 'present', '09:05:00', '11:30:00', 'Fidgety during circle time', 1),
(8, 2, 1, '2024-03-04', 'present', '09:00:00', '11:25:00', 'Good focus today', 1),
(9, 2, 1, '2024-03-05', 'tardy', '09:20:00', '11:30:00', 'Transportation issue', 1),
(10, 2, 1, '2024-03-06', 'present', '08:58:00', '11:30:00', 'Excellent behavior', 1),

-- Mason Taylor (student_id = 8) - 6th Grade
(11, 8, 11, '2024-03-01', 'present', '07:58:00', '08:50:00', NULL, 6),
(12, 8, 12, '2024-03-01', 'present', '09:12:00', '10:05:00', NULL, 7),
(13, 8, 13, '2024-03-01', 'present', '10:42:00', '11:35:00', NULL, 8),
(14, 8, 11, '2024-03-04', 'present', '08:00:00', '08:50:00', 'Great participation', 6),
(15, 8, 11, '2024-03-05', 'absent', NULL, NULL, 'Family emergency', 6),

-- Charlotte Lewis (student_id = 11) - 8th Grade with behavior issues
(16, 11, 16, '2024-03-01', 'present', '08:03:00', '08:50:00', 'Disrupted class twice', 6),
(17, 11, 17, '2024-03-01', 'present', '09:18:00', '10:05:00', 'Better in math', 7),
(18, 11, 16, '2024-03-04', 'tardy', '08:15:00', '08:50:00', 'Argumentative with teacher', 6),
(19, 11, 16, '2024-03-05', 'excused', '08:00:00', '08:40:00', 'Counseling appointment', 6),

-- Alexander Thompson (student_id = 12) - 9th Grade honors student
(20, 12, 18, '2024-03-01', 'present', '07:28:00', '08:20:00', 'Excellent participation', 10),
(21, 12, 19, '2024-03-01', 'present', '08:43:00', '09:35:00', 'Helped other students', 11),
(22, 12, 20, '2024-03-01', 'present', '10:13:00', '11:05:00', 'Asked insightful questions', 12),
(23, 12, 18, '2024-03-04', 'present', '07:30:00', '08:20:00', NULL, 10),
(24, 12, 18, '2024-03-05', 'present', '07:30:00', '08:20:00', NULL, 10),

-- Harper Martin (student_id = 15) - 12th Grade valedictorian candidate  
(25, 15, 25, '2024-03-01', 'present', '07:28:00', '08:20:00', 'Outstanding as always', 10),
(26, 15, 26, '2024-03-01', 'present', '08:43:00', '09:35:00', 'Mastery of concepts', 11),
(27, 15, 25, '2024-03-04', 'present', '07:30:00', '08:20:00', NULL, 10),
(28, 15, 25, '2024-03-05', 'present', '07:30:00', '08:20:00', NULL, 10),

-- Edge case: Student with poor attendance (Mia White - student_id = 13)
(29, 13, 21, '2024-03-01', 'absent', NULL, NULL, 'Unexcused absence', 10),
(30, 13, 22, '2024-03-01', 'absent', NULL, NULL, 'Unexcused absence', 11),
(31, 13, 21, '2024-03-04', 'tardy', '07:45:00', '08:20:00', '15 minutes late', 10),
(32, 13, 27, '2024-03-04', 'absent', NULL, NULL, 'Skipped Spanish class', 13),
(33, 13, 21, '2024-03-05', 'present', '07:30:00', '08:20:00', 'Improvement noted', 10);

-- ==========================================
-- DISCIPLINARY INCIDENTS
-- ==========================================

INSERT INTO disciplinary_incidents (incident_id, student_id, reported_by_teacher_id, incident_date, location, incident_type, severity, description, action_taken, parent_contacted, parent_contact_date, follow_up_required, resolved) VALUES

(1, 2, 1, '2024-02-15 10:45:00', 'Classroom 101', 'disruption', 'minor', 'Student had difficulty sitting still during story time and was distracting other students', 'Reminder of classroom rules, moved to quiet corner', TRUE, '2024-02-15', FALSE, TRUE),

(2, 11, 6, '2024-02-20 08:15:00', 'Classroom 203', 'disruption', 'major', 'Student argued with teacher about assignment and used inappropriate language', 'Conference with counselor, parent meeting scheduled', TRUE, '2024-02-20', TRUE, FALSE),

(3, 11, 7, '2024-02-22 09:30:00', 'Classroom 303', 'disruption', 'major', 'Student threw pencil when frustrated with math problem', 'Behavioral intervention plan reviewed, removed from class for 10 minutes', TRUE, '2024-02-22', TRUE, FALSE),

(4, 10, 8, '2024-03-01 11:00:00', 'Science Lab 101', 'other', 'minor', 'Student forgot safety goggles and attempted to start experiment anyway', 'Reviewed lab safety rules, required to recite them before next lab', FALSE, NULL, FALSE, TRUE),

(5, 13, 10, '2024-03-05 07:30:00', 'Parking Lot', 'tardiness', 'minor', 'Student arrived 15 minutes late to first period for the third time this week', 'Detention assigned, transportation issues discussed', TRUE, '2024-03-05', TRUE, FALSE),

-- Edge case: Serious incident requiring administration involvement
(6, 11, 9, '2024-03-10 13:45:00', 'Cafeteria', 'fighting', 'severe', 'Physical altercation with another student over seating dispute', 'Suspension pending investigation, police report filed', TRUE, '2024-03-10', TRUE, FALSE),

-- Edge case: False alarm incident
(7, 8, 6, '2024-02-28 14:30:00', 'Hallway', 'other', 'minor', 'Reported for running in hallways, but was responding to emergency drill', 'No action taken after investigation', FALSE, NULL, FALSE, TRUE);

-- ==========================================
-- LIBRARY BOOKS
-- ==========================================

INSERT INTO library_books (book_id, isbn, title, author, publisher, publication_year, genre, reading_level, total_copies, available_copies, location, condition_status, purchase_date, purchase_price, is_digital) VALUES

(1, '9780064400557', 'Charlotte\'s Web', 'E.B. White', 'Harper Collins', 1952, 'Fiction', 'Grade 3-5', 15, 12, 'Section A, Shelf 3', 'good', '2020-08-15', 8.99, FALSE),
(2, '9780590353427', 'Harry Potter and the Sorcerer\'s Stone', 'J.K. Rowling', 'Scholastic', 1997, 'Fantasy', 'Grade 5-8', 20, 18, 'Section B, Shelf 1', 'excellent', '2021-01-10', 12.99, FALSE),
(3, '9780062673350', 'Wonder', 'R.J. Palacio', 'Knopf Books', 2012, 'Realistic Fiction', 'Grade 5-8', 12, 10, 'Section B, Shelf 2', 'good', '2021-03-22', 14.99, FALSE),
(4, '9780739360385', 'The Outsiders', 'S.E. Hinton', 'Viking Press', 1967, 'Young Adult', 'Grade 7-10', 18, 15, 'Section C, Shelf 1', 'fair', '2019-09-01', 11.50, FALSE),
(5, '9780142424179', 'The Fault in Our Stars', 'John Green', 'Dutton Books', 2012, 'Young Adult', 'Grade 9-12', 10, 8, 'Section C, Shelf 3', 'excellent', '2022-05-15', 16.99, FALSE),
(6, '9780486280615', 'Romeo and Juliet', 'William Shakespeare', 'Dover Publications', 1597, 'Drama', 'Grade 9-12', 25, 20, 'Section D, Shelf 1', 'good', '2020-01-15', 4.50, FALSE),
(7, '9780142437179', 'To Kill a Mockingbird', 'Harper Lee', 'Harper Perennial', 1960, 'Classic Literature', 'Grade 9-12', 22, 18, 'Section D, Shelf 2', 'good', '2020-01-15', 13.99, FALSE),
(8, '9780553212419', '1984', 'George Orwell', 'Bantam Books', 1949, 'Dystopian Fiction', 'Grade 11-12', 15, 12, 'Section D, Shelf 3', 'fair', '2019-08-20', 9.99, FALSE),
-- Elementary picture books
(9, '9780545010221', 'Where the Wild Things Are', 'Maurice Sendak', 'Harper & Row', 1963, 'Picture Book', 'Kindergarten-2', 8, 6, 'Section A, Shelf 1', 'good', '2021-08-01', 9.99, FALSE),
(10, '9780064433624', 'If You Give a Mouse a Cookie', 'Laura Numeroff', 'Harper Collins', 1985, 'Picture Book', 'Kindergarten-2', 10, 8, 'Section A, Shelf 1', 'good', '2021-08-01', 7.99, FALSE),
-- Reference books
(11, '9780877797091', 'Merriam-Webster Elementary Dictionary', 'Merriam-Webster', 'Merriam-Webster', 2019, 'Reference', 'Grade 3-6', 5, 5, 'Reference Section', 'excellent', '2022-01-10', 19.99, FALSE),
(12, '9780201000009', 'World Atlas for Students', 'National Geographic', 'National Geographic', 2020, 'Reference', 'Grade 6-12', 8, 7, 'Reference Section', 'excellent', '2022-01-10', 29.99, FALSE),
-- Edge case: Digital book
(13, '9781234567890', 'Interactive Science Experiments', 'Dr. Science Teacher', 'Digital Learning Press', 2023, 'Science', 'Grade 6-12', 1, 1, 'Digital Collection', 'excellent', '2023-09-01', 25.00, TRUE),
-- Edge case: Damaged book
(14, '9780545482158', 'The Hunger Games', 'Suzanne Collins', 'Scholastic', 2008, 'Young Adult', 'Grade 8-12', 8, 3, 'Section C, Shelf 2', 'damaged', '2020-03-15', 12.99, FALSE);

-- ==========================================
-- LIBRARY BOOK CHECKOUTS
-- ==========================================

INSERT INTO book_checkouts (checkout_id, book_id, student_id, checkout_date, due_date, return_date, status, notes, checked_out_by_teacher_id, returned_to_teacher_id) VALUES

(1, 1, 4, '2024-02-15', '2024-03-01', '2024-02-28', 'returned', 'Student loved the book!', 3, 3),
(2, 2, 8, '2024-02-20', '2024-03-06', NULL, 'checked_out', 'First time reading Harry Potter', 6, NULL),
(3, 3, 9, '2024-02-25', '2024-03-11', NULL, 'checked_out', 'For book report assignment', 6, NULL),
(4, 4, 10, '2024-03-01', '2024-03-15', NULL, 'checked_out', 'Counselor recommended this book', 9, NULL),
(5, 5, 13, '2024-02-10', '2024-02-24', NULL, 'overdue', 'Multiple reminder notices sent', 10, NULL),
(6, 6, 14, '2024-03-05', '2024-03-19', NULL, 'checked_out', 'For English class assignment', 10, NULL),
(7, 7, 15, '2024-02-28', '2024-03-14', '2024-03-10', 'returned', 'Excellent condition', 10, 10),
(8, 9, 1, '2024-03-08', '2024-03-22', NULL, 'checked_out', 'Parent requested this title', 1, NULL),
(9, 10, 2, '2024-03-10', '2024-03-24', NULL, 'checked_out', 'Loves the series', 1, NULL),
-- Edge case: Lost book
(10, 14, 11, '2024-01-15', '2024-01-29', NULL, 'lost', 'Student claims book was stolen from backpack', 9, NULL),
-- Edge case: Returned late with fine
(11, 8, 12, '2024-02-01', '2024-02-15', '2024-02-20', 'returned', 'Returned 5 days late', 10, 10);

UPDATE book_checkouts SET fine_amount = 2.50 WHERE checkout_id = 11; -- Late return fine

-- ==========================================
-- SCHOOL EVENTS
-- ==========================================

INSERT INTO school_events (event_id, campus_id, event_name, description, event_type, start_datetime, end_datetime, location, organizer_teacher_id, max_participants, current_participants, cost, is_mandatory, grade_restrictions, requires_permission, status) VALUES

(1, 1, 'Kindergarten Spring Concert', 'Musical performance by kindergarten students', 'arts', '2024-04-15 18:00:00', '2024-04-15 19:30:00', 'Sunrise Elementary Auditorium', 1, 100, 85, 0.00, FALSE, '[1]', TRUE, 'planned'),
(2, 2, 'Science Fair', 'Student science project presentations and judging', 'academic', '2024-03-20 17:00:00', '2024-03-20 20:00:00', 'Valley Middle School Gymnasium', 8, 200, 156, 0.00, FALSE, '[7, 8, 9]', FALSE, 'planned'),
(3, 3, 'Senior Prom', 'Formal dance for senior students', 'social', '2024-05-18 19:00:00', '2024-05-18 23:00:00', 'Grand Hotel Ballroom', 15, 150, 78, 75.00, FALSE, '[13]', TRUE, 'planned'),
(4, 3, 'College Fair', 'Representatives from various colleges and universities', 'academic', '2024-04-10 09:00:00', '2024-04-10 15:00:00', 'Mountain View High School Cafeteria', 10, 300, 245, 0.00, TRUE, '[11, 12, 13]', FALSE, 'planned'),
(5, 2, 'Basketball Championship Game', 'Valley Middle vs. Riverside Middle', 'sports', '2024-03-25 16:00:00', '2024-03-25 18:00:00', 'Valley Middle School Gymnasium', 7, 200, 180, 5.00, FALSE, '[6, 7, 8, 9, 10, 11, 12, 13]', FALSE, 'active'),
(6, 1, 'Parent-Teacher Conferences', 'Individual meetings with parents', 'meeting', '2024-03-28 16:00:00', '2024-03-28 20:00:00', 'All Classrooms', 18, 150, 120, 0.00, FALSE, '[1, 2, 3, 4, 5, 6]', FALSE, 'planned'),
-- Edge case: Cancelled event
(7, 3, 'Outdoor Field Day', 'Athletic competitions and games', 'sports', '2024-03-15 10:00:00', '2024-03-15 15:00:00', 'Football Field', 15, 400, 0, 0.00, FALSE, '[10, 11, 12, 13]', FALSE, 'cancelled'),
-- Edge case: Completed event
(8, 2, 'Valentine\'s Day Dance', 'Middle school social dance', 'social', '2024-02-14 18:30:00', '2024-02-14 21:00:00', 'Valley Middle School Cafeteria', 6, 150, 98, 10.00, FALSE, '[7, 8, 9]', TRUE, 'completed');

-- ==========================================
-- EVENT PARTICIPANTS
-- ==========================================

INSERT INTO event_participants (participation_id, event_id, student_id, registration_date, attendance_status, permission_form_received, payment_status) VALUES

-- Kindergarten Concert participants
(1, 1, 1, '2024-03-15 09:00:00', 'registered', TRUE, 'not_required'),
(2, 1, 2, '2024-03-15 09:15:00', 'registered', TRUE, 'not_required'),

-- Science Fair participants
(3, 2, 8, '2024-02-28 14:30:00', 'registered', FALSE, 'not_required'),
(4, 2, 9, '2024-03-01 10:15:00', 'registered', FALSE, 'not_required'),
(5, 2, 10, '2024-03-02 16:45:00', 'registered', FALSE, 'not_required'),

-- Senior Prom participants
(6, 3, 15, '2024-03-10 20:30:00', 'registered', TRUE, 'paid'),
(7, 3, 14, '2024-03-12 18:15:00', 'registered', TRUE, 'paid'),

-- College Fair (mandatory for juniors and seniors)
(8, 4, 13, '2024-03-01 08:00:00', 'registered', FALSE, 'not_required'),
(9, 4, 14, '2024-03-01 08:00:00', 'registered', FALSE, 'not_required'),
(10, 4, 15, '2024-03-01 08:00:00', 'registered', FALSE, 'not_required'),

-- Basketball Game
(11, 5, 8, '2024-03-20 12:00:00', 'registered', FALSE, 'paid'),
(12, 5, 12, '2024-03-21 15:30:00', 'registered', FALSE, 'paid'),

-- Parent-Teacher Conferences
(13, 6, 1, '2024-03-25 17:30:00', 'registered', FALSE, 'not_required'),
(14, 6, 3, '2024-03-25 17:45:00', 'registered', FALSE, 'not_required'),
(15, 6, 4, '2024-03-25 18:00:00', 'registered', FALSE, 'not_required'),

-- Valentine's Dance (completed event)
(16, 8, 8, '2024-01-30 10:00:00', 'attended', TRUE, 'paid'),
(17, 8, 9, '2024-02-01 14:20:00', 'attended', TRUE, 'paid'),
(18, 8, 10, '2024-02-05 16:30:00', 'no_show', TRUE, 'paid');

-- ==========================================
-- TRANSPORTATION (BUSES)
-- ==========================================

INSERT INTO buses (bus_id, bus_number, license_plate, driver_name, driver_phone, capacity, current_riders, route_description, morning_route_start_time, afternoon_route_start_time, is_active, maintenance_due_date) VALUES

(1, 'BUS001', 'EDU-1001', 'Robert Johnson', '555-BUS-0001', 48, 42, 'North Learning City - Sunrise Elementary route', '07:15:00', '15:45:00', TRUE, '2024-04-15'),
(2, 'BUS002', 'EDU-1002', 'Maria Rodriguez', '555-BUS-0002', 48, 38, 'South Learning City - Valley Middle School route', '07:00:00', '16:00:00', TRUE, '2024-03-30'),
(3, 'BUS003', 'EDU-1003', 'David Smith', '555-BUS-0003', 56, 51, 'Downtown Learning City - Mountain View High School route', '06:45:00', '16:15:00', TRUE, '2024-05-01'),
(4, 'BUS004', 'EDU-1004', 'Jennifer Wilson', '555-BUS-0004', 36, 28, 'Riverside route - All schools', '07:30:00', '15:30:00', TRUE, '2024-04-10'),
-- Edge case: Bus out of service
(5, 'BUS005', 'EDU-1005', 'Michael Davis', '555-BUS-0005', 48, 0, 'West Learning City route', '07:20:00', '15:50:00', FALSE, '2024-03-15');

-- ==========================================
-- STUDENT TRANSPORTATION ASSIGNMENTS
-- ==========================================

INSERT INTO student_transportation (transport_id, student_id, bus_id, pickup_location, pickup_time, dropoff_location, dropoff_time, effective_date, is_active) VALUES

(1, 1, 1, '123 Sunshine St', '07:45:00', 'Sunrise Elementary Main Entrance', '08:15:00', '2023-08-14', TRUE),
(2, 2, 1, '456 Bright Ave', '07:50:00', 'Sunrise Elementary Main Entrance', '08:15:00', '2023-08-14', TRUE),
(3, 6, 1, '987 Sunbeam Ln', '07:55:00', 'Sunrise Elementary Main Entrance', '08:15:00', '2023-08-14', TRUE),
(4, 8, 2, '222 Valley View', '07:30:00', 'Valley Middle School Front Drop-off', '08:00:00', '2023-08-14', FALSE), -- Student now bikes
(5, 12, 3, '666 Mountain Peak', '07:15:00', 'Mountain View High School Student Parking', '07:45:00', '2023-08-14', FALSE), -- Student now drives
(6, 19, 4, '1313 River Bend', '08:00:00', 'Riverside K-12 Main Entrance', '08:30:00', '2023-08-14', TRUE),
(7, 20, 4, 'Corner of River St and Main', '08:05:00', 'Riverside K-12 Main Entrance', '08:30:00', '2023-08-14', TRUE),
-- Edge case: Mid-year transportation change
(8, 10, 2, '444 Scholar Street', '07:25:00', 'Valley Middle School Front Drop-off', '08:00:00', '2024-01-15', TRUE); -- Student started taking bus in January

-- Update current enrollment counts for classes based on actual enrollments
UPDATE classes SET current_enrollment = (
    SELECT COUNT(*) FROM enrollments 
    WHERE enrollments.class_id = classes.class_id 
    AND enrollments.status = 'enrolled'
) WHERE class_id <= 32;

-- Update bus rider counts based on active transportation assignments
UPDATE buses SET current_riders = (
    SELECT COUNT(*) FROM student_transportation 
    WHERE student_transportation.bus_id = buses.bus_id 
    AND student_transportation.is_active = TRUE
) WHERE bus_id <= 5;

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;