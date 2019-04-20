USE ExampleDb;
GO

/* Queries every table and validates each table is populated with data. 
If the table contains data, return 1; however, if no data exists, return 0. ******/
CREATE PROCEDURE GetPopulatedAndEmptyTables
AS
SELECT 
    t.NAME AS TableName,
    CASE WHEN p.rows > 0 THEN
        CAST(1 AS BIT)
    ELSE
        CAST(0 AS BIT)
    END AS ISPopulated
FROM 
    sys.tables t
INNER JOIN      
    sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN 
    sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
INNER JOIN 
    sys.allocation_units a ON p.partition_id = a.container_id
LEFT OUTER JOIN 
    sys.schemas s ON t.schema_id = s.schema_id
WHERE 
    t.NAME NOT LIKE 'dt%' 
    AND t.is_ms_shipped = 0
    AND i.OBJECT_ID > 255 
GROUP BY 
    t.Name, s.Name, p.Rows
ORDER BY 
    ISPopulated, t.Name;
GO
