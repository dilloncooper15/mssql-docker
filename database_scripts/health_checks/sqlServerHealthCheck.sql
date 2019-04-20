USE ExampleDb;
GO

DECLARE @ServerRunning BIT=(SELECT CASE WHEN COUNT(*) = 1 THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS IsRunning FROM sys.servers)
SELECT @ServerRunning
