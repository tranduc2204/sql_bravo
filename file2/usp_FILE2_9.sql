
DROP PROC IF EXISTS usp_FILE2_9
GO 
CREATE PROC usp_FILE2_9
AS
BEGIN
	-- Tạo bảng
	CREATE TABLE #tblResource (
		Class varchar(50),
		A int,
		B int,
		C int,
		D int
	);


	-- Insert dữ liệu
	INSERT INTO #tblResource (Class, A, B, C, D)
	VALUES
		('F1', 100, 100, 0, 0),
		('F2', 0, 0, 520, 0),
		('F3', 150, 0, 0, 120);

	CREATE TABLE #tblResult (
		Class VARCHAR(50),
		Code CHAR(1),
		Value INT
	);

	
	SELECT 
		Class, 
		Code,
		Value
	INTO #TMP
	FROM 
	   #tblResource
	UNPIVOT 
	   (Value FOR Code IN 
		  ([A], [B], [C], [D])
	)AS unpvt;


	

	SELECT *
	FROM #TMP
	WHERE Value <> 0;

	DROP TABLE #tblResource;
END

GO

EXEC usp_FILE2_9