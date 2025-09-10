-- Cross-Database Linking Sample Data
-- Student transfers, dual enrollment, and shared resources

USE college_db;

SET FOREIGN_KEY_CHECKS = 0;

-- ==========================================
-- STUDENT TRANSFERS FROM SCHOOL TO COLLEGE
-- ==========================================

INSERT INTO student_transfers (transfer_id, college_student_id, school_database_name, school_student_id, school_student_number, transfer_date, transfer_type, previous_school_name, previous_graduation_date, previous_gpa, credits_transferred, transfer_notes, verification_status, verified_by_staff, verification_date) VALUES

-- Jacob Young (graduated from Mountain View High School, now at Excellence University)
(1, 16, 'school_db', 16, 'MTV2023001', '2023-05-15', 'graduated_to_college', 'Mountain View High School', '2023-05-12', 3.67, 0, 'Graduated with honors, strong academic record', 'verified', 'Admissions Counselor Smith', '2023-06-01'),

-- Harper Martin (current high school senior, early admission)
(2, 15, 'school_db', 15, 'MTV2024004', '2021-08-23', 'direct_transfer', 'Mountain View High School', NULL, 3.98, 12, 'Early admission program, exceptional student', 'verified', 'Admissions Director Jones', '2021-08-15'),

-- Example of transfer student not in our sample data (shows system flexibility)
(3, 6, 'school_db', 999, 'MTV2021005', '2023-01-17', 'gap_year_return', 'Mountain View High School', '2021-05-14', 3.28, 8, 'Took gap year for work experience, transferred as junior', 'verified', 'Transfer Coordinator Davis', '2022-12-15'),

-- Student who attended different school system
(4, 10, 'school_db', 888, 'OTHER2019001', '2023-08-21', 'graduated_to_college', 'Regional Technical High School', '2019-05-18', 3.45, 6, 'Veteran student with technical background', 'verified', 'Veterans Affairs Counselor', '2023-07-10');

-- ==========================================
-- DUAL ENROLLMENT STUDENTS
-- ==========================================

INSERT INTO dual_enrollment (dual_enrollment_id, college_student_id, school_database_name, school_student_id, school_grade_level, enrollment_type, college_section_id, school_approval_required, school_approval_date, school_counselor_name, parent_permission_required, parent_permission_date, tuition_responsibility, transportation_arrangement, expected_graduation_impact, success_probability_assessment) VALUES

-- Grace Scott (dual enrollment from Riverside K-12)
(1, 19, 'school_db', 19, '10', 'dual_credit', 1, TRUE, '2024-01-10', 'Ms. Academic Advisor', TRUE, '2024-01-08', 'school_district', 'parent', 'Will graduate with 6 college credits', 'High - exceptional student with strong support'),

-- Example of another dual enrollment student
(2, 19, 'school_db', 19, '10', 'dual_credit', 6, TRUE, '2024-01-10', 'Ms. Academic Advisor', TRUE, '2024-01-08', 'school_district', 'parent', 'Building math foundation for STEM', 'High - excellent math aptitude');

-- ==========================================
-- CROSS-INSTITUTIONAL FACULTY
-- ==========================================

INSERT INTO cross_institution_faculty (cross_faculty_id, college_faculty_id, school_database_name, school_teacher_id, shared_employee_id, primary_institution, employment_percentage_school, employment_percentage_college, start_date, shared_responsibilities, is_active) VALUES

-- Dr. Jennifer Williams teaching both at college and occasionally at high school
(1, 1, 'school_db', 17, 'SHARED001', 'college', 10.00, 90.00, '2023-08-15', 'Provides AP English instruction at Mountain View High School once per week', TRUE),

-- Dr. Mark Taylor (Education professor) working with school district
(2, 8, 'school_db', 8, 'SHARED002', 'college', 20.00, 80.00, '2022-08-15', 'Professional development coordinator for middle school science teachers', TRUE),

-- Math faculty member supporting high school advanced math
(3, 3, 'school_db', 11, 'SHARED003', 'college', 15.00, 85.00, '2021-08-15', 'Teaches AP Calculus at Mountain View High School', TRUE);

-- ==========================================
-- CURRICULUM ALIGNMENT
-- ==========================================

INSERT INTO curriculum_alignment (alignment_id, college_course_id, school_database_name, school_subject_id, school_subject_code, alignment_type, credit_transfer_ratio, minimum_grade_required, effective_date, approval_status, approved_by_faculty_id, approval_date, notes) VALUES

-- AP Calculus to College Calculus
(1, 9, 'school_db', 39, 'HS-APCALC', 'equivalent', 1.00, 'B', '2020-08-01', 'approved', 3, '2020-06-15', 'AP Calculus with score of 4 or 5 grants credit for MATH2250'),

-- High School English to College Composition
(2, 1, 'school_db', 26, 'HS-ENG9', 'preparatory', 0.00, 'B', '2019-08-01', 'approved', 1, '2019-05-20', 'Strong high school English prepares students for college composition'),
(3, 1, 'school_db', 38, 'HS-ENG12', 'preparatory', 0.00, 'A-', '2019-08-01', 'approved', 1, '2019-05-20', 'Excellent HS English may allow direct placement into ENGL1102'),

-- AP Biology to College Biology
(4, 13, 'school_db', 40, 'HS-APBIO', 'equivalent', 1.00, 'B+', '2021-08-01', 'approved', 5, '2021-06-10', 'AP Biology with score of 4 or 5 may substitute for BIOL1107'),

-- Computer Science alignment
(5, 18, 'school_db', 46, 'HS-COMPSC1', 'prerequisite', 0.50, 'B', '2022-08-01', 'approved', 6, '2022-07-15', 'High school CS provides foundation for college programming'),
(6, 20, 'school_db', 47, 'HS-COMPSC2', 'prerequisite', 0.75, 'B+', '2022-08-01', 'approved', 6, '2022-07-15', 'Advanced high school CS prepares for software development');

-- ==========================================
-- SHARED RESOURCES
-- ==========================================

INSERT INTO shared_resources (resource_id, resource_name, resource_type, location, primary_institution, capacity, usage_schedule, cost_sharing_arrangement, maintenance_responsibility, contact_person, contact_email, contact_phone, special_requirements, is_active) VALUES

(1, 'Excellence Education Center Library', 'library', '1500 Shared Learning Blvd', 'shared', 200, '{"school_hours": "7:00-15:00 weekdays", "college_hours": "15:00-22:00 weekdays, 9:00-17:00 weekends"}', '60% college, 40% school district funding', 'shared', 'Dr. Library Director', 'library@excellenceedu.org', '555-800-5000', 'ID required, different borrowing periods by institution', TRUE),

(2, 'STEM Innovation Laboratory', 'laboratory', 'Science Complex Building A', 'college', 40, '{"college_classes": "Monday-Friday 8:00-16:00", "school_field_trips": "Friday afternoons", "summer_programs": "June-July mornings"}', 'College maintains, school pays usage fees', 'college', 'Dr. STEM Coordinator', 'stemlab@excellenceuniv.edu', '555-800-5001', 'Advanced booking required, safety training mandatory', TRUE),

(3, 'Excellence Performing Arts Center', 'auditorium', '800 Arts Avenue', 'shared', 500, '{"school_events": "December, March, May", "college_events": "October, February, April", "community_events": "flexible"}', 'Split maintenance costs 50/50', 'third_party', 'Arts Center Manager', 'artscenter@excellenceedu.org', '555-800-5002', 'Professional sound/lighting available, booking 6 months in advance', TRUE),

(4, 'Transportation Hub', 'transportation', 'Campus Central', 'school', 12, '{"school_buses": "6:30-8:30, 14:30-16:30", "college_shuttle": "8:00-22:00", "special_events": "as needed"}', 'School provides buses, college funds shuttle', 'school', 'Transportation Director', 'transport@excellenceedu.org', '555-800-5003', 'CDL required for drivers, maintenance schedule critical', TRUE),

(5, 'Athletic Complex', 'gymnasium', 'Sports Campus', 'shared', 1000, '{"high_school_sports": "15:30-18:00 weekdays", "college_sports": "18:00-21:00 weekdays", "community_programs": "weekends"}', 'Usage fees based on time allocation', 'shared', 'Athletic Director', 'athletics@excellenceedu.org', '555-800-5004', 'Equipment storage separate by institution', TRUE);

-- ==========================================
-- SHARED RESOURCE USAGE
-- ==========================================

INSERT INTO shared_resource_usage (usage_id, resource_id, user_institution, user_type, user_id, usage_date, start_time, end_time, purpose, group_size, special_equipment_used, satisfaction_rating, feedback) VALUES

-- Library usage
(1, 1, 'school', 'student', 15, '2024-03-01', '16:00:00', '18:00:00', 'Research for senior paper', 1, 'Computer workstation, printer', 5, 'Excellent resources and quiet study space'),
(2, 1, 'college', 'student', 1, '2024-03-01', '19:00:00', '21:00:00', 'Group study for literature exam', 4, 'Study room, whiteboard', 4, 'Good facilities, could use more group rooms'),
(3, 1, 'school', 'faculty', 10, '2024-03-02', '15:30:00', '17:00:00', 'Research for curriculum development', 1, 'Academic databases, interlibrary loan', 5, 'Outstanding professional resources'),

-- STEM Lab usage
(4, 2, 'school', 'student', 12, '2024-02-23', '13:00:00', '15:00:00', 'High school chemistry field trip', 25, 'Spectrophotometer, microscopes', 5, 'Amazing equipment, great learning experience'),
(5, 2, 'college', 'student', 3, '2024-02-26', '10:00:00', '12:00:00', 'Biology research project', 1, 'Cell culture equipment, microscopes', 4, 'Good equipment, scheduling can be challenging'),

-- Arts Center usage
(6, 3, 'school', 'student', 14, '2024-03-15', '18:00:00', '21:00:00', 'Senior class musical rehearsal', 45, 'Professional lighting, sound system', 5, 'Professional quality venue, excellent acoustics'),
(7, 3, 'college', 'faculty', 2, '2024-02-14', '19:00:00', '21:30:00', 'Poetry reading event', 75, 'Microphone system, recording equipment', 4, 'Great atmosphere, minor technical issues'),

-- Transportation usage
(8, 4, 'school', 'student', 8, '2024-03-01', '07:30:00', '08:00:00', 'Daily bus transportation', 1, 'School bus', 4, 'Reliable service, could use more routes'),
(9, 4, 'college', 'student', 11, '2024-03-01', '18:00:00', '18:15:00', 'Shuttle to North Campus', 1, 'Campus shuttle', 3, 'Functional but often crowded'),

-- Athletic Complex usage
(10, 5, 'school', 'student', 8, '2024-03-05', '16:00:00', '18:00:00', 'Basketball team practice', 12, 'Basketball court, scoreboard', 5, 'Excellent facilities, well maintained'),
(11, 5, 'college', 'student', 2, '2024-03-05', '19:00:00', '21:00:00', 'Intramural volleyball', 8, 'Volleyball net, court', 4, 'Good facilities, scheduling conflicts occasionally');

-- ==========================================
-- CROSS-INSTITUTIONAL FINANCIAL AID
-- ==========================================

INSERT INTO cross_institutional_financial_aid (aid_id, college_student_id, school_database_name, school_student_id, aid_program_name, aid_type, funding_source, total_amount, school_portion, college_portion, academic_year_id, eligibility_criteria, renewal_requirements, gpa_requirement, credit_hour_requirement, status, application_date, award_date, coordinator_name, coordinator_email, notes) VALUES

(1, 19, 'school_db', 19, 'Excellence Education Foundation Scholarship', 'scholarship', 'private', 5000.00, 0.00, 5000.00, 2, 'Local student attending Excellence University from partner high school', 'Maintain 3.5 GPA, 12 credit hours per semester', 3.50, 12, 'awarded', '2024-01-15', '2024-02-01', 'Ms. Scholarship Coordinator', 'scholarships@excellenceedu.org', 'Renewable for 4 years'),

(2, 16, 'school_db', 16, 'School-to-College Transition Grant', 'grant', 'institutional', 2500.00, 0.00, 2500.00, 1, 'Graduates from Mountain View High School', 'Maintain good academic standing', 2.50, 12, 'completed', '2023-03-01', '2023-04-15', 'Dr. Financial Aid Director', 'finaid@excellenceuniv.edu', 'One-time grant for first year'),

(3, 6, 'school_db', 999, 'Veterans Education Bridge Program', 'scholarship', 'federal', 8000.00, 0.00, 8000.00, 2, 'Military veteran transitioning from high school to college', 'Maintain satisfactory academic progress', 2.00, 6, 'disbursed', '2023-06-01', '2023-07-15', 'Veterans Affairs Counselor', 'veterans@excellenceuniv.edu', 'Covers part-time study for working veterans');

-- ==========================================
-- RESEARCH PROJECTS (Additional)
-- ==========================================

INSERT INTO research_projects (project_id, project_title, description, principal_investigator_id, department_id, start_date, end_date, budget, funding_source, grant_number, status, research_area, publications_count, website) VALUES

(1, 'K-12 to College STEM Pipeline Study', 'Longitudinal study of student success transitioning from Excellence school system to university STEM programs', 8, 16, '2023-01-01', '2026-12-31', 250000.00, 'National Science Foundation', 'NSF-2023-EDU-001', 'active', 'STEM Education', 2, 'https://research.excellenceuniv.edu/stem-pipeline'),

(2, 'Digital Literacy Across Educational Levels', 'Examining technology integration from elementary through college', 6, 13, '2022-08-01', '2025-07-31', 180000.00, 'Department of Education', 'DOE-2022-TECH-005', 'active', 'Educational Technology', 5, 'https://research.excellenceuniv.edu/digital-literacy'),

(3, 'Community Health Partnership Initiative', 'Collaborative health education program involving nursing students and local schools', 9, 19, '2024-01-01', '2026-12-31', 120000.00, 'State Health Department', 'SHD-2024-COMM-003', 'active', 'Community Health', 0, 'https://research.excellenceuniv.edu/health-partnership');

-- ==========================================
-- RESEARCH PARTICIPANTS
-- ==========================================

INSERT INTO research_participants (participation_id, project_id, faculty_id, role, start_date, effort_percentage, salary_support, is_active) VALUES

-- STEM Pipeline Study participants
(1, 1, 8, 'principal_investigator', '2023-01-01', 25.00, 15000.00, TRUE),
(2, 1, 3, 'co_investigator', '2023-01-01', 15.00, 8000.00, TRUE),
(3, 1, 6, 'researcher', '2023-02-01', 10.00, 5000.00, TRUE),

-- Digital Literacy Study participants
(4, 2, 6, 'principal_investigator', '2022-08-01', 30.00, 20000.00, TRUE),
(5, 2, 1, 'consultant', '2022-09-01', 5.00, 3000.00, TRUE),

-- Community Health Initiative participants
(6, 3, 9, 'principal_investigator', '2024-01-01', 20.00, 12000.00, TRUE),
(7, 3, 8, 'co_investigator', '2024-01-01', 10.00, 6000.00, TRUE);

-- ==========================================
-- STUDENT RESEARCH PARTICIPATION
-- ==========================================

INSERT INTO student_research (participation_id, project_id, student_id, role, start_date, hours_per_week, stipend_amount, credit_hours, is_active, performance_rating) VALUES

-- Graduate students in research
(1, 1, 8, 'graduate_assistant', '2023-08-21', 15.0, 1500.00, 3, TRUE, 'excellent'),
(2, 2, 9, 'research_assistant', '2023-01-17', 20.0, 2000.00, 6, TRUE, 'excellent'),

-- Undergraduate research opportunities
(3, 1, 15, 'undergraduate_researcher', '2024-01-16', 8.0, 500.00, 1, TRUE, 'excellent'),
(4, 3, 5, 'undergraduate_researcher', '2024-02-01', 10.0, 800.00, 2, TRUE, 'good');

-- ==========================================
-- ACADEMIC RECORDS (Additional)
-- ==========================================

INSERT INTO academic_records (record_id, student_id, semester_id, semester_gpa, semester_credit_hours, cumulative_gpa, cumulative_credit_hours, academic_standing, credits_attempted, credits_earned, quality_points, graduation_eligible, notes) VALUES

-- Spring 2024 records for sample students
(1, 1, 5, 3.67, 12, 3.75, 88, 'good', 92, 85, 318.75, FALSE, 'On track for graduation May 2025'),
(2, 2, 5, 3.25, 11, 3.42, 90, 'good', 95, 86, 294.12, FALSE, 'Improved performance this semester'),
(3, 3, 5, 3.92, 13, 3.89, 62, 'dean_list', 65, 61, 241.18, FALSE, 'Consistent high performance'),
(4, 4, 5, 2.85, 12, 3.25, 32, 'good', 35, 30, 97.50, FALSE, 'Freshman year adjustment'),
(5, 5, 5, 3.95, 14, 3.95, 65, 'dean_list', 67, 64, 252.80, FALSE, 'Outstanding nursing student'),
(6, 15, 5, 3.98, 12, 3.98, 92, 'dean_list', 95, 91, 362.18, FALSE, 'Honors program, early graduation possible'),
(7, 19, 5, 4.00, 6, 4.00, 6, 'dean_list', 6, 6, 24.00, FALSE, 'Dual enrollment - exceptional performance'),
(8, 20, 5, 2.15, 12, 2.75, 35, 'probation', 38, 32, 88.00, FALSE, 'Academic support services recommended');

-- ==========================================
-- HOUSING FACILITIES
-- ==========================================

INSERT INTO housing_facilities (facility_id, campus_id, facility_name, facility_type, address, building_year_built, total_capacity, current_occupancy, floor_count, amenities, room_types, cost_per_semester, utilities_included, parking_available, pets_allowed, smoking_allowed, is_active, contact_person, contact_phone) VALUES

(1, 1, 'Excellence Hall', 'dormitory', '100 Campus Housing Dr', 1995, 200, 180, 4, '["WiFi", "Laundry", "Common Rooms", "Study Lounges", "Vending Machines"]', '["Single", "Double", "Triple"]', 2500.00, TRUE, TRUE, FALSE, FALSE, TRUE, 'Housing Director Smith', '555-800-6001'),

(2, 1, 'University Apartments', 'apartment', '200 Student Village Way', 2010, 150, 135, 3, '["WiFi", "Parking", "Fitness Center", "Pool", "Laundry"]', '["1BR", "2BR", "4BR"]', 3200.00, FALSE, TRUE, TRUE, FALSE, TRUE, 'Apartment Manager Jones', '555-800-6002'),

(3, 1, 'Graduate Housing Complex', 'apartment', '300 Graduate Circle', 2015, 100, 85, 2, '["WiFi", "Private Parking", "Study Rooms", "Conference Room"]', '["Studio", "1BR", "2BR"]', 3800.00, TRUE, TRUE, TRUE, FALSE, TRUE, 'Graduate Housing Coordinator', '555-800-6003'),

(4, 2, 'North Campus Residence', 'dormitory', '400 North Campus Dr', 2000, 120, 100, 3, '["WiFi", "Laundry", "Recreation Room", "Kitchen"]', '["Single", "Double"]', 2200.00, TRUE, TRUE, FALSE, FALSE, TRUE, 'North Campus Housing', '555-800-6004');

-- ==========================================
-- HOUSING ASSIGNMENTS
-- ==========================================

INSERT INTO housing_assignments (assignment_id, student_id, facility_id, room_number, semester_id, move_in_date, cost_per_semester, security_deposit, payment_status, roommate_preferences, special_accommodations, key_issued, status) VALUES

(1, 1, 1, '205', 5, '2024-01-14', 2500.00, 250.00, 'paid', 'Quiet study environment preferred', NULL, TRUE, 'checked_in'),
(2, 4, 1, '112', 5, '2024-01-14', 2500.00, 250.00, 'paid', 'No specific preferences', NULL, TRUE, 'checked_in'),
(3, 5, 1, '305', 5, '2024-01-14', 2500.00, 250.00, 'paid', 'Pre-nursing students preferred', 'Medical refrigeration needed', TRUE, 'checked_in'),
(4, 6, 2, '3B', 5, '2024-01-14', 3200.00, 400.00, 'paid', 'Graduate/transfer students', NULL, TRUE, 'checked_in'),
(5, 15, 1, '405', 5, '2024-01-14', 2500.00, 250.00, 'paid', 'Honors students only', NULL, TRUE, 'checked_in'),
(6, 18, 1, '101', 5, '2024-01-14', 2500.00, 250.00, 'paid', 'Accommodations for any needs', 'Quiet floor, accessible room', TRUE, 'checked_in'),
(7, 9, 3, '2A', 5, '2024-01-14', 3800.00, 500.00, 'paid', 'Graduate students, married housing', NULL, TRUE, 'checked_in'),
(8, 11, 4, '201', 5, '2024-01-14', 2200.00, 200.00, 'paid', 'First-year students', NULL, TRUE, 'checked_in'),
(9, 12, 4, '205', 5, '2024-01-14', 2200.00, 200.00, 'paid', 'Understanding of anxiety issues', 'Counseling services nearby', TRUE, 'checked_in'),
(10, 20, 1, '115', 5, '2024-01-14', 2500.00, 250.00, 'overdue', 'Academic support services', 'Academic success coaching', TRUE, 'checked_in');

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;