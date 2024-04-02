
DROP PROC IF EXISTS usp_FILE4_2
GO 
CREATE PROC usp_FILE4_2
AS
BEGIN
	-- Tạo bảng AccumulativeTable
	CREATE TABLE #AccumulativeTable (
		Code CHAR(1),
		Value INT,
		AccumulativeValue INT
	);

	-- Chèn dữ liệu vào bảng
	INSERT INTO #AccumulativeTable (Code, Value)
	VALUES 
		('A', 1),
		('B', 3),
		('C', 2),
		('D', 5),
		('E', 7);

	-- Cập nhật giá trị tích lũy
	DECLARE @Accumulative INT = 0;

	UPDATE #AccumulativeTable
	SET @Accumulative = AccumulativeValue = @Accumulative + Value
	FROM #AccumulativeTable
	;

	-- Hiển thị dữ liệu
	SELECT * FROM #AccumulativeTable;


END

GO
EXEC usp_FILE4_2




DROP PROC IF EXISTS usp_FILE4_2_V2
GO 
CREATE PROC usp_FILE4_2_V2
AS
BEGIN
	-- Tạo bảng AccumulativeTable
	CREATE TABLE #AccumulativeTable (
		Code CHAR(1),
		Value_ INT
		--AccumulativeValue INT
	);

	-- Chèn dữ liệu vào bảng
	INSERT INTO #AccumulativeTable (Code, Value_)
	VALUES 
		('A', 1),
		('B', 3),
		('C', 2),
		('D', 5),
		('E', 7);

	SELECT  ROW_NUMBER() OVER (ORDER BY code) AS id,*, Value_ as  AccumulativeValue
	into #tmp
	FROM #AccumulativeTable;

	select code, Value_, (select sum (AccumulativeValue) as Total from #tmp where #tmp.id <= #tmp1.id) as luyke
	from #tmp as #tmp1

	drop table #AccumulativeTable;
	drop table #tmp
END 
GO
EXEC usp_FILE4_2_V2




DROP PROC IF EXISTS usp_FILE4_2_V3
GO 
CREATE PROC usp_FILE4_2_V3
AS
BEGIN
	-- Tạo bảng AccumulativeTable
	CREATE TABLE #AccumulativeTable (
		Code CHAR(1),
		Value_ INT
		--AccumulativeValue INT
	);

	-- Chèn dữ liệu vào bảng
	INSERT INTO #AccumulativeTable (Code, Value_)
	VALUES 
		('A', 1),
		('B', 3),
		('C', 2),
		('D', 5),
		('E', 7);

	SELECT  ROW_NUMBER() OVER (ORDER BY code) AS id,*
	into #tmp
	FROM #AccumulativeTable;
	SELECT * , SUM(Value_) OVER (ORDER BY (id))
	FROM #tmp

	drop table #AccumulativeTable;
	drop table #tmp
END 
GO
EXEC usp_FILE4_2_V3