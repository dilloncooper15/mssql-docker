USE ExampleDb;
GO

/* Creates Stored Procedure to query for all empty tables in the database */
CREATE PROCEDURE GetEmptyTables
AS
SELECT t.Name AS TableName, p.rows AS RowCounts
FROM ExampleDb.sys.tables t 
INNER JOIN sys.indexes i ON t.OBJECT_ID = i.object_id 
INNER JOIN sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id 
INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id 
INNER JOIN sys.schemas s ON t.schema_id = s.schema_id 
WHERE p.rows = 0
GROUP BY t.Name, s.Name, p.Rows 
ORDER BY s.Name, t.Name;
GO
