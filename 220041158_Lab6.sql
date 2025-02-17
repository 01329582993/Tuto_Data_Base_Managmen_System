--1 erd diagram 


--2 
CREATE TABLE ResearchGroup (
    GroupID INT PRIMARY KEY,
    Name VARCHAR(50) UNIQUE NOT NULL,
    Lab VARCHAR(50),
    Budget DECIMAL(10, 2)
);



CREATE TABLE FacultyMember (
    FacultyID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    ContactNumber VARCHAR(15),
    ResearchLab INT,
    FOREIGN KEY (ResearchLab) REFERENCES ResearchGroup(GroupID)
);




CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    ContactNumber VARCHAR(15),
    ResearchLab INT,
    SupervisorID INT,
    FOREIGN KEY (ResearchLab) REFERENCES ResearchGroup(GroupID),
    FOREIGN KEY (SupervisorID) REFERENCES FacultyMember(FacultyID)
);


CREATE TABLE Project (
    ProjectID INT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    StartDate DATE,
    EndDate DATE,
    ResearchArea VARCHAR(50),
    SupervisorID INT,
    FOREIGN KEY (SupervisorID) REFERENCES FacultyMember(FacultyID)
);




CREATE TABLE Publication (
    PublicationID INT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    ConferenceName VARCHAR(50),
    PublicationDate DATE,
    ResearchDomain VARCHAR(50),
    Summary VARCHAR(1000),
    StudentID INT,
    FacultyID INT,
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (FacultyID) REFERENCES FacultyMember(FacultyID)
);





--3

DROP TABLE Publication;
DROP TABLE Project;
DROP TABLE Student;
DROP TABLE FacultyMember;
DROP TABLE ResearchGroup;
