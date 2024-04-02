
DROP PROC IF EXISTS usp_FILE2_7
GO 
CREATE PROC usp_FILE2_7
AS
BEGIN
	CREATE TABLE #tblResult (
		Class VARCHAR(50),
		A INT,
		B INT,
		C INT,
		D INT
	);

	CREATE TABLE #tblResource (
		Class VARCHAR(50),
		Code CHAR(1),
		Value INT
	);

	INSERT INTO #tblResource (Class, Code, Value)
	VALUES
		('F1', 'A', 100),
		('F1', 'B', 100),
		('F2', 'C', 220),
		('F3', 'A', 150),
		('F2', 'C', 300),
		('F3', 'D', 120);

	SELECT * FROM #tblResource
	

	INSERT INTO #tblResult (Class, A, B, C, D)
	SELECT 
		Class  -- , A,B,C,D
		,ISNULL([A], 0) AS A,
		ISNULL([B], 0) AS B,
		ISNULL([C], 0) AS C,
		ISNULL([D], 0) AS D
	FROM 
		(
			SELECT 
				Class, Code, Value
			FROM 
				#tblResource
		) AS SourceTable
	PIVOT
		(
			SUM(Value)
			FOR Code IN ([A], [B], [C], [D])
		) AS PivotTable;

	SELECT * FROM #tblResult;
	
	DROP TABLE #tblResult;
END

GO
EXEC usp_FILE2_7