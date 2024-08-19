CREATE TABLE Department (
    ID SERIAL PRIMARY KEY,
    Dept_Name VARCHAR(255) NOT NULL,
    Location VARCHAR(255)
);


CREATE TABLE Students (
    Student_ID SERIAL PRIMARY KEY,
    Level VARCHAR(50),
    Term VARCHAR(50),
    Department_ID INT REFERENCES Department(ID) ON DELETE SET NULL 
);


CREATE TABLE Teachers (
    Teacher_ID SERIAL PRIMARY KEY,
    Department_ID INT REFERENCES Department(ID) ON DELETE SET NULL,
    Designation VARCHAR(255)
);


CREATE TABLE Course (
    ID SERIAL PRIMARY KEY,
    Course_Name VARCHAR(255) NOT NULL,
    Session VARCHAR(50),
    Type VARCHAR(50),
    Start DATE,
    Endi DATE,
    Course_Description TEXT,
    Department_ID INT REFERENCES Department(ID) ON DELETE SET NULL
);


CREATE TABLE Assignment (
    ID SERIAL PRIMARY KEY,
    Assignment_Name VARCHAR(255),
    Type VARCHAR(50),
    Points INT,
    Bonus_Points INT,
    Start_Time TIMESTAMP,
    End_Time TIMESTAMP,
    Course_ID INT REFERENCES Course(ID) ON DELETE SET NULL, 
    Evaluation_Teacher_ID INT REFERENCES Teachers(Teacher_ID) ON DELETE SET NULL 
);

CREATE TABLE Course_Content (
    ID SERIAL PRIMARY KEY,
    Content_Name VARCHAR(255),
    Content_Type VARCHAR(50),
    Upload_Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Assignment_ID INT REFERENCES Assignment(ID) ON DELETE SET NULL, 
    Teacher_ID INT REFERENCES Teachers(Teacher_ID) ON DELETE SET NULL 
);


CREATE TABLE Assignment_Log (
    ID SERIAL PRIMARY KEY,
    Log_Type VARCHAR(50),
    Description TEXT,
    Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Assignment_ID INT REFERENCES Assignment(ID) ON DELETE SET NULL, 
    Content_ID INT REFERENCES Course_Content(ID) ON DELETE SET NULL, 
    Teacher_ID INT REFERENCES Teachers(Teacher_ID) ON DELETE SET NULL 
);


CREATE TABLE Enrolls (
    Student_ID INT REFERENCES Students(Student_ID) ON DELETE SET NULL,
    Course_ID INT REFERENCES Course(ID) ON DELETE SET NULL,
    PRIMARY KEY (Student_ID, Course_ID)
);


CREATE TABLE Teaches (
    Teacher_ID INT REFERENCES Teachers(Teacher_ID) ON DELETE SET NULL,
    Course_ID INT REFERENCES Course(ID) ON DELETE SET NULL,
    PRIMARY KEY (Teacher_ID, Course_ID)
);

CREATE TABLE Discussions (
    ID SERIAL PRIMARY KEY,
    Topic VARCHAR(255),
    Text TEXT,
    Assignment_ID INT UNIQUE REFERENCES Assignment(ID) ON DELETE SET NULL 
);

CREATE TABLE Comments (
    ID SERIAL PRIMARY KEY,
    Discussion_ID INT REFERENCES Discussions(ID) ON DELETE SET NULL,
    Parent_Comment_ID INT REFERENCES Comments(ID) ON DELETE SET NULL,
    Text TEXT,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Submits (
    ID SERIAL PRIMARY KEY,
    Student_ID INT REFERENCES Students(Student_ID) ON DELETE SET NULL,
    Assignment_ID INT REFERENCES Assignment(ID) ON DELETE SET NULL,
    Submission_Date TIMESTAMP,
    Submission_Time TIME,
    Content_ID INT REFERENCES Course_Content(ID) ON DELETE SET NULL 
);

CREATE TABLE Users (
    User_ID SERIAL PRIMARY KEY,
    First_Name VARCHAR(255),
    Last_Name VARCHAR(255),
    UserType VARCHAR(50),
    Email VARCHAR(255) UNIQUE,
    Phone_No VARCHAR(20)
);

CREATE TABLE Message (
    ID SERIAL PRIMARY KEY,
    Topic VARCHAR(255),
    Content TEXT,
    Send_Time TIMESTAMP,
    Receive_Time TIMESTAMP
);

CREATE TABLE User_Message (
    Message_ID INT REFERENCES Message(ID) ON DELETE SET NULL,
    Sender_ID INT REFERENCES Users(User_ID) ON DELETE SET NULL,
    Receiver_ID INT REFERENCES Users(User_ID) ON DELETE SET NULL,
    PRIMARY KEY (Message_ID, Sender_ID, Receiver_ID)
);

CREATE TABLE Notifications (
    ID SERIAL PRIMARY KEY,
    User_ID INT REFERENCES Users(User_ID) ON DELETE SET NULL,
    Message TEXT NOT NULL,
    Related_Record_ID INT,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
