USE ITLWatch;
SET @AESPWD:='ITLWatchAESDecrypt';

INSERT INTO USERS (Username, Pass, Email) VALUES('AndreGaytan', encryptPwd('1234'),'andregaytan@gmail.com');
INSERT INTO USERS (Username, Pass, Email) VALUES('CarlosFonseca', encryptPwd('5678'),'carlosfonseca@gmail.com');
INSERT INTO USERS (Username, Pass, Email) VALUES('RobertoGarcia', encryptPwd('8910'),'roberto66@gmail.com');
INSERT INTO MEMBERS VALUES('Andre','Gaytan','Mexico','1997-10-24','2019-10-15 23:34:56',1);
INSERT INTO MEMBERS VALUES('Carlos','Fonseca','Mexico','1996-09-15','2019-10-15 20:15:12',2);
INSERT INTO MEMBERS VALUES('Roberto','Garcia','Colombia','1990-02-10','2019-10-15 10:00:23',3);
INSERT INTO VIDEOS (URL, Titulo, Descripcion, UserID)VALUES('https://www.youtube.com/embed/MWnyCxva6bA', 'Mi Primer Video', 'Es el video de prueba de andre',1);
INSERT INTO VIDEOS (URL, Titulo, Descripcion, UserID)VALUES('https://www.youtube.com/embed/ed-OyXDxNjM', 'Un Video De JSP', 'La introduccion a un curso gratuito excelente de JSP',1);
INSERT INTO VIDEOS (URL, Titulo, Descripcion, UserID)VALUES('https://www.youtube.com/embed/PHgc8Q6qTjc', '¡Lo Logre!', ':D',1);
INSERT INTO VIDEOS (URL, Titulo, Descripcion, UserID)VALUES('https://www.youtube.com/embed/bNNQVpL0JsU', 'Mi Primer Video', 'Es el video de prueba de carlos',2);
INSERT INTO VIDEOS (URL, Titulo, Descripcion, UserID)VALUES('https://www.youtube.com/embed/tgl7uPkIR8E', 'Mi Primer Video', 'Es el video de prueba de roberto',3);
INSERT INTO COMMENTS (FechaPub, Comentario, UserID, VideoID) VALUES (now(),'El primer comentario en el video de andre', 1,1);
INSERT INTO COMMENTS (FechaPub, Comentario, UserID, VideoID) VALUES (now(),'El primer comentario en el video de carlos', 2,2);

/*STORED PROCEDURES PRUEBAS*/
CALL createUser('CynthiaLun','lunart','cynthialun97@gmail.com', 'Cynthia', 'Ortiz', 'Mexico', '1997-06-24');
/*CALL readUser(4);*/
CALL updateMember('Cynthia', 'Luna', 'Mexico', '1997-06-24',4);
/*CALL deleteUser(4);*/

CALL createVideo('5gZ3h8YQZMo', 'Mi Primer Video', 'Es es el video de prueba prron de mi amuchito',4);
/*CALL readMyVideos(4);*/
CALL updateVideo('Mi Primer Video','Es el video de prueba de Cynthia', 6);
/*CALL deleteVideo(4);*/

CALL createComment('Este es un comentario',6,4);
CALL createComment('Este es otro comentario',6,4);
CALL createComment('Este es el 3er comentario',6,4);
CALL createComment('Este es un comentario hecho por andre',6,1);
CALL createComment('Este es otro comentario hecho por carlos',6,2);
CALL createComment('Este es el ultimo comentario hecho por roberto',6,3);
/*CALL readComment(6);*/
/*CALL readVideoComments(4);*/
CALL updateComment('Este comentario fue modificado por un procedimiento almacenado',5);
/*CALL deleteComment(5);*/

CALL updatePassword('1234','andregaytan',1,@res);


