#!/bin/bash

# Database Warehouse Setup Script
# This script creates and populates the school and college databases with sample data

set -e  # Exit on any error

echo "=========================================="
echo "Database Warehouse Setup for Testing"
echo "School and College Management System"
echo "=========================================="

# Configuration
MYSQL_USER=${MYSQL_USER:-root}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-password}
MYSQL_HOST=${MYSQL_HOST:-localhost}
MYSQL_PORT=${MYSQL_PORT:-3306}

# Database names
SCHOOL_DB="school_db"
COLLEGE_DB="college_db"

# Check if MySQL is available
if ! command -v mysql &> /dev/null; then
    echo "Error: MySQL client not found. Please install MySQL client."
    exit 1
fi

# Function to execute SQL file
execute_sql_file() {
    local file=$1
    local database=$2
    echo "Executing: $file"
    
    if [ -n "$database" ]; then
        mysql -h"$MYSQL_HOST" -P"$MYSQL_PORT" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$database" < "$file"
    else
        mysql -h"$MYSQL_HOST" -P"$MYSQL_PORT" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" < "$file"
    fi
    
    if [ $? -eq 0 ]; then
        echo "✓ Successfully executed: $file"
    else
        echo "✗ Failed to execute: $file"
        exit 1
    fi
}

# Function to check if database exists
database_exists() {
    local db_name=$1
    mysql -h"$MYSQL_HOST" -P"$MYSQL_PORT" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "USE $db_name;" 2>/dev/null
    return $?
}

echo ""
echo "Step 1: Creating Database Schemas"
echo "-----------------------------------"

# Create school database schema
echo "Creating school database schema..."
execute_sql_file "schema/01_school_database.sql"

# Create college database schema
echo "Creating college database schema..."
execute_sql_file "schema/02_college_database.sql"

# Create cross-database linking structures
echo "Creating cross-database linking structures..."
execute_sql_file "schema/03_cross_database_linking.sql"

echo ""
echo "Step 2: Populating Sample Data"
echo "-------------------------------"

# Populate school database
echo "Populating school database with sample data..."
execute_sql_file "data/01_school_sample_data.sql"
execute_sql_file "data/02_school_sample_data_part2.sql"

# Populate college database
echo "Populating college database with sample data..."
execute_sql_file "data/03_college_sample_data.sql"
execute_sql_file "data/04_college_sample_data_part2.sql"
execute_sql_file "data/05_college_sample_data_part3.sql"

# Populate cross-database linking data
echo "Populating cross-database linking data..."
execute_sql_file "data/06_cross_database_sample_data.sql"

echo ""
echo "Step 3: Verification"
echo "--------------------"

# Verify databases were created
if database_exists "$SCHOOL_DB"; then
    echo "✓ School database created successfully"
else
    echo "✗ School database creation failed"
    exit 1
fi

if database_exists "$COLLEGE_DB"; then
    echo "✓ College database created successfully"
else
    echo "✗ College database creation failed"
    exit 1
fi

# Get table counts
echo ""
echo "Database Statistics:"
echo "-------------------"

SCHOOL_TABLES=$(mysql -h"$MYSQL_HOST" -P"$MYSQL_PORT" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = '$SCHOOL_DB';" -s -N)
COLLEGE_TABLES=$(mysql -h"$MYSQL_HOST" -P"$MYSQL_PORT" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = '$COLLEGE_DB';" -s -N)

echo "School Database Tables: $SCHOOL_TABLES"
echo "College Database Tables: $COLLEGE_TABLES"

# Get sample record counts
echo ""
echo "Sample Record Counts:"
echo "--------------------"

SCHOOL_STUDENTS=$(mysql -h"$MYSQL_HOST" -P"$MYSQL_PORT" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SELECT COUNT(*) FROM $SCHOOL_DB.students;" -s -N)
COLLEGE_STUDENTS=$(mysql -h"$MYSQL_HOST" -P"$MYSQL_PORT" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SELECT COUNT(*) FROM $COLLEGE_DB.students;" -s -N)
SCHOOL_TEACHERS=$(mysql -h"$MYSQL_HOST" -P"$MYSQL_PORT" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SELECT COUNT(*) FROM $SCHOOL_DB.teachers;" -s -N)
COLLEGE_FACULTY=$(mysql -h"$MYSQL_HOST" -P"$MYSQL_PORT" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SELECT COUNT(*) FROM $COLLEGE_DB.faculty;" -s -N)
TRANSFERS=$(mysql -h"$MYSQL_HOST" -P"$MYSQL_PORT" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SELECT COUNT(*) FROM $COLLEGE_DB.student_transfers;" -s -N)

echo "School Students: $SCHOOL_STUDENTS"
echo "College Students: $COLLEGE_STUDENTS"
echo "School Teachers: $SCHOOL_TEACHERS"
echo "College Faculty: $COLLEGE_FACULTY"
echo "Student Transfers: $TRANSFERS"

echo ""
echo "=========================================="
echo "✓ Database Warehouse Setup Complete!"
echo "=========================================="
echo ""
echo "The following databases have been created:"
echo "• $SCHOOL_DB - K-12 school management system"
echo "• $COLLEGE_DB - University management system"
echo ""
echo "Features included:"
echo "• Comprehensive schemas with relationships"
echo "• Sample data with edge cases"
echo "• Cross-database linking for transfers"
echo "• Student progression tracking"
echo "• Shared resources and faculty"
echo "• Complex enrollment scenarios"
echo ""
echo "You can now use these databases for:"
echo "• Testing SQL queries and edge cases"
echo "• Developing educational software"
echo "• Learning database design patterns"
echo "• Testing reporting and analytics"
echo ""
echo "See README.md for usage examples and query samples."
echo ""