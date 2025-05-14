-- Create the database

USE student_records_db;

-- Table: Departments
CREATE TABLE Departments (
    departmentID INT AUTO_INCREMENT PRIMARY KEY,
    departmentName VARCHAR(100) NOT NULL UNIQUE
);

-- Table: Students
CREATE TABLE Students (
    studentID INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    dateOfBirth DATE,
    gender ENUM('Male', 'Female', 'Other'),
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    departmentID INT,
    FOREIGN KEY (departmentID) REFERENCES Departments(departmentID)
);

-- Table: Courses
CREATE TABLE Courses (
    courseID INT AUTO_INCREMENT PRIMARY KEY,
    courseName VARCHAR(100) NOT NULL,
    courseCode VARCHAR(10) NOT NULL UNIQUE,
    credits INT NOT NULL CHECK (credits BETWEEN 1 AND 6),
    departmentID INT,
    FOREIGN KEY (departmentID) REFERENCES Departments(departmentID)
);

-- Table: Instructors
CREATE TABLE Instructors (
    instructorID INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    departmentID INT,
    FOREIGN KEY (departmentID) REFERENCES Departments(departmentID)
);

-- Table: Enrollments (M-M relationship between Students and Courses)
CREATE TABLE Enrollments (
    enrollmentID INT AUTO_INCREMENT PRIMARY KEY,
    studentID INT NOT NULL,
    courseID INT NOT NULL,
    enrollmentDate DATE NOT NULL,
    grade CHAR(2),
    UNIQUE(studentID, courseID), -- Prevent duplicate enrollments
    FOREIGN KEY (studentID) REFERENCES Students(studentID),
    FOREIGN KEY (courseID) REFERENCES Courses(courseID)
);

-- Table: CourseAssignments (M-M between Courses and Instructors)
CREATE TABLE CourseAssignments (
    assignmentID INT AUTO_INCREMENT PRIMARY KEY,
    courseID INT NOT NULL,
    instructorID INT NOT NULL,
    semester VARCHAR(20) NOT NULL,
    year YEAR NOT NULL,
    UNIQUE(courseID, instructorID, semester, year),
    FOREIGN KEY (courseID) REFERENCES Courses(courseID),
    FOREIGN KEY (instructorID) REFERENCES Instructors(instructorID)
);
