USE ExampleDb;
GO

/* Returns every table, as well as, the column in that table, that have a reference to the table name passed as a parameter 
        To run this Stored Procedure: `EXEC dbo.GetChildReferences @TableName='Customer'` */
CREATE PROCEDURE dbo.GetChildReferences @TableName NVARCHAR(50)
AS
SELECT 
   OBJECT_NAME(f.parent_object_id) TableName,
   COL_NAME(fc.parent_object_id,fc.parent_column_id) ColName
FROM 
   sys.foreign_keys AS f
INNER JOIN 
   sys.foreign_key_columns AS fc 
      ON f.OBJECT_ID = fc.constraint_object_id
INNER JOIN 
   sys.tables t 
      ON t.OBJECT_ID = fc.referenced_object_id
WHERE 
   OBJECT_NAME (f.referenced_object_id) = @TableName
ORDER BY TableName ASC;
GO
