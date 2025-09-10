# Database Warehouse for Testing

This directory contains a comprehensive database warehouse designed for testing and development purposes, featuring both K-12 school and university management systems with realistic data and edge cases.

## Overview

The database warehouse consists of two main databases that belong to the same educational company:

1. **School Database** (`school_db`) - K-12 education management
2. **College Database** (`college_db`) - University education management

Both databases are interconnected with student transfers, shared faculty, dual enrollment programs, and shared resources.

## Features

### School Database (`school_db`)
- **Campuses**: Elementary, middle, high school, and K-12 combined campuses
- **Academic Structure**: Grades K-12, academic years, terms, subjects, classes
- **People**: Teachers, students with comprehensive demographics
- **Academics**: Enrollments, assignments, submissions, grades, attendance
- **Activities**: School events, library books, transportation, disciplinary records
- **Edge Cases**: Inactive records, transfers, special needs, behavior issues

### College Database (`college_db`)
- **Institutional Structure**: Multiple campuses, colleges, departments
- **Academic Programs**: Undergraduate, graduate, and online degree programs
- **People**: Faculty with ranks, students with diverse backgrounds
- **Academics**: Courses, sections, enrollments, assignments, research projects
- **Services**: Housing, library resources, campus events
- **Advanced Features**: Thesis tracking, academic standings, financial aid

### Cross-Database Integration
- **Student Transfers**: K-12 graduates entering university
- **Dual Enrollment**: High school students taking college courses
- **Shared Faculty**: Professors teaching at both levels
- **Curriculum Alignment**: Course equivalencies and prerequisites
- **Shared Resources**: Libraries, labs, transportation, facilities
- **Financial Aid**: Cross-institutional scholarships and grants

## Quick Start

### Prerequisites
- MySQL 5.7+ or MariaDB 10.2+
- MySQL client tools
- Bash shell (for setup script)

### Setup Instructions

1. **Clone or download** the repository
2. **Navigate** to the database directory:
   ```bash
   cd Backend/database
   ```
3. **Make the setup script executable**:
   ```bash
   chmod +x scripts/setup_database_warehouse.sh
   ```
4. **Run the setup script**:
   ```bash
   ./scripts/setup_database_warehouse.sh
   ```
5. **Follow the prompts** to configure your MySQL connection

The script will create both databases and populate them with comprehensive sample data.

## Directory Structure

```
Backend/database/
├── schema/
│   ├── 01_school_database.sql         # School database schema
│   ├── 02_college_database.sql        # College database schema
│   └── 03_cross_database_linking.sql  # Cross-database relationships
├── data/
│   ├── 01_school_sample_data.sql      # School sample data (part 1)
│   ├── 02_school_sample_data_part2.sql # School sample data (part 2)
│   ├── 03_college_sample_data.sql     # College sample data (part 1)
│   ├── 04_college_sample_data_part2.sql # College sample data (part 2)
│   ├── 05_college_sample_data_part3.sql # College sample data (part 3)
│   └── 06_cross_database_sample_data.sql # Cross-database linking data
├── scripts/
│   └── setup_database_warehouse.sh   # Automated setup script
└── README.md                         # This file
```

## Sample Data Highlights

### Realistic Student Journeys
- **Emma Johnson**: Progresses from Mountain View High School to Excellence University
- **Grace Scott**: High school student in dual enrollment program
- **Harper Martin**: Honor student with early college admission
- **Aiden Green**: Student requiring academic support services

### Edge Cases and Testing Scenarios
- Students with special needs and accommodations
- Transfer students mid-semester
- Graduated and withdrawn students
- Faculty on leave or emeritus status
- Courses with low enrollment or waitlists
- Late submissions with penalties
- Group assignments and collaborations
- Research participation and assistantships

### SQL Testing Features
- **NULL values** in optional fields
- **Complex foreign key relationships**
- **Constraint violations** (controlled examples)
- **Date range validations**
- **Enum value testing**
- **JSON field examples**
- **Trigger-worthy scenarios**
- **Performance testing data volumes**

## Common Queries

### Student Progression Tracking
```sql
-- Students who transferred from school to college
SELECT 
    st.school_student_number,
    CONCAT(cs.first_name, ' ', cs.last_name) AS student_name,
    st.previous_graduation_date,
    cs.admission_date,
    dp.program_name
FROM college_db.student_transfers st
JOIN college_db.students cs ON st.college_student_id = cs.student_id
JOIN college_db.degree_programs dp ON cs.program_id = dp.program_id;
```

### Academic Performance Analysis
```sql
-- GPA distribution across programs
SELECT 
    dp.program_name,
    dp.degree_type,
    COUNT(s.student_id) as student_count,
    AVG(s.gpa) as avg_gpa,
    MIN(s.gpa) as min_gpa,
    MAX(s.gpa) as max_gpa
FROM college_db.students s
JOIN college_db.degree_programs dp ON s.program_id = dp.program_id
WHERE s.graduation_status = 'enrolled'
GROUP BY dp.program_id
ORDER BY avg_gpa DESC;
```

### Cross-Database Faculty Analysis
```sql
-- Faculty working at both institutions
SELECT 
    CONCAT(f.first_name, ' ', f.last_name) AS faculty_name,
    f.academic_rank,
    d.department_name,
    cif.employment_percentage_school,
    cif.employment_percentage_college,
    cif.shared_responsibilities
FROM college_db.cross_institution_faculty cif
JOIN college_db.faculty f ON cif.college_faculty_id = f.faculty_id
JOIN college_db.departments d ON f.department_id = d.department_id
WHERE cif.is_active = TRUE;
```

### Resource Utilization
```sql
-- Shared resource usage statistics
SELECT 
    sr.resource_name,
    sr.resource_type,
    COUNT(sru.usage_id) as total_uses,
    AVG(sru.satisfaction_rating) as avg_satisfaction,
    COUNT(CASE WHEN sru.user_institution = 'school' THEN 1 END) as school_uses,
    COUNT(CASE WHEN sru.user_institution = 'college' THEN 1 END) as college_uses
FROM college_db.shared_resources sr
LEFT JOIN college_db.shared_resource_usage sru ON sr.resource_id = sru.resource_id
GROUP BY sr.resource_id
ORDER BY total_uses DESC;
```

## Database Schema Highlights

### School Database Key Tables
- `students` (20 records) - K-12 students with demographics
- `teachers` (20 records) - Faculty and staff
- `classes` (32 records) - Class sections and schedules
- `enrollments` (35 records) - Student class enrollments
- `assignments` (15 records) - Homework, tests, projects
- `attendance` (33 records) - Daily attendance tracking
- `library_books` (14 records) - Library collection
- `school_events` (8 records) - Activities and events

### College Database Key Tables
- `students` (20 records) - University students
- `faculty` (13 records) - Professors and instructors
- `courses` (42 records) - Course catalog
- `course_sections` (46 records) - Specific class sections
- `enrollments` (49 records) - Student course enrollments
- `assignments` (23 records) - Course assignments
- `research_projects` (3 records) - Faculty research
- `housing_assignments` (10 records) - Student housing

### Cross-Database Tables
- `student_transfers` (4 records) - School to college transitions
- `dual_enrollment` (2 records) - High school students in college
- `cross_institution_faculty` (3 records) - Shared staff
- `curriculum_alignment` (6 records) - Course equivalencies
- `shared_resources` (5 records) - Common facilities

## Use Cases

This database warehouse is ideal for:

1. **Software Testing**
   - Testing educational management systems
   - Validating data migration tools
   - Performance testing with realistic data

2. **Learning and Training**
   - SQL query practice
   - Database design education
   - Report development training

3. **Development and Prototyping**
   - Building educational applications
   - Creating analytics dashboards
   - Testing integration scenarios

4. **Data Analysis**
   - Student success research
   - Institutional effectiveness studies
   - Resource utilization analysis

## Edge Cases Included

The sample data includes various edge cases for comprehensive testing:

- **Academic**: Students with learning disabilities, honor students, failing students
- **Scheduling**: Class conflicts, waitlists, cancelled courses
- **Transfers**: Mid-semester withdrawals, dual enrollment complications
- **Financial**: Overdue payments, scholarships, work-study programs
- **Behavioral**: Disciplinary issues, attendance problems
- **Technical**: NULL values, constraint boundaries, date edge cases

## Maintenance

To reset the databases:
```bash
mysql -u root -p -e "DROP DATABASE IF EXISTS school_db; DROP DATABASE IF EXISTS college_db;"
./scripts/setup_database_warehouse.sh
```

To update sample data, modify the appropriate files in the `data/` directory and re-run the setup script.

## Contributing

When adding new sample data:
1. Maintain realistic relationships between records
2. Include both typical and edge case scenarios
3. Follow naming conventions for consistency
4. Document any new edge cases in this README

## Support

For issues or questions about the database warehouse:
1. Check that MySQL is properly configured
2. Verify all SQL files are present and readable
3. Ensure proper permissions for database creation
4. Review error messages in the setup script output

---

**Created for Educational and Testing Purposes**

This database warehouse provides a rich, realistic dataset for testing, learning, and development in educational technology environments.