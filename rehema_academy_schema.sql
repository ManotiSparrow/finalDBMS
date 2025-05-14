-- Create the database
CREATE DATABASE IF NOT EXISTS rehema_academy;
USE rehema_academy;

-- Create table for class teachers
CREATE TABLE teachers (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    gender ENUM('Male', 'Female') NOT NULL,
    phone_number VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE,
    date_employed DATE NOT NULL,
    CHECK (phone_number LIKE '+2547%' AND LENGTH(phone_number) = 13)
);

-- Create table for classes
CREATE TABLE classes (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    class_level INT NOT NULL UNIQUE CHECK (class_level BETWEEN 1 AND 8),
    class_name VARCHAR(20) NOT NULL UNIQUE,
    class_teacher_id INT NOT NULL UNIQUE,
    classroom_location VARCHAR(20) NOT NULL,
    FOREIGN KEY (class_teacher_id) REFERENCES teachers(teacher_id)
);

-- Create table for parents/guardians
CREATE TABLE parents (
    parent_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    gender ENUM('Male', 'Female') NOT NULL,
    phone_number VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(100),
    address VARCHAR(200),
    relationship_to_student VARCHAR(30) NOT NULL,
    CHECK (phone_number LIKE '+2547%' AND LENGTH(phone_number) = 13)
);

-- Create table for students
CREATE TABLE students (
    admission_number VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    gender ENUM('Male', 'Female') NOT NULL,
    date_of_birth DATE NOT NULL,
    date_admitted DATE NOT NULL,
    class_id INT NOT NULL,
    parent_id INT NOT NULL,
    medical_notes TEXT,
    FOREIGN KEY (class_id) REFERENCES classes(class_id),
    FOREIGN KEY (parent_id) REFERENCES parents(parent_id)
);

-- Create table for subjects
CREATE TABLE subjects (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(50) NOT NULL UNIQUE,
    subject_code VARCHAR(10) NOT NULL UNIQUE,
    description TEXT
);

-- Create junction table for teachers and subjects (M-M relationship)
CREATE TABLE teacher_subjects (
    teacher_id INT NOT NULL,
    subject_id INT NOT NULL,
    PRIMARY KEY (teacher_id, subject_id),
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

-- Create table for academic performance
CREATE TABLE performance (
    performance_id INT AUTO_INCREMENT PRIMARY KEY,
    admission_number VARCHAR(10) NOT NULL,
    subject_id INT NOT NULL,
    term ENUM('1', '2', '3') NOT NULL,
    year YEAR NOT NULL,
    marks DECIMAL(5,2) NOT NULL CHECK (marks BETWEEN 0 AND 100),
    grade CHAR(2) NOT NULL,
    remarks TEXT,
    FOREIGN KEY (admission_number) REFERENCES students(admission_number),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id),
    UNIQUE KEY (admission_number, subject_id, term, year)
);


-- Create table for school events
CREATE TABLE events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(100) NOT NULL,
    event_date DATE NOT NULL,
    description TEXT,
    organizer VARCHAR(100),
    location VARCHAR(100)
);

