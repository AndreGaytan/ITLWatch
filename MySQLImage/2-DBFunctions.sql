USE ITLWatch;
/*----------FUNCTIONS------*/
Delimiter ??
CREATE FUNCTION getAntiquity(fechaReg timestamp)
	RETURNS	varchar(20)
	READS SQL DATA
    BEGIN
		DECLARE antiguedad varchar(20);
        DECLARE tiempo int;
		SET tiempo = timestampdiff(DAY, fechaReg, now());
        IF tiempo <= 31 THEN
            IF tiempo <= 1 THEN
				SET antiguedad = concat(tiempo, ' dia');
			ELSE 
				SET antiguedad = concat(tiempo, ' dias');
			END IF;
        ELSEIF tiempo <365 THEN
			SET tiempo = timestampdiff(MONTH, fechaReg, now());
            IF tiempo <= 1 THEN
				SET antiguedad = concat(tiempo, ' mes');
			ELSE 
				SET antiguedad = concat(tiempo, ' meses');
			END IF;
        ELSE 
			SET tiempo = timestampdiff(YEAR, fechaReg, now());
            IF tiempo <= 1 THEN
				SET antiguedad = concat(tiempo, ' año');
			ELSE 
				SET antiguedad = concat(tiempo, ' años');
			END IF;
        END IF;
        RETURN antiguedad;
    END
??

/*CREATE FUNCTION generateURL(uid int)
	RETURNS varchar(500)
    READS SQL DATA
    BEGIN
		DECLARE vid int;
		SET vid = (SELECT (max(VideoID) + 1) FROM VIDEOS);
    RETURN concat((curDate()+0), uid, vid);
    END
??*/

CREATE FUNCTION generateURL(codeVideo varchar(100))
	RETURNS varchar(500)
    NO SQL
	RETURN concat('https://www.youtube.com/embed/', codeVideo);
??

CREATE FUNCTION logIn(uname varchar(50), pwd varchar(50))
	RETURNS boolean
	READS SQL DATA
    BEGIN        
        IF (SELECT if (uname LIKE '%@%', true, false)) THEN
			RETURN (SELECT count(UserID) FROM USERS WHERE Email = uname AND aes_decrypt(Pass, concat(pwd, @AESPWD)) = pwd)=1;
		ELSE 
			RETURN (SELECT count(UserID) FROM USERS WHERE Username = uname AND aes_decrypt(Pass, concat(pwd, @AESPWD)) = pwd)=1;
        END IF;
    END
??

CREATE FUNCTION confirmIdentity(id int, pwd varchar(50))
	RETURNS boolean
	READS SQL DATA
        RETURN (SELECT count(UserID) FROM USERS WHERE UserID = id AND aes_decrypt(Pass, concat(pwd, @AESPWD)) = pwd)=1;
??

CREATE FUNCTION encryptPwd(pwd varchar(50))
	RETURNS BLOB
	NO SQL
    RETURN aes_encrypt(pwd, concat(pwd,@AESPWD));
??    

CREATE FUNCTION getUserID(uname varchar(50))
	RETURNS int
    READS SQL DATA
	BEGIN        
        IF (SELECT if (uname LIKE '%@%', true, false)) THEN
			RETURN (SELECT UserID FROM USERS WHERE Email = uname);
		ELSE 
			RETURN (SELECT UserID FROM USERS WHERE UserName = uname);
        END IF;
    END
??
/*==============================================================*/