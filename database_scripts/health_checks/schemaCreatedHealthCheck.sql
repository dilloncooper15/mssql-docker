USE ExampleDb;
GO

DECLARE @SchemaCreated BIT=(SELECT CASE WHEN COUNT(*) = 2 THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS IsPopulated FROM sys.tables)
SELECT @SchemaCreated
