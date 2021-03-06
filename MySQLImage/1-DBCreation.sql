CREATE DATABASE ITLWatch;
USE ITLWatch;

/*-------------USER VARIABLES--------------*/
SET @AESPWD:='ITLWatchAESDecrypt';

/*-------------TABLES--------------*/
CREATE TABLE USERS(
	UserID int UNSIGNED NOT NULL,
    UserName varchar(20) NOT NULL UNIQUE,
    Pass BLOB NOT NULL,
    Email varchar(35) NOT NULL UNIQUE
);

CREATE TABLE MEMBERS(
    Nombre varchar(20) NOT NULL UNIQUE,
    Apellido varchar(20) NOT NULL,
    Pais varchar(20) NULL,
    FechaNac date NOT NULL,
    FechaRegistro timestamp NOT NULL,
    UserID int NOT NULL
);

CREATE TABLE COMMENTS(
	CommentID int UNSIGNED NOT NULL,
    FechaPub timestamp NOT NULL,
    Comentario text NOT NULL,
    UserID int NOT NULL,
    VideoID int NOT NULL
);

CREATE TABLE VIDEOS(
	VideoID int UNSIGNED NOT NULL,
    URL varchar(500) NOT NULL UNIQUE,
    Titulo varchar(80) NULL,
    Descripcion mediumtext NULL,
    UserID int NOT NULL
);

CREATE TABLE LOGS_BINNACLE(
	LogID int UNSIGNED NOT NULL,
    TableColID int NOT NULL,
    TableName varchar(20) NOT NULL,
    SystemAction enum('INSERT','UPDATE','DELETE') NOT NULL,
    LogDate timestamp NOT NULL
);
/*----------PRIMARY KEYS CONNSTRAINTS------*/
ALTER TABLE USERS
ADD CONSTRAINT USERS_PK PRIMARY KEY (UserID),
MODIFY UserID int AUTO_INCREMENT;

ALTER TABLE MEMBERS
ADD CONSTRAINT MEMBERS_PK PRIMARY KEY (UserID);

ALTER TABLE COMMENTS
ADD CONSTRAINT COMMENTS_PK PRIMARY KEY (CommentID),
MODIFY CommentID int AUTO_INCREMENT;

ALTER TABLE VIDEOS
ADD CONSTRAINT VIDEOS_PK PRIMARY KEY (VideoID),
MODIFY VideoID int AUTO_INCREMENT;

ALTER TABLE LOGS_BINNACLE
ADD CONSTRAINT LBINNACLE_PK PRIMARY KEY (LogID),
MODIFY LogID int AUTO_INCREMENT;

/*----------FOREIGN KEYS CONNSTRAINTS------*/
ALTER TABLE MEMBERS
ADD CONSTRAINT MEMBERS_USERS_FK FOREIGN KEY (UserID) REFERENCES USERS(UserID)
	ON DELETE CASCADE;

ALTER TABLE COMMENTS
ADD CONSTRAINT COMMENTS_USERS_FK FOREIGN KEY (UserID) REFERENCES USERS(UserID)
    ON DELETE CASCADE,
ADD CONSTRAINT COMMENTS_VIDEO_FK FOREIGN KEY (VideoID) REFERENCES VIDEOS(VideoID)
    ON DELETE CASCADE;

ALTER TABLE VIDEOS 
ADD CONSTRAINT VIDEOS_USERS_FK FOREIGN KEY (UserID) REFERENCES USERS(UserID)
    ON DELETE CASCADE;

/*-------------TRIGGERS--------------*/
/*USERS*/
CREATE TRIGGER log_user_insert AFTER INSERT ON USERS
	FOR EACH ROW 
    INSERT INTO LOGS_BINNACLE (TableColID, TableName, SystemAction, LogDate) VALUES (NEW.UserID, 'USERS', 'INSERT', current_timestamp());

CREATE TRIGGER log_login_update AFTER UPDATE ON USERS
	FOR EACH ROW 
    INSERT INTO LOGS_BINNACLE (TableColID, TableName, SystemAction, LogDate) VALUES (NEW.UserID, 'USERS', 'UPDATE', current_timestamp());
    
CREATE TRIGGER log_users_update AFTER UPDATE ON MEMBERS
	FOR EACH ROW 
    INSERT INTO LOGS_BINNACLE (TableColID, TableName, SystemAction, LogDate) VALUES (NEW.UserID, 'MEMBERS', 'UPDATE', current_timestamp());

CREATE TRIGGER log_user_delete BEFORE DELETE ON USERS
	FOR EACH ROW 
		INSERT INTO LOGS_BINNACLE (TableColID, TableName, SystemAction, LogDate) VALUES (OLD.UserID, 'USERS', 'DELETE', current_timestamp());

/*COMMENTS*/
CREATE TRIGGER log_comment_insert AFTER INSERT ON COMMENTS
	FOR EACH ROW 
    INSERT INTO LOGS_BINNACLE (TableColID, TableName, SystemAction, LogDate) VALUES (NEW.CommentID, 'COMMENTS', 'INSERT', current_timestamp());

/*VIDEOS*/
CREATE TRIGGER log_video_insert AFTER INSERT ON VIDEOS
	FOR EACH ROW 
    INSERT INTO LOGS_BINNACLE (TableColID, TableName, SystemAction, LogDate) VALUES (NEW.VideoID, 'VIDEOS', 'INSERT', current_timestamp());
    
CREATE TRIGGER log_video_update AFTER UPDATE ON VIDEOS
	FOR EACH ROW 
    INSERT INTO LOGS_BINNACLE (TableColID, TableName, SystemAction, LogDate) VALUES (NEW.VideoID, 'VIDEOS', 'UPDATE', current_timestamp());

CREATE TRIGGER log_video_delete BEFORE DELETE ON VIDEOS
	FOR EACH ROW 
    INSERT INTO LOGS_BINNACLE (TableColID, TableName, SystemAction, LogDate) VALUES (OLD.VideoID, 'VIDEOS', 'DELETE', current_timestamp());
