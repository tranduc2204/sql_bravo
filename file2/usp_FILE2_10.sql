
DROP PROC IF EXISTS usp_FILE2_10
GO 
CREATE PROC usp_FILE2_10
AS
BEGIN
	-- Tạo bảng tblResource
	CREATE TABLE #tblResource (
		Class NVARCHAR(MAX),
		Code NVARCHAR(MAX),
		Value INT
	);

	-- Chèn dữ liệu vào bảng tblResource
	INSERT INTO #tblResource (Class, Code, Value)
	VALUES
		('F1', 'A', 100),
		('F1', 'A', 200),
		('F1', 'B', 100),
		('F2', 'C', 220),
		('F3', 'A', 150),
		('F2', 'C', 300),
		('F3', 'D', 120);


	CREATE TABLE #tblResource1 (
		Class NVARCHAR(MAX),
		Sum INT
	);
	INSERT INTO #tblResource1 (Class, Sum)
	VALUES
		('F1', 500),
		('F2', 400),
		('F3', 600);


	--SELECT *
	--FROM #tblResource;

	--SELECT *
	--FROM #tblResource1;

	SELECT tb1.Class, Code, Value, Sum AS Sum_
	INTO #TMP 
	FROM #tblResource TB1
	JOIN #tblResource1 TB2
		ON TB1.Class = TB2.Class

	SELECT Class, Code,  SUM(Value)Value, SUM(Sum_)Sum_
	INTO #TABLEVALUE
	FROM #TMP
	GROUP BY Class, Code
	ORDER BY Class, Value DESC

	SELECT *
	INTO #TABLEVALUEEND
	FROM #TABLEVALUE
	ORDER BY Class, Value DESC

	--SELECT *
	--FROM #TABLEVALUEEND

	--SELECT * 
	--FROM #TMP;

	SELECT CLASS, CONCAT ('/(',CONCAT(STRING_AGG(VALUE, '+'),')*')) AS  ConcatenatedString       --,STRING_AGG(VALUE, '+') AS ConcatenatedString
	INTO #TABLETEMP
	FROM #TMP
	GROUP BY CLASS;

	--SELECT * 
	--FROM #TABLETEMP;

	SELECT TB1.Class, CODE, Value, Sum_, ConcatenatedString
	INTO #TABLETEMP1
	FROM #TABLEVALUEEND TB1 
	JOIN #TABLETEMP TB2
		ON TB1.Class = TB2.Class;

	SELECT TB1.Class, TB1.Code, TB2.Value, TB1.Sum_, CONCAT(TB2.Value, ConcatenatedString) Distribute
	INTO #TABLETEMP2
	FROM #TABLETEMP1 TB1 
	JOIN #TABLEVALUEEND TB2
		ON TB1.Class = TB2.Class AND TB1.Code = TB2.Code
	ORDER BY Class

	SELECT TB1.Class, Code, Value,  CONCAT(Distribute, Sum) Distribute
	FROM #TABLETEMP2 TB1 
	JOIN #tblResource1 TB2
		ON TB1.Class = TB2.Class
	ORDER BY TB1.Class, VALUE DESC
	DROP TABLE #tblResource;
END

GO
EXEC usp_FILE2_10
