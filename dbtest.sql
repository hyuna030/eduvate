CREATE DATABASE IF NOT EXISTS edb;

 USE edb;



CREATE TABLE IF NOT EXISTS User (
  UserID VARCHAR(255) PRIMARY KEY,
  Username VARCHAR(255) UNIQUE,
  Password VARCHAR(255)
);

-- StudyLog 엔터티
CREATE TABLE IF NOT EXISTS StudyLog (
LogID INT AUTO_INCREMENT PRIMARY KEY,
  UserID VARCHAR(255),
  StudyDate DATE,
  StudyDuration INT,
  Topic VARCHAR(255),
  FOREIGN KEY (UserID) REFERENCES User(UserID)
);


-- StudyGroup 엔터티
-- StudyGroup 엔터티
CREATE TABLE IF NOT EXISTS StudyGroup (
  GroupID INT AUTO_INCREMENT PRIMARY KEY,
  GroupName VARCHAR(255),
  Description TEXT,
  UserID VARCHAR(255), -- 추가: 그룹에 가입한 사용자의 ID
  FOREIGN KEY (UserID) REFERENCES User(UserID)
);


-- GroupStudyLog 엔터티
CREATE TABLE IF NOT EXISTS GroupStudyLog (
  GroupLogID INT AUTO_INCREMENT PRIMARY KEY,
  GroupID INT,
  UserID VARCHAR(255), -- 변경: 글을 쓴 사용자의 ID
  GroupStudyDate DATE,
  GroupStudyDuration INT,
  GroupTopic VARCHAR(255),
  FOREIGN KEY (GroupID) REFERENCES StudyGroup(GroupID),
  FOREIGN KEY (UserID) REFERENCES User(UserID)
);

CREATE TABLE GroupMembers (
    GroupID INT NOT NULL,
    UserID VARCHAR(50) NOT NULL,
    PRIMARY KEY (GroupID, UserID),
    FOREIGN KEY (GroupID) REFERENCES StudyGroup(GroupID),
    FOREIGN KEY (UserID) REFERENCES User(userID)
);



 

