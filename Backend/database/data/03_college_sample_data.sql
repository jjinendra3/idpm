-- Sample Data for College Database
-- This includes comprehensive test data with SQL edge cases

USE college_db;

-- Disable foreign key checks temporarily for easier data insertion
SET FOREIGN_KEY_CHECKS = 0;

-- ==========================================
-- COMPANY DATA (Shared with school database)
-- ==========================================

INSERT INTO company (company_id, company_name, founded_year, headquarters_address, phone, email, website, tax_id) VALUES
(1, 'EduCorp Excellence Group', 1985, '123 Education Blvd, Learning City, EDU 12345', '555-123-4567', 'info@educorp.edu', 'https://www.educorp.edu', '12-3456789');

-- ==========================================
-- CAMPUS DATA
-- ==========================================

INSERT INTO campuses (campus_id, company_id, campus_name, address, city, state, zip_code, phone, president_name, dean_name, total_capacity, current_enrollment, established_year, campus_type, accreditation, ranking, is_active) VALUES
(1, 1, 'Excellence University Main Campus', '1000 University Boulevard', 'Learning City', 'EDU', '12400', '555-800-1000', 'Dr. Elizabeth Harrison', 'Dr. Robert Chen', 8000, 6485, 1965, 'main', 'SACS SACSCOC', 125, TRUE),
(2, 1, 'Excellence University North Branch', '2500 North Campus Drive', 'North Learning', 'EDU', '12401', '555-800-2000', 'Dr. Michelle Torres', 'Dr. James Liu', 3000, 2340, 1985, 'branch', 'SACS SACSCOC', NULL, TRUE),
(3, 1, 'Excellence University Online Campus', '500 Digital Learning Way', 'Learning City', 'EDU', '12402', '555-800-3000', 'Dr. Sarah Kim', 'Dr. David Martinez', 5000, 3200, 2010, 'online', 'SACS SACSCOC', NULL, TRUE),
-- Edge case: Satellite campus with limited capacity
(4, 1, 'Excellence University Research Satellite', '100 Research Park Dr', 'Innovation City', 'EDU', '12403', '555-800-4000', 'Dr. Michael Brown', 'Dr. Lisa Garcia', 500, 125, 2015, 'satellite', 'SACS SACSCOC', NULL, TRUE);

-- ==========================================
-- COLLEGES WITHIN UNIVERSITY
-- ==========================================

INSERT INTO colleges (college_id, campus_id, college_name, college_code, established_year, description, building_names, total_faculty, total_students, budget, accreditation, website) VALUES
(1, 1, 'College of Liberal Arts and Sciences', 'CLAS', 1965, 'Comprehensive liberal arts education with strong research focus', '["Liberal Arts Building", "Science Complex", "Humanities Hall"]', 85, 2100, 12000000.00, 'SACS SACSCOC', 'https://clas.excellenceuniv.edu'),
(2, 1, 'School of Business', 'BUS', 1972, 'Accredited business school offering undergraduate and graduate programs', '["Business Administration Building", "Executive Education Center"]', 42, 1250, 8500000.00, 'AACSB', 'https://business.excellenceuniv.edu'),
(3, 1, 'College of Engineering and Technology', 'ENG', 1975, 'Engineering programs with state-of-the-art laboratories', '["Engineering Building", "Technology Center", "Materials Lab"]', 38, 980, 15000000.00, 'ABET', 'https://engineering.excellenceuniv.edu'),
(4, 1, 'College of Education', 'EDU', 1968, 'Teacher preparation and educational leadership programs', '["Education Building", "Child Development Center"]', 28, 650, 5500000.00, 'CAEP', 'https://education.excellenceuniv.edu'),
(5, 1, 'School of Nursing and Health Sciences', 'NHS', 1980, 'Healthcare professional preparation programs', '["Health Sciences Building", "Nursing Simulation Lab"]', 25, 485, 7500000.00, 'CCNE', 'https://nursing.excellenceuniv.edu'),
(6, 2, 'North Campus Liberal Studies', 'NCLS', 1985, 'Liberal arts programs for the North Campus branch', '["North Liberal Arts", "Science Annex"]', 32, 1200, 4000000.00, 'SACS SACSCOC', 'https://north.excellenceuniv.edu'),
(7, 2, 'North Campus Business and Technology', 'NCBT', 1988, 'Business and technology programs for working professionals', '["North Business Center", "Technology Hub"]', 28, 1140, 3500000.00, 'AACSB Candidate', 'https://northbiz.excellenceuniv.edu'),
(8, 3, 'Online Learning Division', 'OLD', 2010, 'Fully online degree programs across disciplines', '["Virtual Campus"]', 45, 3200, 6000000.00, 'SACS SACSCOC', 'https://online.excellenceuniv.edu');

-- ==========================================
-- DEPARTMENTS
-- ==========================================

INSERT INTO departments (department_id, college_id, department_name, department_code, description, research_areas, building_name, floor_number, office_numbers, budget, total_faculty, total_students, website) VALUES
-- College of Liberal Arts and Sciences
(1, 1, 'English and Literature', 'ENGL', 'Study of literature, creative writing, and composition', '["American Literature", "Creative Writing", "Rhetoric and Composition"]', 'Humanities Hall', 2, '["201", "202", "203", "204", "205"]', 800000.00, 12, 350, 'https://english.excellenceuniv.edu'),
(2, 1, 'Mathematics', 'MATH', 'Pure and applied mathematics, statistics', '["Applied Mathematics", "Statistics", "Mathematical Modeling"]', 'Science Complex', 3, '["301", "302", "303", "304"]', 950000.00, 15, 420, 'https://math.excellenceuniv.edu'),
(3, 1, 'Biology', 'BIOL', 'Biological sciences and research', '["Molecular Biology", "Ecology", "Biotechnology"]', 'Science Complex', 1, '["101", "102", "103", "104", "105"]', 1200000.00, 18, 380, 'https://biology.excellenceuniv.edu'),
(4, 1, 'Chemistry', 'CHEM', 'Chemical sciences and research', '["Organic Chemistry", "Analytical Chemistry", "Biochemistry"]', 'Science Complex', 2, '["201", "202", "203", "204"]', 1100000.00, 14, 290, 'https://chemistry.excellenceuniv.edu'),
(5, 1, 'Physics', 'PHYS', 'Physical sciences and engineering physics', '["Condensed Matter Physics", "Optics", "Astronomy"]', 'Science Complex', 4, '["401", "402", "403"]', 1050000.00, 10, 180, 'https://physics.excellenceuniv.edu'),
(6, 1, 'History', 'HIST', 'Historical studies and research', '["American History", "World History", "Digital Humanities"]', 'Humanities Hall', 1, '["101", "102", "103", "104"]', 600000.00, 8, 220, 'https://history.excellenceuniv.edu'),
(7, 1, 'Psychology', 'PSYC', 'Psychological science and applied psychology', '["Cognitive Psychology", "Clinical Psychology", "Social Psychology"]', 'Liberal Arts Building', 3, '["301", "302", "303", "304", "305"]', 750000.00, 12, 450, 'https://psychology.excellenceuniv.edu'),

-- School of Business
(8, 2, 'Accounting', 'ACCT', 'Accounting principles and practices', '["Forensic Accounting", "Tax Policy", "Financial Reporting"]', 'Business Administration Building', 2, '["201", "202", "203"]', 650000.00, 8, 280, 'https://accounting.excellenceuniv.edu'),
(9, 2, 'Management', 'MGMT', 'Business management and leadership', '["Organizational Behavior", "Strategic Management", "Leadership"]', 'Business Administration Building', 3, '["301", "302", "303", "304"]', 700000.00, 10, 320, 'https://management.excellenceuniv.edu'),
(10, 2, 'Marketing', 'MKTG', 'Marketing strategy and consumer behavior', '["Digital Marketing", "Consumer Psychology", "Brand Management"]', 'Business Administration Building', 1, '["101", "102", "103"]', 600000.00, 7, 250, 'https://marketing.excellenceuniv.edu'),
(11, 2, 'Finance', 'FINC', 'Financial analysis and investment', '["Corporate Finance", "Investment Analysis", "Risk Management"]', 'Business Administration Building', 4, '["401", "402", "403"]', 750000.00, 9, 220, 'https://finance.excellenceuniv.edu'),
(12, 2, 'Information Systems', 'ISYS', 'Business information systems and technology', '["Database Systems", "Business Analytics", "Cybersecurity"]', 'Business Administration Building', 2, '["204", "205", "206"]', 800000.00, 8, 180, 'https://infosystems.excellenceuniv.edu'),

-- College of Engineering and Technology
(13, 3, 'Computer Science', 'CSCI', 'Computer science and software engineering', '["Artificial Intelligence", "Software Engineering", "Cybersecurity"]', 'Engineering Building', 3, '["301", "302", "303", "304", "305"]', 1200000.00, 15, 420, 'https://cs.excellenceuniv.edu'),
(14, 3, 'Electrical Engineering', 'EENG', 'Electrical and electronic engineering', '["Power Systems", "Electronics", "Signal Processing"]', 'Engineering Building', 2, '["201", "202", "203", "204"]', 1100000.00, 12, 280, 'https://ee.excellenceuniv.edu'),
(15, 3, 'Mechanical Engineering', 'MENG', 'Mechanical engineering and design', '["Thermodynamics", "Materials Science", "Robotics"]', 'Engineering Building', 1, '["101", "102", "103", "104"]', 1150000.00, 11, 280, 'https://me.excellenceuniv.edu'),

-- College of Education
(16, 4, 'Elementary Education', 'ELED', 'Elementary teacher preparation', '["Early Childhood Education", "Reading Instruction", "STEM Education"]', 'Education Building', 1, '["101", "102", "103", "104"]', 550000.00, 12, 280, 'https://elementary.excellenceuniv.edu'),
(17, 4, 'Secondary Education', 'SCED', 'Secondary teacher preparation', '["Subject Matter Teaching", "Classroom Management", "Educational Technology"]', 'Education Building', 2, '["201", "202", "203", "204"]', 600000.00, 10, 220, 'https://secondary.excellenceuniv.edu'),
(18, 4, 'Educational Leadership', 'EDLD', 'Educational administration and leadership', '["School Administration", "Policy Studies", "Organizational Leadership"]', 'Education Building', 3, '["301", "302", "303"]', 450000.00, 6, 150, 'https://leadership.excellenceuniv.edu'),

-- School of Nursing and Health Sciences
(19, 5, 'Nursing', 'NURS', 'Professional nursing education', '["Community Health", "Critical Care", "Nursing Education"]', 'Health Sciences Building', 1, '["101", "102", "103", "104", "105"]', 900000.00, 18, 360, 'https://nursing.excellenceuniv.edu'),
(20, 5, 'Health Administration', 'HADM', 'Healthcare management and administration', '["Healthcare Policy", "Quality Management", "Health Economics"]', 'Health Sciences Building', 2, '["201", "202", "203"]', 400000.00, 7, 125, 'https://healthadmin.excellenceuniv.edu'),

-- North Campus departments
(21, 6, 'Liberal Studies', 'LIBS', 'Interdisciplinary liberal arts program', '["Cultural Studies", "Environmental Studies", "Social Justice"]', 'North Liberal Arts', 1, '["101", "102", "103", "104"]', 450000.00, 16, 600, 'https://libstudies.excellenceuniv.edu'),
(22, 6, 'Natural Sciences', 'NSCI', 'Basic sciences for North Campus', '["Environmental Science", "Biology", "Chemistry"]', 'Science Annex', 1, '["101", "102", "103"]', 500000.00, 16, 600, 'https://northscience.excellenceuniv.edu'),
(23, 7, 'Business Studies', 'BSTD', 'Applied business programs', '["Small Business Management", "Entrepreneurship", "Professional Development"]', 'North Business Center', 1, '["101", "102", "103", "104"]', 400000.00, 14, 600, 'https://northbusiness.excellenceuniv.edu'),
(24, 7, 'Information Technology', 'ITEC', 'Applied technology programs', '["Network Administration", "Web Development", "Database Management"]', 'Technology Hub', 1, '["101", "102", "103"]', 450000.00, 14, 540, 'https://northtech.excellenceuniv.edu'),

-- Online Learning Division
(25, 8, 'Online Programs', 'ONLN', 'Fully online degree delivery', '["Distance Learning", "Educational Technology", "Online Pedagogy"]', 'Virtual Campus', NULL, '["Virtual Office Suite"]', 800000.00, 45, 3200, 'https://online.excellenceuniv.edu');

-- ==========================================
-- ACADEMIC YEARS AND SEMESTERS
-- ==========================================

INSERT INTO academic_years (academic_year_id, year_name, start_date, end_date, is_current, tuition_rate) VALUES
(1, '2022-2023', '2022-08-22', '2023-05-12', FALSE, 425.00),
(2, '2023-2024', '2023-08-21', '2024-05-10', TRUE, 450.00),
(3, '2024-2025', '2024-08-19', '2025-05-09', FALSE, 475.00);

INSERT INTO semesters (semester_id, academic_year_id, semester_name, semester_number, start_date, end_date, registration_start_date, registration_end_date, add_drop_deadline, withdrawal_deadline, final_exams_start_date, final_exams_end_date, is_current, max_credit_hours) VALUES
-- 2022-2023 semesters
(1, 1, 'Fall 2022', 1, '2022-08-22', '2022-12-16', '2022-04-01', '2022-08-19', '2022-08-29', '2022-10-15', '2022-12-12', '2022-12-16', FALSE, 18),
(2, 1, 'Spring 2023', 2, '2023-01-17', '2023-05-12', '2022-11-01', '2023-01-13', '2023-01-24', '2023-03-15', '2023-05-08', '2023-05-12', FALSE, 18),
(3, 1, 'Summer 2023', 3, '2023-05-22', '2023-08-11', '2023-03-01', '2023-05-19', '2023-05-26', '2023-07-01', '2023-08-07', '2023-08-11', FALSE, 12),
-- 2023-2024 semesters (current year)
(4, 2, 'Fall 2023', 1, '2023-08-21', '2023-12-15', '2023-04-01', '2023-08-18', '2023-08-28', '2023-10-16', '2023-12-11', '2023-12-15', FALSE, 18),
(5, 2, 'Spring 2024', 2, '2024-01-16', '2024-05-10', '2023-11-01', '2024-01-12', '2024-01-23', '2024-03-15', '2024-05-06', '2024-05-10', TRUE, 18),
(6, 2, 'Summer 2024', 3, '2024-05-20', '2024-08-09', '2024-03-01', '2024-05-17', '2024-05-24', '2024-06-30', '2024-08-05', '2024-08-09', FALSE, 12),
-- 2024-2025 semesters
(7, 3, 'Fall 2024', 1, '2024-08-19', '2024-12-13', '2024-04-01', '2024-08-16', '2024-08-26', '2024-10-14', '2024-12-09', '2024-12-13', FALSE, 18),
(8, 3, 'Spring 2025', 2, '2025-01-14', '2025-05-09', '2024-11-01', '2025-01-10', '2025-01-21', '2025-03-14', '2025-05-05', '2025-05-09', FALSE, 18);

-- ==========================================
-- DEGREE PROGRAMS
-- ==========================================

INSERT INTO degree_programs (program_id, department_id, program_name, program_code, degree_type, degree_title, total_credit_hours, duration_years, description, admission_requirements, career_outcomes, is_active) VALUES
-- Liberal Arts and Sciences programs
(1, 1, 'English Literature', 'ENGL-BA', 'bachelor', 'Bachelor of Arts in English Literature', 120, 4.0, 'Comprehensive study of literature, writing, and critical analysis', 'High school diploma, 3.0 GPA, SAT/ACT scores', 'Teaching, publishing, journalism, graduate school', TRUE),
(2, 1, 'Creative Writing', 'ENGL-CW', 'bachelor', 'Bachelor of Arts in Creative Writing', 120, 4.0, 'Focus on fiction, poetry, and creative nonfiction writing', 'Portfolio submission, 3.2 GPA, writing samples', 'Author, editor, journalist, teacher', TRUE),
(3, 2, 'Mathematics', 'MATH-BS', 'bachelor', 'Bachelor of Science in Mathematics', 128, 4.0, 'Pure and applied mathematics with research opportunities', 'Calculus I completion, 3.5 GPA in math courses', 'Actuary, data analyst, teacher, graduate study', TRUE),
(4, 2, 'Applied Statistics', 'STAT-BS', 'bachelor', 'Bachelor of Science in Applied Statistics', 124, 4.0, 'Statistical analysis and data science applications', 'Statistics course completion, 3.0 GPA', 'Data scientist, statistician, market researcher', TRUE),
(5, 3, 'Biology', 'BIOL-BS', 'bachelor', 'Bachelor of Science in Biology', 130, 4.0, 'Comprehensive biological sciences with lab experience', 'Chemistry and biology prerequisites, 3.2 GPA', 'Research, healthcare, environmental science, graduate school', TRUE),
(6, 3, 'Biotechnology', 'BIOT-BS', 'bachelor', 'Bachelor of Science in Biotechnology', 132, 4.0, 'Applied biology with technology focus', 'Strong science background, 3.3 GPA', 'Biotech industry, pharmaceutical research, quality control', TRUE),
(7, 4, 'Chemistry', 'CHEM-BS', 'bachelor', 'Bachelor of Science in Chemistry', 128, 4.0, 'Chemical sciences with research emphasis', 'Advanced chemistry courses, 3.2 GPA', 'Chemical industry, research, healthcare, teaching', TRUE),
(8, 5, 'Physics', 'PHYS-BS', 'bachelor', 'Bachelor of Science in Physics', 126, 4.0, 'Theoretical and experimental physics', 'Advanced mathematics, physics courses, 3.4 GPA', 'Engineering, research, education, technology', TRUE),
(9, 6, 'History', 'HIST-BA', 'bachelor', 'Bachelor of Arts in History', 120, 4.0, 'Historical research and analysis', 'Writing proficiency, 3.0 GPA', 'Education, law, government, museum work', TRUE),
(10, 7, 'Psychology', 'PSYC-BS', 'bachelor', 'Bachelor of Science in Psychology', 124, 4.0, 'Scientific study of behavior and mental processes', 'Psychology prerequisites, 3.0 GPA', 'Counseling, human resources, research, graduate study', TRUE),

-- Business programs
(11, 8, 'Accounting', 'ACCT-BS', 'bachelor', 'Bachelor of Science in Accounting', 128, 4.0, 'Accounting principles and CPA preparation', 'Business math, economics, 3.0 GPA', 'CPA, financial analyst, auditor, controller', TRUE),
(12, 9, 'Business Management', 'MGMT-BS', 'bachelor', 'Bachelor of Science in Business Management', 124, 4.0, 'Leadership and organizational management', 'Business fundamentals, 2.8 GPA', 'Manager, supervisor, entrepreneur, consultant', TRUE),
(13, 10, 'Marketing', 'MKTG-BS', 'bachelor', 'Bachelor of Science in Marketing', 122, 4.0, 'Marketing strategy and consumer behavior', 'Business core courses, 2.8 GPA', 'Marketing manager, sales, advertising, brand management', TRUE),
(14, 11, 'Finance', 'FINC-BS', 'bachelor', 'Bachelor of Science in Finance', 126, 4.0, 'Financial analysis and investment management', 'Accounting, economics, math, 3.2 GPA', 'Financial advisor, analyst, banker, portfolio manager', TRUE),
(15, 12, 'Information Systems', 'ISYS-BS', 'bachelor', 'Bachelor of Science in Information Systems', 128, 4.0, 'Business applications of information technology', 'Programming, database, systems analysis', 'Systems analyst, IT manager, database administrator', TRUE),

-- Engineering programs
(16, 13, 'Computer Science', 'CSCI-BS', 'bachelor', 'Bachelor of Science in Computer Science', 132, 4.0, 'Software development and computer systems', 'Advanced mathematics, programming experience, 3.3 GPA', 'Software developer, systems engineer, data scientist', TRUE),
(17, 14, 'Electrical Engineering', 'EENG-BS', 'bachelor', 'Bachelor of Science in Electrical Engineering', 136, 4.0, 'Design and development of electrical systems', 'Calculus III, physics, chemistry, 3.5 GPA', 'Electrical engineer, systems designer, research engineer', TRUE),
(18, 15, 'Mechanical Engineering', 'MENG-BS', 'bachelor', 'Bachelor of Science in Mechanical Engineering', 134, 4.0, 'Design and manufacturing of mechanical systems', 'Advanced mathematics, physics, 3.4 GPA', 'Mechanical engineer, design engineer, project manager', TRUE),

-- Education programs
(19, 16, 'Elementary Education', 'ELED-BS', 'bachelor', 'Bachelor of Science in Elementary Education', 126, 4.0, 'Teacher preparation for grades K-6', 'Education courses, field experience, 3.0 GPA', 'Elementary teacher, curriculum specialist, administrator', TRUE),
(20, 17, 'Secondary Education - Mathematics', 'SCED-MATH', 'bachelor', 'Bachelor of Science in Secondary Mathematics Education', 130, 4.0, 'Mathematics teacher preparation for grades 7-12', 'Mathematics content knowledge, education courses', 'High school math teacher, department chair, coach', TRUE),
(21, 17, 'Secondary Education - English', 'SCED-ENGL', 'bachelor', 'Bachelor of Science in Secondary English Education', 128, 4.0, 'English teacher preparation for grades 7-12', 'English content knowledge, education courses', 'High school English teacher, reading specialist', TRUE),
(22, 18, 'Educational Leadership', 'EDLD-MS', 'master', 'Master of Science in Educational Leadership', 36, 2.0, 'Preparation for school administration', 'Teaching experience, leadership potential, 3.2 GPA', 'Principal, superintendent, curriculum director', TRUE),

-- Nursing and Health Sciences programs
(23, 19, 'Nursing', 'NURS-BSN', 'bachelor', 'Bachelor of Science in Nursing', 128, 4.0, 'Professional nursing preparation', 'Science prerequisites, health requirements, 3.3 GPA', 'Registered nurse, nurse manager, clinical specialist', TRUE),
(24, 20, 'Health Administration', 'HADM-BS', 'bachelor', 'Bachelor of Science in Health Administration', 124, 4.0, 'Healthcare management and administration', 'Healthcare experience preferred, 3.0 GPA', 'Hospital administrator, clinic manager, health coordinator', TRUE),

-- Graduate programs
(25, 1, 'English Literature', 'ENGL-MA', 'master', 'Master of Arts in English Literature', 36, 2.0, 'Advanced literary study and research', 'Bachelor degree in English or related field, 3.5 GPA', 'College teaching, publishing, doctoral study', TRUE),
(26, 2, 'Applied Mathematics', 'MATH-MS', 'master', 'Master of Science in Applied Mathematics', 36, 2.0, 'Advanced mathematical applications', 'Bachelor degree in mathematics, 3.3 GPA', 'Industry analyst, research, doctoral study', TRUE),
(27, 13, 'Computer Science', 'CSCI-MS', 'master', 'Master of Science in Computer Science', 36, 2.0, 'Advanced computing and software engineering', 'Bachelor degree in computer science or related field', 'Senior developer, architect, research', TRUE),
(28, 9, 'Business Administration', 'MBA', 'master', 'Master of Business Administration', 48, 2.0, 'Advanced business leadership and strategy', 'Bachelor degree, work experience preferred, GMAT', 'Executive, consultant, entrepreneur', TRUE),

-- North Campus programs
(29, 21, 'Liberal Studies', 'LIBS-BA', 'bachelor', 'Bachelor of Arts in Liberal Studies', 120, 4.0, 'Interdisciplinary liberal arts education', 'High school diploma, 2.5 GPA', 'Various fields, graduate preparation', TRUE),
(30, 22, 'Environmental Science', 'ENVS-BS', 'bachelor', 'Bachelor of Science in Environmental Science', 126, 4.0, 'Environmental studies and conservation', 'Science background, 3.0 GPA', 'Environmental consultant, researcher, policy analyst', TRUE),
(31, 23, 'Business Administration', 'BADM-BS', 'bachelor', 'Bachelor of Science in Business Administration', 124, 4.0, 'General business preparation', 'High school diploma, 2.8 GPA', 'Management, sales, small business', TRUE),
(32, 24, 'Information Technology', 'ITEC-BS', 'bachelor', 'Bachelor of Science in Information Technology', 126, 4.0, 'Applied information technology', 'Technical aptitude, 2.8 GPA', 'IT support, network admin, web developer', TRUE),

-- Online programs
(33, 25, 'Online Business Administration', 'OBADM-BS', 'bachelor', 'Bachelor of Science in Business Administration (Online)', 124, 4.0, 'Flexible online business degree', 'High school diploma, computer access', 'Management, entrepreneurship, consulting', TRUE),
(34, 25, 'Online Liberal Studies', 'OLIBS-BA', 'bachelor', 'Bachelor of Arts in Liberal Studies (Online)', 120, 4.0, 'Flexible online liberal arts degree', 'High school diploma, computer skills', 'Various career paths, graduate preparation', TRUE),

-- Edge case: Inactive program
(35, 6, 'European History', 'HIST-EUR', 'bachelor', 'Bachelor of Arts in European History', 120, 4.0, 'Specialized European historical studies', 'Language requirement, history background', 'Teaching, research, government', FALSE);

-- ==========================================
-- FACULTY
-- ==========================================

INSERT INTO faculty (faculty_id, employee_id, first_name, last_name, middle_name, title, email, phone, office_location, address, city, state, zip_code, date_of_birth, hire_date, tenure_date, salary, department_id, campus_id, position_title, academic_rank, employment_status, education_background, research_interests, publications_count, office_hours, biography, website, is_active) VALUES

-- English Department Faculty
(1, 'FAC001', 'Dr.', 'Jennifer', 'Anne', 'Williams', 'j.williams@excellenceuniv.edu', '555-800-1001', 'Humanities Hall 201', '123 Faculty Row', 'Learning City', 'EDU', '12450', '1975-03-15', '2005-08-15', '2011-08-15', 75000.00, 1, 1, 'Professor of English', 'professor', 'full_time', '[{"degree": "PhD English Literature", "institution": "Harvard University", "year": 2004}, {"degree": "MA English", "institution": "Yale University", "year": 2000}]', '["Victorian Literature", "Feminist Literary Theory", "Digital Humanities"]', 45, '[{"day": "Monday", "start": "10:00", "end": "12:00"}, {"day": "Wednesday", "start": "14:00", "end": "16:00"}]', 'Dr. Williams specializes in Victorian literature with a focus on women writers.', 'https://faculty.excellenceuniv.edu/jwilliams', TRUE),

(2, 'FAC002', 'Dr.', 'Michael', 'James', 'Davis', 'm.davis@excellenceuniv.edu', '555-800-1002', 'Humanities Hall 202', '456 Scholar St', 'Learning City', 'EDU', '12450', '1980-07-22', '2010-08-15', '2016-08-15', 72000.00, 1, 1, 'Associate Professor of English', 'associate_professor', 'full_time', '[{"degree": "PhD Creative Writing", "institution": "Iowa Writers Workshop", "year": 2009}, {"degree": "MFA Fiction", "institution": "Columbia University", "year": 2005}]', '["Contemporary Fiction", "Creative Writing Pedagogy", "Literary Magazines"]', 28, '[{"day": "Tuesday", "start": "09:00", "end": "11:00"}, {"day": "Thursday", "start": "13:00", "end": "15:00"}]', 'Published novelist and creative writing instructor.', 'https://faculty.excellenceuniv.edu/mdavis', TRUE),

-- Mathematics Department Faculty
(3, 'FAC003', 'Dr.', 'Sarah', 'Elizabeth', 'Brown', 's.brown@excellenceuniv.edu', '555-800-1003', 'Science Complex 301', '789 Academic Ave', 'Learning City', 'EDU', '12450', '1978-11-08', '2008-08-15', '2014-08-15', 78000.00, 2, 1, 'Professor of Mathematics', 'professor', 'full_time', '[{"degree": "PhD Mathematics", "institution": "MIT", "year": 2007}, {"degree": "MS Applied Mathematics", "institution": "Stanford University", "year": 2003}]', '["Differential Equations", "Mathematical Modeling", "Computational Mathematics"]', 52, '[{"day": "Monday", "start": "11:00", "end": "13:00"}, {"day": "Friday", "start": "10:00", "end": "12:00"}]', 'Expert in applied mathematics with focus on modeling real-world phenomena.', 'https://faculty.excellenceuniv.edu/sbrown', TRUE),

(4, 'FAC004', 'Dr.', 'Robert', 'John', 'Miller', 'r.miller@excellenceuniv.edu', '555-800-1004', 'Science Complex 302', '321 University Blvd', 'Learning City', 'EDU', '12450', '1982-05-20', '2012-08-15', '2018-08-15', 74000.00, 2, 1, 'Associate Professor of Statistics', 'associate_professor', 'full_time', '[{"degree": "PhD Statistics", "institution": "UC Berkeley", "year": 2011}, {"degree": "MS Statistics", "institution": "University of Michigan", "year": 2007}]', '["Bayesian Statistics", "Data Science", "Statistical Computing"]', 35, '[{"day": "Tuesday", "start": "14:00", "end": "16:00"}, {"day": "Thursday", "start": "10:00", "end": "12:00"}]', 'Leading researcher in Bayesian methods and big data analytics.', 'https://faculty.excellenceuniv.edu/rmiller', TRUE),

-- Biology Department Faculty
(5, 'FAC005', 'Dr.', 'Lisa', 'Maria', 'Garcia', 'l.garcia@excellenceuniv.edu', '555-800-1005', 'Science Complex 101', '654 Science Way', 'Learning City', 'EDU', '12450', '1985-09-12', '2015-08-15', NULL, 68000.00, 3, 1, 'Assistant Professor of Biology', 'assistant_professor', 'full_time', '[{"degree": "PhD Molecular Biology", "institution": "Johns Hopkins University", "year": 2014}, {"degree": "BS Biology", "institution": "University of California, San Diego", "year": 2009}]', '["Gene Expression", "Cancer Research", "Biotechnology Applications"]', 18, '[{"day": "Monday", "start": "13:00", "end": "15:00"}, {"day": "Wednesday", "start": "11:00", "end": "13:00"}]', 'Rising star in molecular biology research.', 'https://faculty.excellenceuniv.edu/lgarcia', TRUE),

-- Computer Science Department Faculty (Engineering)
(6, 'FAC006', 'Dr.', 'David', 'Andrew', 'Wilson', 'd.wilson@excellenceuniv.edu', '555-800-1006', 'Engineering Building 301', '111 Innovation Dr', 'Learning City', 'EDU', '12450', '1979-12-03', '2009-08-15', '2015-08-15', 85000.00, 13, 1, 'Professor of Computer Science', 'professor', 'full_time', '[{"degree": "PhD Computer Science", "institution": "Carnegie Mellon University", "year": 2008}, {"degree": "MS Computer Engineering", "institution": "Georgia Tech", "year": 2004}]', '["Artificial Intelligence", "Machine Learning", "Computer Vision"]', 67, '[{"day": "Tuesday", "start": "10:00", "end": "12:00"}, {"day": "Thursday", "start": "14:00", "end": "16:00"}]', 'Leading AI researcher with industry partnerships.', 'https://faculty.excellenceuniv.edu/dwilson', TRUE),

-- Business Faculty
(7, 'FAC007', 'Dr.', 'Karen', 'Lynn', 'Anderson', 'k.anderson@excellenceuniv.edu', '555-800-1007', 'Business Administration Building 301', '222 Business Circle', 'Learning City', 'EDU', '12450', '1976-04-17', '2006-08-15', '2012-08-15', 82000.00, 9, 1, 'Professor of Management', 'professor', 'full_time', '[{"degree": "PhD Management", "institution": "Wharton School", "year": 2005}, {"degree": "MBA", "institution": "Northwestern Kellogg", "year": 2000}]', '["Leadership Development", "Organizational Behavior", "Strategic Management"]', 41, '[{"day": "Monday", "start": "09:00", "end": "11:00"}, {"day": "Wednesday", "start": "15:00", "end": "17:00"}]', 'Expert in leadership development with corporate consulting experience.', 'https://faculty.excellenceuniv.edu/kanderson', TRUE),

-- Education Faculty
(8, 'FAC008', 'Dr.', 'Mark', 'Steven', 'Taylor', 'm.taylor@excellenceuniv.edu', '555-800-1008', 'Education Building 201', '333 Teaching Terrace', 'Learning City', 'EDU', '12450', '1981-08-25', '2011-08-15', '2017-08-15', 70000.00, 16, 1, 'Associate Professor of Elementary Education', 'associate_professor', 'full_time', '[{"degree": "PhD Curriculum and Instruction", "institution": "Teachers College Columbia", "year": 2010}, {"degree": "MEd Elementary Education", "institution": "University of Georgia", "year": 2005}]', '["Reading Instruction", "STEM Education", "Teacher Professional Development"]', 29, '[{"day": "Tuesday", "start": "11:00", "end": "13:00"}, {"day": "Thursday", "start": "09:00", "end": "11:00"}]', 'Former elementary teacher with expertise in literacy instruction.', 'https://faculty.excellenceuniv.edu/mtaylor', TRUE),

-- Nursing Faculty
(9, 'FAC009', 'Dr.', 'Jennifer', 'Nicole', 'Clark', 'j.clark@excellenceuniv.edu', '555-800-1009', 'Health Sciences Building 101', '444 Health Way', 'Learning City', 'EDU', '12450', '1983-01-14', '2013-08-15', '2019-08-15', 76000.00, 19, 1, 'Associate Professor of Nursing', 'associate_professor', 'full_time', '[{"degree": "PhD Nursing", "institution": "Johns Hopkins School of Nursing", "year": 2012}, {"degree": "MSN Nurse Practitioner", "institution": "Vanderbilt University", "year": 2007}]', '["Community Health Nursing", "Health Promotion", "Nursing Education"]', 33, '[{"day": "Monday", "start": "14:00", "end": "16:00"}, {"day": "Friday", "start": "10:00", "end": "12:00"}]', 'Practicing nurse practitioner and nursing educator.', 'https://faculty.excellenceuniv.edu/jclark', TRUE),

-- North Campus Faculty
(10, 'FAC010', 'Dr.', 'Christopher', 'Michael', 'Lewis', 'c.lewis@excellenceuniv.edu', '555-800-2001', 'North Liberal Arts 101', '555 North Campus Dr', 'North Learning', 'EDU', '12451', '1977-06-30', '2007-08-15', '2013-08-15', 68000.00, 21, 2, 'Professor of Liberal Studies', 'professor', 'full_time', '[{"degree": "PhD Interdisciplinary Studies", "institution": "University of Virginia", "year": 2006}, {"degree": "MA History", "institution": "Duke University", "year": 2002}]', '["Environmental History", "Cultural Studies", "Community Engagement"]', 38, '[{"day": "Tuesday", "start": "13:00", "end": "15:00"}, {"day": "Thursday", "start": "11:00", "end": "13:00"}]', 'Interdisciplinary scholar with community focus.', 'https://faculty.excellenceuniv.edu/clewis', TRUE),

-- Part-time/Adjunct Faculty
(11, 'FAC011', 'Prof.', 'Michelle', 'Carmen', 'Rodriguez', 'm.rodriguez@excellenceuniv.edu', '555-800-1011', 'Business Administration Building 102', '666 Adjunct Ave', 'Learning City', 'EDU', '12450', '1988-10-11', '2020-08-15', NULL, 45000.00, 10, 1, 'Instructor of Marketing', 'instructor', 'part_time', '[{"degree": "MBA Marketing", "institution": "Excellence University", "year": 2015}, {"degree": "BS Business", "institution": "State University", "year": 2010}]', '["Digital Marketing", "Social Media Strategy", "Brand Management"]', 5, '[{"day": "Monday", "start": "18:00", "end": "20:00"}]', 'Marketing professional teaching evening courses.', NULL, TRUE),

-- Edge case: Faculty on leave
(12, 'FAC012', 'Dr.', 'James', 'William', 'Thompson', 'j.thompson@excellenceuniv.edu', '555-800-1012', 'Chemistry Lab 201', '777 Research Rd', 'Learning City', 'EDU', '12450', '1974-02-28', '2004-08-15', '2010-08-15', 80000.00, 4, 1, 'Professor of Chemistry', 'professor', 'full_time', '[{"degree": "PhD Chemistry", "institution": "Caltech", "year": 2003}, {"degree": "BS Chemistry", "institution": "MIT", "year": 1998}]', '["Organic Synthesis", "Medicinal Chemistry", "Drug Discovery"]', 89, '[]', 'Currently on sabbatical for research.', 'https://faculty.excellenceuniv.edu/jthompson', TRUE),

-- Edge case: Emeritus faculty
(13, 'FAC013', 'Dr.', 'Patricia', 'Jane', 'White', 'p.white@excellenceuniv.edu', '555-800-1013', 'Emeritus Office', '888 Retirement Ln', 'Learning City', 'EDU', '12450', '1950-12-05', '1985-08-15', '1991-08-15', 65000.00, 6, 1, 'Professor Emeritus of History', 'emeritus', 'emeritus', '[{"degree": "PhD History", "institution": "Harvard University", "year": 1984}, {"degree": "MA History", "institution": "Princeton University", "year": 1980}]', '["American Colonial History", "Women in History", "Historical Methodology"]', 156, '[]', 'Retired professor emeritus with distinguished career.', 'https://faculty.excellenceuniv.edu/pwhite', TRUE);

-- Update department chair assignments
UPDATE departments SET chair_id = 1 WHERE department_id = 1;   -- Jennifer Williams for English
UPDATE departments SET chair_id = 3 WHERE department_id = 2;   -- Sarah Brown for Mathematics  
UPDATE departments SET chair_id = 5 WHERE department_id = 3;   -- Lisa Garcia for Biology
UPDATE departments SET chair_id = 7 WHERE department_id = 9;   -- Karen Anderson for Management
UPDATE departments SET chair_id = 6 WHERE department_id = 13;  -- David Wilson for Computer Science
UPDATE departments SET chair_id = 8 WHERE department_id = 16;  -- Mark Taylor for Elementary Education
UPDATE departments SET chair_id = 9 WHERE department_id = 19;  -- Jennifer Clark for Nursing
UPDATE departments SET chair_id = 10 WHERE department_id = 21; -- Christopher Lewis for Liberal Studies

-- Update college dean assignments
UPDATE colleges SET dean_id = 1 WHERE college_id = 1;  -- Jennifer Williams as interim dean of CLAS
UPDATE colleges SET dean_id = 7 WHERE college_id = 2;  -- Karen Anderson for Business
UPDATE colleges SET dean_id = 6 WHERE college_id = 3;  -- David Wilson for Engineering
UPDATE colleges SET dean_id = 8 WHERE college_id = 4;  -- Mark Taylor for Education
UPDATE colleges SET dean_id = 9 WHERE college_id = 5;  -- Jennifer Clark for Nursing
UPDATE colleges SET dean_id = 10 WHERE college_id = 6; -- Christopher Lewis for North Campus Liberal Studies

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;