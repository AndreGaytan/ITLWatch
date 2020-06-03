/*----------VIEWS------*/
/*Pruebas y prellenado*/
USE ITLWatch;
CREATE VIEW MEMBER_INFO AS
	SELECT u.UserID, u.UserName, u.Email, m.Nombre, m.Apellido, m.Pais, m.FechaNac, m.FechaRegistro, timestampdiff(YEAR, m.FechaNac,  now()) AS Edad, getAntiquity(m.FechaRegistro) AS Antiguedad, (SELECT count(VideoID) FROM VIDEOS WHERE UserID = u.UserID) AS Videos_Subidos
	FROM MEMBERS m JOIN USERS u
	ON u.UserID = m.UserID;

CREATE VIEW COMMENT_INFO AS
	SELECT u.Username, c.FechaPub, c.Comentario, c.VideoID, c.CommentID 
    FROM COMMENTS c JOIN USERS u
    WHERE c.UserID= u.UserID;
    
CREATE VIEW VIDEO_INFO AS
	SELECT v.VideoID, v.URL, v.Titulo, v.Descripcion, u.UserName, v.UserID
	FROM VIDEOS v JOIN USERS u
	ON v.UserID=u.UserID;
