USE ExampleDb;
GO

/* Creates a stored procedure that returns every column's type, as well as, if it's a primary key or foreign key, for every table in the database. */
/* Select and insert all table names in the database. */
CREATE PROCEDURE GetDatabaseTableSchema
AS
SELECT [name] as TABLE_NAME INTO #TempTblTableNames 
FROM sys.tables;
/* Add Identity columns to TempTblTableNames. This will allow us to iterate over every row and select the corresponding table name. */
ALTER TABLE #TempTblTableNames ADD ID INT IDENTITY(1,1);
/* Select and insert Table Name, Column Name, Reference Table Name, Reference Column Name and FK Object Names for
   all Foreign Keys for every table in the database into temp table, 'TempTblFK'. */
SELECT 
    OBJECT_NAME(fk.parent_object_id) AS TableName, 
    COL_NAME(fkc.parent_object_id, fkc.parent_column_id) AS ColumnName, 
    OBJECT_NAME (fk.referenced_object_id) AS ReferenceTableName, 
    COL_NAME(fkc.referenced_object_id, fkc.referenced_column_id) AS ReferenceColumnName,
    fk.[name] AS ForeignKey
    INTO #TempTblFk
        FROM sys.foreign_keys fk
            INNER JOIN 
                sys.foreign_key_columns fkc ON fk.OBJECT_ID = fkc.constraint_object_id
            INNER JOIN
                sys.objects obj ON obj.OBJECT_ID = fkc.referenced_object_id
        ORDER BY
            TableName ASC;
/* Create table, #TempTblSch. In order to insert our results from every iteration in our WHILE Loop, we must first create and define the table. */
CREATE TABLE 
    #TempTblSch(TableName sysname, ColumnName sysname, [Type] sysname, IsNullable sysname, PrimaryKey sysname);
/* Initialize the iteration variable. */       
DECLARE 
    @i INT=1;
/* Query to find how many tables exist in the database. This value will be used as our upper boundary for our WHILE Loop. */ 
DECLARE 
    @tableCount INT = (SELECT COUNT(*) AS TableCount FROM sys.tables);
/* Iterates over every table and inserts Table Name, Column Name, Type, nullability, and if the column is a PK into temp table, 'TempTblSch'. */   
WHILE @i < @tableCount
    BEGIN 
        INSERT #TempTblSch
        SELECT
            (SELECT DISTINCT TABLE_NAME FROM #TempTblTableNames WHERE ID = @i) TableName,
            col.[name] ColumnName, /* Column's Name. */
            typ.[name] [Type], /* Column's data type. */
            col.is_nullable [IsNullable], /* If column is required. */
            ISNULL(ind.is_primary_key, 0) PrimaryKey /* If PrimaryKey is NULL, return 0. Else, return 1. */
            FROM sys.columns col
                INNER JOIN 
                    sys.types typ ON col.user_type_id = typ.user_type_id
                LEFT OUTER JOIN 
                    sys.index_columns indcol ON indcol.object_id = col.object_id AND indcol.column_id = col.column_id
                LEFT OUTER JOIN 
                    sys.indexes ind ON indcol.object_id = ind.object_id AND indcol.index_id = ind.index_id
                WHERE col.object_id = 
                    OBJECT_ID((SELECT DISTINCT TABLE_NAME FROM #TempTblTableNames WHERE ID = @i))    
            SET @i=@i+1 /* Increment the iteration variable by 1. */
    END;
/* From TempTblSch, select TableName, ColumnName, Type, IsNullable (If column is required), PrimaryKey. From TempTblFk, select ForeignKey. If Foreign Key is NULL, return 0.
    Since multiple tables can have the same ColumnName, we have to join each Temp Table's TableName first, ensuring the correct join on each Temp Table's ColumnName. */           
SELECT TempTblSch.TableName, TempTblSch.ColumnName, TempTblSch.[Type], TempTblSch.IsNullable, TempTblSch.PrimaryKey, ISNULL(TempTblFk.ForeignKey, 0) ForeignKey 
FROM #TempTblFk TempTblFk 
    RIGHT JOIN #TempTblSch TempTblSch ON TempTblFk.TableName = TempTblSch.TableName AND TempTblFk.ColumnName = TempTblSch.ColumnName
ORDER BY TempTblSch.TableName;
/* Drop all Temp Tables. */
DROP TABLE #TempTblFk;
DROP TABLE #TempTblSch;
DROP TABLE #TempTblTableNames;
GO
