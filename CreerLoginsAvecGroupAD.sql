USE [master]
GO
PRINT 'CREATION LOGINS DES GROUPES AD';

------------------------------------------ GROUP AD / DCPTSTR---------------------------------
IF NOT EXISTS(SELECT * FROM master.sys.server_principals
              WHERE type = 'G'
			   and name  = 'MVT\ST-SQL-FID-DCPTSTR-Support' )
  CREATE LOGIN [MVT\ST-SQL-FID-DCPTSTR-Support] FROM WINDOWS WITH DEFAULT_DATABASE=[master];

IF NOT EXISTS(SELECT * FROM master.sys.server_principals
              WHERE type = 'G'
			   and name  = 'MVT\ST-SQL-FID-DCPTSTR-CPT_READ' )
  CREATE LOGIN [MVT\ST-SQL-FID-DCPTSTR-CPT_READ] FROM WINDOWS WITH DEFAULT_DATABASE=[master];

IF NOT EXISTS(SELECT * FROM master.sys.server_principals
              WHERE type = 'G'
			   and name  = 'MVT\ST-SQL-FID-DCPTSTR-AUTOSYS' )
  CREATE LOGIN [MVT\ST-SQL-FID-DCPTSTR-AUTOSYS] FROM WINDOWS WITH DEFAULT_DATABASE=[master];

GO

----------------------------------------- GROUP AD / DCPTAFF---------------------------------
IF NOT EXISTS(SELECT * FROM master.sys.server_principals
              WHERE type = 'G'
			   and name  = 'MVT\ST-SQL-FID-DCPTAFF-Support' )
  CREATE LOGIN [MVT\ST-SQL-FID-DCPTAFF-Support] FROM WINDOWS WITH DEFAULT_DATABASE=[master];

IF NOT EXISTS(SELECT * FROM master.sys.server_principals
              WHERE type = 'G'
			   and name  = 'MVT\ST-SQL-FID-DCPTAFF-CPT_READ' )
  CREATE LOGIN [MVT\ST-SQL-FID-DCPTAFF-CPT_READ] FROM WINDOWS WITH DEFAULT_DATABASE=[master];

IF NOT EXISTS(SELECT * FROM master.sys.server_principals
              WHERE type = 'G'
			   and name  = 'MVT\ST-SQL-FID-DCPTAFF-AUTOSYS' )
  CREATE LOGIN [MVT\ST-SQL-FID-DCPTAFF-AUTOSYS] FROM WINDOWS WITH DEFAULT_DATABASE=[master];

GO
USE DCPTAFFPRO1
GO
PRINT 'CREATION DES Rôles BD - DCPTAFF';

IF DATABASE_PRINCIPAL_ID('CPT_READ') IS NULL
BEGIN
  CREATE ROLE CPT_READ;
  GRANT SELECT TO CPT_READ;
END

IF DATABASE_PRINCIPAL_ID('AUTOSYS') IS NULL
BEGIN
  CREATE ROLE AUTOSYS;
  GRANT INSERT,SELECT,UPDATE,DELETE,ALTER,EXECUTE TO AUTOSYS;
END

IF DATABASE_PRINCIPAL_ID('SUPPORT') IS NULL
BEGIN
   CREATE ROLE SUPPORT;
   GRANT SELECT,SHOWPLAN,VIEW DEFINITION to SUPPORT;
END
GO

PRINT 'CREATION usagers des groupes AD - BD DCPTAFF';

IF NOT EXISTS
    (SELECT name
     FROM sys.database_principals
     WHERE name = '[MVT\ST-SQL-FID-DCPTAFF-AUTOSYS]')
BEGIN
    CREATE USER [MVT\ST-SQL-FID-DCPTAFF-AUTOSYS] FOR LOGIN [MVT\ST-SQL-FID-DCPTAFF-AUTOSYS]
END
GO
IF NOT EXISTS
    (SELECT name
     FROM sys.database_principals
     WHERE name = '[MVT\ST-SQL-FID-DCPTAFF-CPT_READ]')
BEGIN
    CREATE USER [MVT\ST-SQL-FID-DCPTAFF-CPT_READ] FOR LOGIN [MVT\ST-SQL-FID-DCPTAFF-CPT_READ]
END
GO
IF NOT EXISTS
    (SELECT name
     FROM sys.database_principals
     WHERE name = '[MVT\ST-SQL-FID-DCPTAFF-Support]')
BEGIN
    CREATE USER [MVT\ST-SQL-FID-DCPTAFF-Support] FOR LOGIN [MVT\ST-SQL-FID-DCPTAFF-Support]
END
GO
ALTER ROLE [AUTOSYS] ADD MEMBER [MVT\ST-SQL-FID-DCPTAFF-AUTOSYS]
GO
ALTER ROLE [CPT_READ] ADD MEMBER [MVT\ST-SQL-FID-DCPTAFF-CPT_READ]
GO
ALTER ROLE [SUPPORT] ADD MEMBER [MVT\ST-SQL-FID-DCPTAFF-Support]
GO

USE DCPTSTRPRO1
GO
PRINT 'CREATION DES Rôles BD - DCPTSTR';

IF DATABASE_PRINCIPAL_ID('CPT_READ') IS NULL
BEGIN
  CREATE ROLE CPT_READ;
  GRANT SELECT TO CPT_READ;
END

IF DATABASE_PRINCIPAL_ID('AUTOSYS') IS NULL
BEGIN
  CREATE ROLE AUTOSYS;
  GRANT INSERT,SELECT,UPDATE,DELETE,ALTER,EXECUTE TO AUTOSYS;
END

IF DATABASE_PRINCIPAL_ID('SUPPORT') IS NULL
BEGIN
   CREATE ROLE SUPPORT;
   GRANT SELECT,SHOWPLAN,VIEW DEFINITION to SUPPORT;
END
GO

PRINT 'CREATION usagers des groupes AD - BD DCPTSTR';
IF NOT EXISTS
    (SELECT name
     FROM sys.database_principals
     WHERE name = '[MVT\ST-SQL-FID-DCPTSTR-AUTOSYS]')
BEGIN
    CREATE USER [MVT\ST-SQL-FID-DCPTSTR-AUTOSYS] FOR LOGIN [MVT\ST-SQL-FID-DCPTSTR-AUTOSYS]
END
GO

IF NOT EXISTS
    (SELECT name
     FROM sys.database_principals
     WHERE name = '[MVT\ST-SQL-FID-DCPTSTR-CPT_READ]')
BEGIN
    CREATE USER [MVT\ST-SQL-FID-DCPTSTR-CPT_READ] FOR LOGIN [MVT\ST-SQL-FID-DCPTSTR-CPT_READ]
END
GO

IF NOT EXISTS
    (SELECT name
     FROM sys.database_principals
     WHERE name = '[MVT\ST-SQL-FID-DCPTSTR-Support]')
BEGIN
    CREATE USER [MVT\ST-SQL-FID-DCPTSTR-Support] FOR LOGIN [MVT\ST-SQL-FID-DCPTSTR-Support]
END
GO
ALTER ROLE [AUTOSYS] ADD MEMBER [MVT\ST-SQL-FID-DCPTSTR-AUTOSYS]
GO
ALTER ROLE [CPT_READ] ADD MEMBER [MVT\ST-SQL-FID-DCPTSTR-CPT_READ]
GO
ALTER ROLE [SUPPORT] ADD MEMBER [MVT\ST-SQL-FID-DCPTSTR-Support]
GO