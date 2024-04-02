
DROP PROC IF EXISTS usp_FILE2_8
GO 
CREATE PROC usp_FILE2_8
AS
BEGIN
-- Tạo bảng với tên là "Data" và các cột là "Code" và "Value"
	CREATE TABLE #tblResource (
		Code VARCHAR(1),
		Value INT
	);

	-- Chèn dữ liệu vào bảng
	INSERT INTO #tblResource (Code, Value) VALUES ('A', 100);
	INSERT INTO #tblResource (Code, Value) VALUES ('B', 100);
	INSERT INTO #tblResource (Code, Value) VALUES ('C', 220);
	INSERT INTO #tblResource (Code, Value) VALUES ('A', 150);
	INSERT INTO #tblResource (Code, Value) VALUES ('C', 300);
	INSERT INTO #tblResource (Code, Value) VALUES ('D', 120);
	INSERT INTO #tblResource (Code, Value) VALUES ('E', 120);

	--SELECT * FROM #tblResource;
	
	SELECT CODE, Value, ROW_NUMBER () OVER (ORDER BY (SELECT  NULL)) RowNumber 
	INTO #tbdata
	FROM #tblResource;

	--SELECT *
	--FROM #tbdata;

	SELECT
		t1.Code AS 'Key1 t1',
		t1.Value AS 'Value1 t2',
		t2.Code AS Key2,
		t2.Value AS Value2,
		t3.Code AS Key3,
		t3.Value AS Value3
	FROM
		#tbdata t1
	LEFT JOIN
		#tbdata t2 ON t2.RowNumber = t1.RowNumber + 1 -- Join để lấy cặp key-value kế tiếp
	LEFT JOIN
		#tbdata t3 ON t3.RowNumber = t1.RowNumber + 2 -- Join để lấy cặp key-value kế tiếp
	WHERE
		t1.RowNumber % 3 = 1  -- LẤY HÀNG ĐẦU TIÊN CỦA MỖI NHÓM 3 HÀNG


END
GO
EXEC usp_FILE2_8