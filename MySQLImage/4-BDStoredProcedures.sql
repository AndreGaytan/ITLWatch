USE ITLWatch;
/*-------------STORED PROCEDURES--------------*/    
Delimiter ??
CREATE PROCEDURE createUser(IN uname varchar(20), IN pwd varchar(50), IN eml varchar(35), IN nmb varchar(20), IN apll varchar(20), IN p varchar(20), IN fNac date)
	BEGIN 
		DECLARE newUserID int;
		INSERT INTO USERS(UserName, Pass, Email) VALUES (uname, encryptPwd(pwd), eml);
        SET newUserID = (SELECT max(UserID) FROM USERS);
        INSERT INTO MEMBERS (Nombre, Apellido, Pais, FechaNac, FechaRegistro, UserID) VALUES (nmb, apll, p, fNac, now(), newUserID);
	END
??

CREATE PROCEDURE readUser(IN id int)
	BEGIN
		SELECT * 
        FROM MEMBER_INFO
        WHERE UserID=id;
    END
??

CREATE PROCEDURE readAllUsers()
	BEGIN
		SELECT *
        FROM USERS;
    END
??

CREATE PROCEDURE updatePassword(IN oldPwd varchar(50), IN newPwd varchar(50), IN id int, OUT executed boolean)
	BEGIN
		IF confirmIdentity(id, oldPwd) THEN
			UPDATE USERS 
			SET Pass = encryptPwd(newPwd)
			WHERE UserID = id;	
            SET executed = true;
		ELSE 
			SET executed = false;
        END IF;
    END
??

CREATE PROCEDURE updateMember(IN nmb varchar(20), IN apll varchar(20), IN p varchar(20), IN fNac date, IN id int)
	BEGIN
		UPDATE MEMBERS
        SET Nombre = nmb,
			Apellido = apll,
            Pais = p,
            FechaNac = fNac
		WHERE UserID = id;
    END 
??

CREATE PROCEDURE deleteUser(IN id int, IN pwd varchar(50), OUT executed boolean)
    BEGIN        
		IF confirmIdentity(id, oldPwd) THEN
			DELETE FROM USERS Where UserID= id;
            SET executed = true;
		ELSE 
            SET executed = false;
        END IF;
    END
??

/****************************************************/
CREATE PROCEDURE createVideo(IN videoCode varchar(100), IN tit varchar(80), IN des mediumtext, IN id int)
	BEGIN
		INSERT INTO VIDEOS(URL, Titulo, Descripcion, UserID) VALUES (generateURL(videoCode), tit, des, id);
    END
??

CREATE PROCEDURE readAllVideos()
	BEGIN
		SELECT *
        FROM VIDEO_INFO;
    END
??

CREATE PROCEDURE readMyVideos(IN id int)
	BEGIN
		SELECT *
        FROM VIDEO_INFO 
        WHERE UserID = id;
    END
??    

CREATE PROCEDURE readVideo(IN id int)
	BEGIN 
		SELECT *
        FROM VIDEO_INFO
        WHERE VideoID = id;
	END
??


CREATE PROCEDURE updateVideo(IN tit varchar(80), IN des mediumtext, IN id int)
	BEGIN
		UPDATE VIDEOS
        SET Titulo = tit,
			Descripcion = des
		WHERE VideoID = id;
    END
??    

CREATE PROCEDURE deleteVideo(IN id int)
	BEGIN
		DELETE FROM VIDEOS
        WHERE VideoID = id;
    END
??
/****************************************************/
CREATE PROCEDURE createComment(IN com text, IN vid int, IN uid int)
	BEGIN
		INSERT INTO COMMENTS(FechaPub, Comentario, VideoID, UserID) VALUES (now(), com, vid, uid);
    END
??

CREATE PROCEDURE readComment(IN id int)
	BEGIN
		SELECT *
        FROM COMMENT_INFO
        WHERE CommentID = id;
    END
??    

CREATE PROCEDURE readVideoComments(IN id int)
	BEGIN
		SELECT *
        FROM COMMENT_INFO
        WHERE VideoID = id;
    END
??    

CREATE PROCEDURE updateComment(IN comentario text, IN id int)
	BEGIN
		UPDATE COMMENTS
        SET Comentario = comentario
        WHERE CommentID = id;
    END
??    

CREATE PROCEDURE deleteComment(IN id int)
	BEGIN
		DELETE FROM COMMENTS
        WHERE CommentID = id;
    END
??
/****************************************************/