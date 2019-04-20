USE ExampleDb;
GO

/* Creates a stored procedure for confirming all foreign key associations were implemented correctly. */
CREATE PROCEDURE ConfirmFKAssociations
AS
SELECT DISTINCT [TABLE_NAME] INTO #TempTblTableNames FROM ExampleDb.INFORMATION_SCHEMA.KEY_COLUMN_USAGE 

ALTER TABLE #TempTblTableNames ADD ID INT Identity(1,1);

CREATE TABLE 
    #TempTblSch(TableName sysname, ColumnName sysname, ConstraintName sysname, ConstraintCatelog sysname);

DECLARE @i INT = 1;
DECLARE 
    @tableCount INT = (SELECT COUNT(*) AS TableCount FROM sys.tables);
WHILE @i < @tableCount
BEGIN 
	INSERT #TempTblSch
    SELECT TABLE_NAME, COLUMN_NAME, CONSTRAINT_NAME, CONSTRAINT_CATALOG FROM ExampleDb.INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
    WHERE TABLE_NAME = 
        (SELECT [TABLE_NAME] FROM #TempTblTableNames WHERE ID = @i)
    SET @i=@i+1
END;

SELECT * FROM #TempTblSch ORDER BY TableName asc;

DROP TABLE #TempTblTableNames;
DROP TABLE #TempTblSch;
GO
