-- College Sample Data Part 2
-- Students, Courses, Sections, Enrollments, and Advanced Features

USE college_db;

SET FOREIGN_KEY_CHECKS = 0;

-- ==========================================
-- COURSES
-- ==========================================

INSERT INTO courses (course_id, course_code, course_title, description, department_id, credit_hours, lecture_hours, lab_hours, prerequisites, corequisites, course_level, difficulty_level, max_enrollment, is_active, learning_outcomes, assessment_methods, required_textbooks) VALUES

-- English Department Courses
(1, 'ENGL1101', 'Composition I', 'Introduction to academic writing and research', 1, 3, 3.0, 0.0, NULL, NULL, 'undergraduate', 2, 25, TRUE, 'Students will develop critical thinking and writing skills', 'Essays, research projects, portfolio', '[{"title": "The Norton Field Guide to Writing", "author": "Bullock", "isbn": "9780393655827"}]'),
(2, 'ENGL1102', 'Composition II', 'Advanced academic writing and argumentation', 1, 3, 3.0, 0.0, '[1]', NULL, 'undergraduate', 3, 25, TRUE, 'Students will master argumentative writing and research', 'Research papers, presentations', '[{"title": "They Say/I Say", "author": "Graff", "isbn": "9780393631678"}]'),
(3, 'ENGL2201', 'Survey of American Literature', 'Overview of American literary traditions', 1, 3, 3.0, 0.0, '[2]', NULL, 'undergraduate', 3, 30, TRUE, 'Understanding of major American literary movements', 'Exams, essays, discussion', '[{"title": "The Norton Anthology of American Literature", "author": "Baym", "isbn": "9780393264548"}]'),
(4, 'ENGL3301', 'Victorian Literature', 'Study of 19th-century British literature', 1, 3, 3.0, 0.0, '[3]', NULL, 'undergraduate', 4, 20, TRUE, 'Analysis of Victorian literary works and contexts', 'Research papers, oral presentations', '[{"title": "Victorian Literature: An Anthology", "author": "Various", "isbn": "9780631198673"}]'),
(5, 'ENGL4401', 'Senior Seminar in Literature', 'Capstone course for English majors', 1, 3, 3.0, 0.0, '[4]', NULL, 'undergraduate', 5, 15, TRUE, 'Independent research and critical analysis', 'Senior thesis, presentation', '[{"title": "Literary Research and MLA Style", "author": "Gibaldi", "isbn": "9780873528184"}]'),
(6, 'ENGL5501', 'Graduate Seminar in Literature', 'Advanced literary theory and criticism', 1, 3, 3.0, 0.0, NULL, NULL, 'graduate', 5, 12, TRUE, 'Mastery of literary theory and research methods', 'Seminar papers, thesis proposal', '[{"title": "Literary Theory: An Introduction", "author": "Eagleton", "isbn": "9780816654475"}]'),

-- Mathematics Department Courses
(7, 'MATH1111', 'College Algebra', 'Algebraic concepts and functions', 2, 3, 3.0, 0.0, NULL, NULL, 'undergraduate', 2, 35, TRUE, 'Mastery of algebraic manipulation and functions', 'Exams, homework, quizzes', '[{"title": "College Algebra", "author": "Sullivan", "isbn": "9780321716835"}]'),
(8, 'MATH1113', 'Precalculus', 'Preparation for calculus', 2, 4, 4.0, 0.0, '[7]', NULL, 'undergraduate', 3, 30, TRUE, 'Trigonometry and advanced algebraic concepts', 'Exams, projects, homework', '[{"title": "Precalculus", "author": "Larson", "isbn": "9781337271073"}]'),
(9, 'MATH2250', 'Calculus I', 'Differential calculus', 2, 4, 4.0, 0.0, '[8]', NULL, 'undergraduate', 4, 28, TRUE, 'Understanding of limits, derivatives, and applications', 'Exams, quizzes, applications', '[{"title": "Calculus: Early Transcendentals", "author": "Stewart", "isbn": "9781285741550"}]'),
(10, 'MATH2260', 'Calculus II', 'Integral calculus and series', 2, 4, 4.0, 0.0, '[9]', NULL, 'undergraduate', 4, 25, TRUE, 'Integration techniques and infinite series', 'Exams, computational projects', '[{"title": "Calculus: Early Transcendentals", "author": "Stewart", "isbn": "9781285741550"}]'),
(11, 'MATH3310', 'Linear Algebra', 'Vector spaces and linear transformations', 2, 3, 3.0, 0.0, '[10]', NULL, 'undergraduate', 4, 20, TRUE, 'Linear algebraic structures and applications', 'Exams, proofs, computer projects', '[{"title": "Linear Algebra Done Right", "author": "Axler", "isbn": "9783319110790"}]'),
(12, 'STAT3000', 'Statistical Methods', 'Introduction to statistical analysis', 2, 3, 2.0, 1.0, '[9]', NULL, 'undergraduate', 3, 25, TRUE, 'Statistical reasoning and data analysis', 'Exams, data analysis projects', '[{"title": "The Practice of Statistics", "author": "Moore", "isbn": "9781464108730"}]'),

-- Biology Department Courses
(13, 'BIOL1107', 'Principles of Biology I', 'Introduction to cellular and molecular biology', 3, 4, 3.0, 1.0, NULL, '[14]', 'undergraduate', 3, 24, TRUE, 'Understanding of basic biological principles', 'Exams, lab reports, practical exams', '[{"title": "Campbell Biology", "author": "Urry", "isbn": "9780134093413"}]'),
(14, 'BIOL1107L', 'Principles of Biology I Lab', 'Laboratory component for Biology I', 3, 1, 0.0, 1.0, NULL, '[13]', 'undergraduate', 2, 24, TRUE, 'Laboratory skills and scientific method', 'Lab reports, practical exams', '[{"title": "Biology Laboratory Manual", "author": "Vodopich", "isbn": "9780078024221"}]'),
(15, 'BIOL1108', 'Principles of Biology II', 'Organismal biology and ecology', 3, 4, 3.0, 1.0, '[13, 14]', '[16]', 'undergraduate', 3, 24, TRUE, 'Understanding of biodiversity and ecosystems', 'Exams, field studies, presentations', '[{"title": "Campbell Biology", "author": "Urry", "isbn": "9780134093413"}]'),
(16, 'BIOL1108L', 'Principles of Biology II Lab', 'Laboratory component for Biology II', 3, 1, 0.0, 1.0, '[14]', '[15]', 'undergraduate', 2, 24, TRUE, 'Field and laboratory techniques', 'Lab reports, field notebooks', '[{"title": "Biology Laboratory Manual", "author": "Vodopich", "isbn": "9780078024221"}]'),
(17, 'BIOL3000', 'Genetics', 'Principles of heredity and gene expression', 3, 3, 3.0, 0.0, '[15, 16]', NULL, 'undergraduate', 4, 20, TRUE, 'Understanding of genetic mechanisms', 'Exams, problem sets, research project', '[{"title": "Genetics: Analysis and Principles", "author": "Brooker", "isbn": "9781259616020"}]'),

-- Computer Science Courses
(18, 'CSCI1301', 'Introduction to Programming', 'Fundamentals of programming using Python', 13, 4, 3.0, 1.0, NULL, '[19]', 'undergraduate', 3, 25, TRUE, 'Basic programming skills and problem solving', 'Programming assignments, exams, projects', '[{"title": "Python Programming", "author": "Zelle", "isbn": "9781590282755"}]'),
(19, 'CSCI1301L', 'Introduction to Programming Lab', 'Laboratory for programming fundamentals', 13, 1, 0.0, 1.0, NULL, '[18]', 'undergraduate', 2, 25, TRUE, 'Hands-on programming experience', 'Lab assignments, practical exams', NULL),
(20, 'CSCI1302', 'Software Development', 'Object-oriented programming and software design', 13, 4, 3.0, 1.0, '[18, 19]', '[21]', 'undergraduate', 4, 24, TRUE, 'Object-oriented design and implementation', 'Projects, code reviews, exams', '[{"title": "Head First Java", "author": "Sierra", "isbn": "9780596009205"}]'),
(21, 'CSCI1302L', 'Software Development Lab', 'Laboratory for software development', 13, 1, 0.0, 1.0, '[19]', '[20]', 'undergraduate', 3, 24, TRUE, 'Advanced programming techniques', 'Software projects, peer reviews', NULL),
(22, 'CSCI3410', 'Data Structures and Algorithms', 'Analysis of algorithms and data structures', 13, 3, 3.0, 0.0, '[20, 21, 11]', NULL, 'undergraduate', 4, 20, TRUE, 'Efficient algorithm design and analysis', 'Programming assignments, algorithm analysis', '[{"title": "Introduction to Algorithms", "author": "Cormen", "isbn": "9780262033848"}]'),
(23, 'CSCI4900', 'Artificial Intelligence', 'Introduction to AI concepts and applications', 13, 3, 3.0, 0.0, '[22]', NULL, 'undergraduate', 5, 18, TRUE, 'Understanding of AI principles and implementation', 'AI projects, research papers', '[{"title": "Artificial Intelligence: A Modern Approach", "author": "Russell", "isbn": "9780134610993"}]'),

-- Business Courses
(24, 'ACCT2101', 'Principles of Accounting I', 'Introduction to financial accounting', 8, 3, 3.0, 0.0, NULL, NULL, 'undergraduate', 3, 30, TRUE, 'Understanding of accounting principles', 'Exams, homework, case studies', '[{"title": "Financial Accounting", "author": "Libby", "isbn": "9781259914898"}]'),
(25, 'ACCT2102', 'Principles of Accounting II', 'Managerial accounting concepts', 8, 3, 3.0, 0.0, '[24]', NULL, 'undergraduate', 3, 30, TRUE, 'Cost accounting and budgeting skills', 'Exams, projects, case analysis', '[{"title": "Managerial Accounting", "author": "Garrison", "isbn": "9781259907692"}]'),
(26, 'MGMT3000', 'Principles of Management', 'Fundamentals of business management', 9, 3, 3.0, 0.0, NULL, NULL, 'undergraduate', 3, 35, TRUE, 'Management theories and applications', 'Exams, case studies, presentations', '[{"title": "Management", "author": "Robbins", "isbn": "9780134527604"}]'),
(27, 'MKTG3000', 'Principles of Marketing', 'Introduction to marketing concepts', 10, 3, 3.0, 0.0, NULL, NULL, 'undergraduate', 3, 35, TRUE, 'Marketing strategy and consumer behavior', 'Exams, marketing plan, campaigns', '[{"title": "Marketing: An Introduction", "author": "Kotler", "isbn": "9780134149530"}]'),
(28, 'FINC3000', 'Corporate Finance', 'Financial management principles', 11, 3, 3.0, 0.0, '[24, 25]', NULL, 'undergraduate', 4, 25, TRUE, 'Financial analysis and decision making', 'Exams, financial analysis projects', '[{"title": "Fundamentals of Corporate Finance", "author": "Ross", "isbn": "9781259918957"}]'),

-- Education Courses
(29, 'ELED3000', 'Elementary Curriculum and Methods', 'Teaching methods for elementary education', 16, 3, 3.0, 0.0, NULL, '[30]', 'undergraduate', 3, 20, TRUE, 'Effective elementary teaching strategies', 'Lesson plans, micro-teaching, portfolio', '[{"title": "Elementary and Middle School Mathematics", "author": "Van de Walle", "isbn": "9780134802084"}]'),
(30, 'ELED3000P', 'Elementary Field Experience', 'Classroom observation and participation', 16, 1, 0.0, 1.0, NULL, '[29]', 'undergraduate', 2, 20, TRUE, 'Real classroom experience', 'Reflection journals, evaluations', NULL),
(31, 'SCED3000', 'Secondary Teaching Methods', 'Methods for teaching secondary subjects', 17, 3, 3.0, 0.0, NULL, '[32]', 'undergraduate', 3, 18, TRUE, 'Subject-specific teaching strategies', 'Unit plans, demonstrations, portfolios', '[{"title": "Learning to Teach", "author": "Arends", "isbn": "9780078024405"}]'),
(32, 'SCED3000P', 'Secondary Field Experience', 'High school classroom experience', 17, 2, 0.0, 2.0, NULL, '[31]', 'undergraduate', 2, 18, TRUE, 'Advanced classroom practice', 'Teaching episodes, reflections', NULL),

-- Nursing Courses
(33, 'NURS2000', 'Fundamentals of Nursing', 'Basic nursing principles and skills', 19, 4, 3.0, 1.0, NULL, '[34]', 'undergraduate', 4, 16, TRUE, 'Foundation nursing competencies', 'Exams, skills demonstrations, care plans', '[{"title": "Fundamentals of Nursing", "author": "Potter", "isbn": "9780323327404"}]'),
(34, 'NURS2000L', 'Nursing Skills Laboratory', 'Laboratory practice of nursing skills', 19, 1, 0.0, 1.0, NULL, '[33]', 'undergraduate', 3, 16, TRUE, 'Clinical skill proficiency', 'Skills checkoffs, competency exams', NULL),
(35, 'NURS3000', 'Medical-Surgical Nursing', 'Care of adult patients with medical conditions', 19, 5, 3.0, 2.0, '[33, 34]', '[36]', 'undergraduate', 4, 14, TRUE, 'Adult nursing care competencies', 'Exams, clinical evaluations, care studies', '[{"title": "Medical-Surgical Nursing", "author": "Lewis", "isbn": "9780323328524"}]'),
(36, 'NURS3000C', 'Medical-Surgical Clinical', 'Hospital clinical experience', 19, 2, 0.0, 2.0, '[34]', '[35]', 'undergraduate', 4, 14, TRUE, 'Real patient care experience', 'Clinical evaluations, reflections', NULL),

-- Graduate Courses
(37, 'ENGL6000', 'Literary Theory Seminar', 'Advanced study of literary criticism', 1, 3, 3.0, 0.0, NULL, NULL, 'graduate', 5, 10, TRUE, 'Mastery of contemporary literary theory', 'Seminar papers, thesis proposal', '[{"title": "Literary Theory: An Anthology", "author": "Rivkin", "isbn": "9781405106962"}]'),
(38, 'MATH6000', 'Advanced Mathematical Analysis', 'Real analysis and measure theory', 2, 3, 3.0, 0.0, '[11]', NULL, 'graduate', 5, 8, TRUE, 'Advanced mathematical reasoning', 'Proofs, problem sets, oral exam', '[{"title": "Real Analysis", "author": "Royden", "isbn": "9780132418904"}]'),
(39, 'CSCI6000', 'Advanced Algorithms', 'Design and analysis of advanced algorithms', 13, 3, 3.0, 0.0, '[22]', NULL, 'graduate', 5, 12, TRUE, 'Advanced algorithmic techniques', 'Research project, algorithm implementation', '[{"title": "Advanced Algorithms", "author": "Leiserson", "isbn": "9780262033848"}]'),
(40, 'MBA6000', 'Strategic Management', 'Advanced business strategy', 9, 3, 3.0, 0.0, NULL, NULL, 'graduate', 5, 15, TRUE, 'Strategic thinking and decision making', 'Case studies, strategy project', '[{"title": "Strategic Management", "author": "Hitt", "isbn": "9781305502147"}]'),

-- Edge case: Course with complex prerequisites
(41, 'CSCI4950', 'Senior Capstone Project', 'Independent software development project', 13, 3, 1.0, 2.0, '[20, 21, 22, 23]', NULL, 'undergraduate', 5, 15, TRUE, 'Integration of computer science knowledge', 'Major software project, presentation', NULL),

-- Edge case: Inactive course
(42, 'HIST2999', 'Discontinued History Course', 'This course is no longer offered', 6, 3, 3.0, 0.0, NULL, NULL, 'undergraduate', 3, 25, FALSE, 'Historical analysis', 'Exams, papers', NULL);

-- ==========================================
-- STUDENTS
-- ==========================================

INSERT INTO students (student_id, student_number, first_name, last_name, middle_name, preferred_name, email, date_of_birth, gender, address, city, state, zip_code, country, phone, emergency_contact_name, emergency_contact_phone, emergency_contact_relationship, program_id, campus_id, admission_date, expected_graduation_date, graduation_status, student_type, enrollment_status, residency_status, gpa, total_credit_hours, completed_credit_hours, academic_standing, advisor_faculty_id, financial_aid_eligible, work_study_eligible, housing_status, dietary_restrictions, medical_conditions, disabilities, veteran_status, first_generation_college, ethnicity, religion, marital_status, previous_school_name, previous_school_id) VALUES

-- Traditional undergraduate students
(1, 'EU2021001', 'Emma', 'Johnson', 'Grace', 'Emma', 'emma.johnson@student.excellenceuniv.edu', '2003-09-15', 'female', '123 Dorm Way Room 205', 'Learning City', 'EDU', '12400', 'USA', '555-555-0001', 'Mary Johnson', '555-555-0002', 'mother', 1, 1, '2021-08-23', '2025-05-15', 'enrolled', 'junior', 'full_time', 'in_state', 3.75, 88, 82, 'good', 1, TRUE, FALSE, 'on_campus', 'Vegetarian', NULL, NULL, FALSE, FALSE, 'Caucasian', 'Christian', 'single', 'Mountain View High School', 16),

(2, 'EU2021002', 'Liam', 'Smith', 'Alexander', 'Liam', 'liam.smith@student.excellenceuniv.edu', '2003-03-22', 'male', '456 University Heights Apt 3B', 'Learning City', 'EDU', '12400', 'USA', '555-555-0003', 'Robert Smith', '555-555-0004', 'father', 16, 1, '2021-08-23', '2025-05-15', 'enrolled', 'junior', 'full_time', 'in_state', 3.42, 90, 85, 'good', 6, TRUE, TRUE, 'off_campus', NULL, 'ADHD', 'Learning disability accommodations', FALSE, TRUE, 'Caucasian', 'Protestant', 'single', 'Mountain View High School', 2),

(3, 'EU2022001', 'Olivia', 'Brown', 'Rose', 'Liv', 'olivia.brown@student.excellenceuniv.edu', '2004-12-10', 'female', '789 Scholar Street', 'Learning City', 'EDU', '12400', 'USA', '555-555-0005', 'Sarah Brown', '555-555-0006', 'mother', 5, 1, '2022-08-22', '2026-05-14', 'enrolled', 'sophomore', 'full_time', 'in_state', 3.89, 62, 58, 'good', 5, FALSE, FALSE, 'commuter', 'Lactose intolerant', NULL, NULL, FALSE, FALSE, 'Hispanic', 'Catholic', 'single', 'Valley Middle School', 3),

(4, 'EU2023001', 'Noah', 'Davis', 'James', 'Noah', 'noah.davis@student.excellenceuniv.edu', '2005-11-05', 'male', '321 Freshman Hall Room 112', 'Learning City', 'EDU', '12400', 'USA', '555-555-0007', 'Jennifer Davis', '555-555-0008', 'mother', 11, 1, '2023-08-21', '2027-05-13', 'enrolled', 'freshman', 'full_time', 'in_state', 3.25, 32, 30, 'good', 7, TRUE, FALSE, 'on_campus', NULL, NULL, NULL, FALSE, FALSE, 'African American', 'Baptist', 'single', 'Mountain View High School', 4),

(5, 'EU2022002', 'Ava', 'Wilson', 'Marie', 'Ava', 'ava.wilson@student.excellenceuniv.edu', '2004-08-18', 'female', '654 Nursing Residence', 'Learning City', 'EDU', '12400', 'USA', '555-555-0009', 'James Wilson', '555-555-0010', 'father', 23, 1, '2022-08-22', '2026-05-14', 'enrolled', 'sophomore', 'full_time', 'in_state', 3.95, 65, 62, 'dean_list', 9, FALSE, FALSE, 'on_campus', 'Gluten-free', 'Type 1 Diabetes', 'Medical management needed', FALSE, FALSE, 'Asian American', 'Buddhist', 'single', 'Private Academy', NULL),

-- Transfer students
(6, 'EU2023002', 'William', 'Martinez', 'Carlos', 'Will', 'william.martinez@student.excellenceuniv.edu', '2002-07-30', 'male', '987 Transfer Towers Room 305', 'Learning City', 'EDU', '12400', 'USA', '555-555-0011', 'Maria Martinez', '555-555-0012', 'mother', 13, 1, '2023-01-17', '2025-05-10', 'enrolled', 'junior', 'full_time', 'in_state', 3.28, 78, 72, 'good', 6, TRUE, TRUE, 'on_campus', NULL, NULL, NULL, FALSE, TRUE, 'Hispanic', 'Catholic', 'single', 'Community College of Excellence', NULL),

(7, 'EU2022003', 'Sofia', 'Anderson', 'Elena', 'Sofia', 'sofia.anderson@student.excellenceuniv.edu', '2004-04-12', 'female', '111 International House', 'Learning City', 'EDU', '12400', 'Spain', '555-555-0013', 'Carmen Anderson', '+34-555-123456', 'mother', 1, 1, '2022-08-22', '2026-05-14', 'enrolled', 'sophomore', 'full_time', 'international', 3.67, 60, 55, 'good', 1, FALSE, FALSE, 'on_campus', 'Vegan', NULL, NULL, FALSE, FALSE, 'Hispanic', 'Catholic', 'single', 'International School Madrid', NULL),

-- Graduate students
(8, 'EU2023G001', 'Mason', 'Taylor', 'Joseph', 'Mason', 'mason.taylor@student.excellenceuniv.edu', '2001-05-20', 'male', '222 Graduate Village Apt 12', 'Learning City', 'EDU', '12400', 'USA', '555-555-0014', 'Rebecca Taylor', '555-555-0015', 'mother', 25, 1, '2023-08-21', '2025-05-10', 'enrolled', 'graduate', 'full_time', 'out_of_state', 3.83, 18, 15, 'good', 1, TRUE, TRUE, 'off_campus', NULL, NULL, NULL, FALSE, FALSE, 'Caucasian', 'Non-religious', 'single', 'State University', NULL),

(9, 'EU2022G001', 'Isabella', 'Garcia', 'Lucia', 'Izzy', 'isabella.garcia@student.excellenceuniv.edu', '2000-09-08', 'female', '333 Off-Campus Housing', 'Learning City', 'EDU', '12400', 'USA', '555-555-0016', 'Rosa Garcia', '555-555-0017', 'mother', 27, 1, '2022-08-22', '2024-05-10', 'enrolled', 'graduate', 'full_time', 'in_state', 3.91, 27, 24, 'good', 6, FALSE, FALSE, 'off_campus', NULL, NULL, NULL, FALSE, FALSE, 'Hispanic', 'Catholic', 'married', 'Excellence University', 8),

-- Non-traditional students
(10, 'EU2023003', 'Ethan', 'Rodriguez', 'Miguel', 'Ethan', 'ethan.rodriguez@student.excellenceuniv.edu', '1995-12-25', 'male', '444 Family Housing Unit 5', 'Learning City', 'EDU', '12400', 'USA', '555-555-0018', 'Ana Rodriguez', '555-555-0019', 'spouse', 12, 1, '2023-08-21', '2027-05-13', 'enrolled', 'sophomore', 'part_time', 'in_state', 3.45, 45, 40, 'good', 7, TRUE, FALSE, 'off_campus', NULL, NULL, NULL, TRUE, TRUE, 'Hispanic', 'Catholic', 'married', 'Work experience', NULL),

-- North Campus students
(11, 'EU2023N001', 'Charlotte', 'Lewis', 'Ann', 'Charlie', 'charlotte.lewis@student.excellenceuniv.edu', '2004-06-14', 'female', '555 North Campus Dorms', 'North Learning', 'EDU', '12401', 'USA', '555-555-0020', 'Susan Lewis', '555-555-0021', 'mother', 29, 2, '2023-08-21', '2027-05-13', 'enrolled', 'freshman', 'full_time', 'in_state', 3.12, 30, 28, 'good', 10, TRUE, FALSE, 'on_campus', NULL, NULL, NULL, FALSE, FALSE, 'Caucasian', 'Presbyterian', 'single', 'North Regional High School', NULL),

(12, 'EU2022N001', 'Alexander', 'Thompson', 'David', 'Alex', 'alexander.thompson@student.excellenceuniv.edu', '2003-03-10', 'male', '666 North Student Housing', 'North Learning', 'EDU', '12401', 'USA', '555-555-0022', 'Michelle Thompson', '555-555-0023', 'mother', 31, 2, '2022-08-22', '2026-05-14', 'enrolled', 'sophomore', 'full_time', 'in_state', 2.95, 55, 52, 'good', 10, TRUE, TRUE, 'on_campus', NULL, 'Anxiety disorder', 'Counseling services', FALSE, FALSE, 'Caucasian', 'Christian', 'single', 'North Regional High School', NULL),

-- Online students
(13, 'EU2023O001', 'Mia', 'White', 'Grace', 'Mia', 'mia.white@student.excellenceuniv.edu', '2001-08-15', 'female', '777 Remote Learning Ave', 'Distant City', 'STU', '54321', 'USA', '555-555-0024', 'Karen White', '555-555-0025', 'mother', 33, 3, '2023-08-21', '2027-05-13', 'enrolled', 'sophomore', 'full_time', 'out_of_state', 3.56, 48, 45, 'good', NULL, TRUE, FALSE, 'off_campus', NULL, NULL, NULL, FALSE, FALSE, 'Caucasian', 'Methodist', 'single', 'Online High School', NULL),

(14, 'EU2022O001', 'Benjamin', 'Harris', 'Lee', 'Ben', 'benjamin.harris@student.excellenceuniv.edu', '1988-11-22', 'male', '888 Working Professional Dr', 'Career City', 'PRO', '98765', 'USA', '555-555-0026', 'Nancy Harris', '555-555-0027', 'spouse', 34, 3, '2022-08-22', '2026-05-14', 'enrolled', 'senior', 'part_time', 'out_of_state', 3.33, 95, 90, 'good', NULL, FALSE, FALSE, 'off_campus', NULL, NULL, NULL, TRUE, TRUE, 'Caucasian', 'Non-religious', 'married', 'Military Service', NULL),

-- Students with special circumstances
(15, 'EU2021003', 'Harper', 'Martin', 'Joy', 'Harper', 'harper.martin@student.excellenceuniv.edu', '2003-12-03', 'female', '999 Honor Student Lane', 'Learning City', 'EDU', '12400', 'USA', '555-555-0028', 'Linda Martin', '555-555-0029', 'mother', 1, 1, '2021-08-23', '2025-05-15', 'enrolled', 'junior', 'full_time', 'in_state', 3.98, 92, 88, 'dean_list', 1, FALSE, FALSE, 'on_campus', NULL, NULL, NULL, FALSE, FALSE, 'Caucasian', 'Jewish', 'single', 'Mountain View High School', 15),

-- Edge case: Graduated student
(16, 'EU2019001', 'Jacob', 'Young', 'William', 'Jake', 'jacob.young@alumni.excellenceuniv.edu', '2001-04-18', 'male', '1010 Alumni Circle', 'Learning City', 'EDU', '12400', 'USA', '555-555-0030', 'Sandra Young', '555-555-0031', 'mother', 16, 1, '2019-08-26', '2023-05-12', 'graduated', 'senior', 'full_time', 'in_state', 3.67, 132, 132, 'good', 6, FALSE, FALSE, 'off_campus', NULL, NULL, NULL, FALSE, FALSE, 'Caucasian', 'Christian', 'single', 'Mountain View High School', 16),

-- Edge case: Withdrawn student
(17, 'EU2023004', 'Emily', 'Allen', 'Claire', 'Emily', 'emily.allen@former.excellenceuniv.edu', '2005-01-28', 'female', '1111 Former Student Rd', 'New City', 'EDU', '54321', 'USA', '555-555-0032', 'Jessica Allen', '555-555-0033', 'mother', 10, 1, '2023-08-21', NULL, 'withdrawn', 'freshman', 'full_time', 'in_state', 2.45, 28, 24, 'probation', 7, TRUE, FALSE, 'off_campus', NULL, NULL, NULL, FALSE, FALSE, 'Caucasian', 'Christian', 'single', 'Regional High School', NULL),

-- Edge case: Student with NULL optional fields
(18, 'EU2024001', 'Lucas', 'King', 'Matthew', 'Luke', 'lucas.king@student.excellenceuniv.edu', '2006-10-11', 'prefer_not_to_say', '1212 Minimal Info Dr', 'Learning City', 'EDU', '12400', 'USA', NULL, 'Emergency Contact', '555-555-0034', 'guardian', 4, 1, '2024-01-16', '2028-05-11', 'enrolled', 'freshman', 'full_time', 'in_state', 0.00, 15, 0, 'good', 3, TRUE, FALSE, 'on_campus', NULL, NULL, NULL, FALSE, FALSE, NULL, NULL, 'single', 'Riverside K-12 School', 18),

-- Dual enrollment student (high school student taking college courses)
(19, 'EU2024D001', 'Grace', 'Scott', 'Rose', 'Grace', 'grace.scott@dualenroll.excellenceuniv.edu', '2009-07-26', 'female', '1313 High School Student Ave', 'Learning City', 'EDU', '12400', 'USA', '555-555-0035', 'Rachel Scott', '555-555-0036', 'mother', NULL, 1, '2024-01-16', NULL, 'enrolled', 'freshman', 'part_time', 'in_state', 4.00, 6, 3, 'good', 3, FALSE, FALSE, 'commuter', NULL, NULL, NULL, FALSE, FALSE, 'Caucasian', 'Methodist', 'single', 'Riverside K-12 School', 19),

-- Student with complex academic history
(20, 'EU2023005', 'Aiden', 'Green', NULL, 'Aiden', 'aiden.green@student.excellenceuniv.edu', '2005-02-14', 'male', '1414 Complex History Blvd', 'Learning City', 'EDU', '12400', 'USA', '555-555-0037', 'Guardian Green', '555-555-0038', 'guardian', 32, 1, '2023-08-21', '2027-05-13', 'enrolled', 'freshman', 'full_time', 'in_state', 2.75, 35, 32, 'probation', 6, TRUE, TRUE, 'on_campus', NULL, 'Learning disabilities', 'Academic support services', FALSE, TRUE, 'Mixed race', 'Non-religious', 'single', 'Riverside K-12 School', 20);

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;