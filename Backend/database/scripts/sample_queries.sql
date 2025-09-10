-- Sample Queries for Database Warehouse Testing
-- Run these queries to verify the database warehouse is working correctly

-- ==========================================
-- SCHOOL DATABASE QUERIES
-- ==========================================

USE school_db;

-- 1. Basic student enrollment count by campus
SELECT 
    c.campus_name,
    c.campus_type,
    COUNT(s.student_id) as total_students,
    COUNT(CASE WHEN s.status = 'active' THEN 1 END) as active_students
FROM campuses c
LEFT JOIN students s ON c.campus_id = s.campus_id
GROUP BY c.campus_id, c.campus_name, c.campus_type
ORDER BY total_students DESC;

-- 2. Teacher workload analysis
SELECT 
    CONCAT(t.first_name, ' ', t.last_name) AS teacher_name,
    d.department_name,
    COUNT(cl.class_id) AS classes_taught,
    SUM(cl.current_enrollment) AS total_students,
    AVG(cl.current_enrollment) AS avg_class_size
FROM teachers t
JOIN departments d ON t.department_id = d.department_id
LEFT JOIN classes cl ON t.teacher_id = cl.teacher_id AND cl.is_active = TRUE
WHERE t.is_active = TRUE
GROUP BY t.teacher_id
ORDER BY total_students DESC;

-- 3. Students with special circumstances (edge cases)
SELECT 
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    s.student_number,
    g.grade_level,
    s.status,
    s.medical_conditions,
    s.special_needs,
    s.lunch_program
FROM students s
JOIN grades g ON s.current_grade_id = g.grade_id
WHERE s.medical_conditions IS NOT NULL 
   OR s.special_needs IS NOT NULL 
   OR s.lunch_program IN ('free', 'reduced')
ORDER BY s.last_name;

-- 4. Assignment submission analysis (showing late work and performance)
SELECT 
    a.assignment_name,
    a.assignment_type,
    COUNT(asub.submission_id) as total_submissions,
    COUNT(CASE WHEN asub.is_late = TRUE THEN 1 END) as late_submissions,
    AVG(asub.points_earned) as avg_points,
    AVG(CASE WHEN asub.is_late = FALSE THEN asub.points_earned END) as avg_points_on_time
FROM assignments a
LEFT JOIN assignment_submissions asub ON a.assignment_id = asub.assignment_id
WHERE asub.status = 'graded'
GROUP BY a.assignment_id
ORDER BY late_submissions DESC;

-- ==========================================
-- COLLEGE DATABASE QUERIES
-- ==========================================

USE college_db;

-- 5. Student diversity and demographics analysis
SELECT 
    graduation_status,
    student_type,
    enrollment_status,
    COUNT(*) as student_count,
    AVG(gpa) as avg_gpa,
    COUNT(CASE WHEN financial_aid_eligible = TRUE THEN 1 END) as financial_aid_count
FROM students
GROUP BY graduation_status, student_type, enrollment_status
ORDER BY student_count DESC;

-- 6. Course enrollment and capacity utilization
SELECT 
    c.course_code,
    c.course_title,
    cs.section_number,
    cs.max_enrollment,
    cs.current_enrollment,
    cs.waitlist_count,
    ROUND((cs.current_enrollment / cs.max_enrollment) * 100, 1) as capacity_percent,
    cs.delivery_method
FROM courses c
JOIN course_sections cs ON c.course_id = cs.course_id
WHERE cs.is_active = TRUE
ORDER BY capacity_percent DESC;

-- 7. Faculty research participation and workload
SELECT 
    CONCAT(f.first_name, ' ', f.last_name) AS faculty_name,
    f.academic_rank,
    d.department_name,
    COUNT(DISTINCT cs.section_id) as sections_taught,
    COUNT(DISTINCT rp.participation_id) as research_projects,
    f.publications_count
FROM faculty f
JOIN departments dept ON f.department_id = dept.department_id
JOIN departments d ON f.department_id = d.department_id
LEFT JOIN course_sections cs ON f.faculty_id = cs.faculty_id AND cs.is_active = TRUE
LEFT JOIN research_participants rp ON f.faculty_id = rp.faculty_id AND rp.is_active = TRUE
WHERE f.is_active = TRUE
GROUP BY f.faculty_id
ORDER BY research_projects DESC, sections_taught DESC;

-- 8. Assignment performance by course difficulty
SELECT 
    c.course_code,
    c.difficulty_level,
    COUNT(a.assignment_id) as total_assignments,
    COUNT(asub.submission_id) as total_submissions,
    AVG(asub.percentage_score) as avg_score,
    COUNT(CASE WHEN asub.is_late = TRUE THEN 1 END) as late_submissions,
    AVG(asub.time_spent_hours) as avg_time_spent
FROM courses c
JOIN course_sections cs ON c.course_id = cs.course_id
JOIN assignments a ON cs.section_id = a.section_id
LEFT JOIN assignment_submissions asub ON a.assignment_id = asub.assignment_id
WHERE asub.status = 'graded'
GROUP BY c.course_id
ORDER BY c.difficulty_level, avg_score DESC;

-- ==========================================
-- CROSS-DATABASE QUERIES
-- ==========================================

-- 9. Student progression from school to college
SELECT 
    st.school_student_number,
    CONCAT(cs.first_name, ' ', cs.last_name) AS student_name,
    st.transfer_type,
    st.previous_graduation_date,
    cs.admission_date,
    DATEDIFF(cs.admission_date, st.previous_graduation_date) as gap_days,
    dp.program_name,
    cs.gpa as college_gpa,
    st.previous_gpa as high_school_gpa
FROM student_transfers st
JOIN students cs ON st.college_student_id = cs.student_id
LEFT JOIN degree_programs dp ON cs.program_id = dp.program_id
WHERE st.verification_status = 'verified'
ORDER BY st.transfer_date DESC;

-- 10. Dual enrollment student performance
SELECT 
    de.enrollment_type,
    CONCAT(cs.first_name, ' ', cs.last_name) AS student_name,
    de.school_grade_level,
    c.course_code,
    c.course_title,
    e.final_grade,
    e.grade_points,
    CASE 
        WHEN e.grade_points >= 3.5 THEN 'Excellent'
        WHEN e.grade_points >= 3.0 THEN 'Good'
        WHEN e.grade_points >= 2.0 THEN 'Satisfactory'
        ELSE 'Needs Improvement'
    END as performance_level
FROM dual_enrollment de
JOIN students cs ON de.college_student_id = cs.student_id
JOIN course_sections sec ON de.college_section_id = sec.section_id
JOIN courses c ON sec.course_id = c.course_id
LEFT JOIN enrollments e ON cs.student_id = e.student_id AND sec.section_id = e.section_id
ORDER BY e.grade_points DESC;

-- 11. Shared faculty workload analysis
SELECT 
    cif.shared_employee_id,
    CONCAT(f.first_name, ' ', f.last_name) AS faculty_name,
    f.academic_rank,
    d.department_name as college_department,
    cif.primary_institution,
    cif.employment_percentage_school,
    cif.employment_percentage_college,
    cif.shared_responsibilities
FROM cross_institution_faculty cif
JOIN faculty f ON cif.college_faculty_id = f.faculty_id
JOIN departments d ON f.department_id = d.department_id
WHERE cif.is_active = TRUE
ORDER BY f.last_name;

-- 12. Shared resource utilization summary
SELECT 
    sr.resource_name,
    sr.resource_type,
    sr.primary_institution,
    COUNT(sru.usage_id) as total_uses,
    COUNT(CASE WHEN sru.user_institution = 'school' THEN 1 END) as school_uses,
    COUNT(CASE WHEN sru.user_institution = 'college' THEN 1 END) as college_uses,
    AVG(sru.satisfaction_rating) as avg_satisfaction,
    MAX(sru.usage_date) as last_used
FROM shared_resources sr
LEFT JOIN shared_resource_usage sru ON sr.resource_id = sru.resource_id
WHERE sr.is_active = TRUE
GROUP BY sr.resource_id
ORDER BY total_uses DESC;

-- ==========================================
-- EDGE CASE VERIFICATION QUERIES
-- ==========================================

-- 13. Students with NULL values (testing data quality)
SELECT 'School DB - Students with NULL phone' as test_case, COUNT(*) as count
FROM school_db.students WHERE phone IS NULL
UNION ALL
SELECT 'College DB - Students with NULL optional fields', COUNT(*)
FROM college_db.students WHERE phone IS NULL OR middle_name IS NULL
UNION ALL
SELECT 'School DB - Students with special needs', COUNT(*)
FROM school_db.students WHERE special_needs IS NOT NULL
UNION ALL
SELECT 'College DB - Students on academic probation', COUNT(*)
FROM college_db.students WHERE academic_standing = 'probation';

-- 14. Late submissions and academic challenges
SELECT 
    'School Late Submissions' as category,
    COUNT(*) as count,
    AVG(late_penalty) as avg_penalty
FROM school_db.assignment_submissions 
WHERE is_late = TRUE
UNION ALL
SELECT 
    'College Late Submissions',
    COUNT(*),
    AVG(late_penalty)
FROM college_db.assignment_submissions 
WHERE is_late = TRUE;

-- 15. System constraints verification
SELECT 
    'School - Max class enrollment check' as test_case,
    COUNT(*) as violations
FROM school_db.classes 
WHERE current_enrollment > max_students
UNION ALL
SELECT 
    'College - GPA range check',
    COUNT(*)
FROM college_db.students 
WHERE gpa < 0.00 OR gpa > 4.00
UNION ALL
SELECT 
    'College - Credit hours validation',
    COUNT(*)
FROM college_db.students 
WHERE completed_credit_hours > total_credit_hours;

-- End of sample queries