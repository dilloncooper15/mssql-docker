USE ExampleDb;

ALTER DATABASE ExampleDb
SET CHANGE_TRACKING = ON
(CHANGE_RETENTION = 2 DAYS, AUTO_CLEANUP = ON);
GO