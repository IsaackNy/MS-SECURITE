CREATE TABLE #ServerRoles ( 
  ServerRole VARCHAR(20), 
  MemberName sysname, 
  sid VARBINARY(85) 
); 

INSERT INTO #ServerRoles 
(ServerRole, MemberName, sid) 
EXEC sp_helpsrvrolemember; 

SELECT SL.name, SR.ServerRole 
FROM syslogins SL left
  JOIN #ServerRoles SR 
    ON SL.sid = SR.sid 
ORDER BY SL.name, SR.ServerRole; 
     
DROP TABLE #ServerRoles; 
