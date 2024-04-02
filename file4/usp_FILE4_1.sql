
ALTER PROC usp_FILE4_1
AS
BEGIN 
	CREATE TABLE #Warehouse (
		Stt INT,
		WarehouseCode VARCHAR(50)
	);	

	-- Chèn dữ liệu vào bảng
	INSERT INTO #Warehouse (Stt, WarehouseCode) 
	VALUES
		(1, 'A'),
		(2, 'B'),
		(3, 'C'),
		(4, 'ABC');

	SELECT * 
	INTO #TMP
	FROM #Warehouse;

	
	--SELECT 
 --   CONCAT('000', tb1.Stt) AS Stt, 
 --   tb1.WarehouseCode, 
 --   CONCAT('Có mã lồng tại dòng "', tb2.WarehouseCode, '"') AS Description
	--FROM 
 --   #TMP tb1
	--left JOIN 
	--	#TMP tb2 ON tb1.Stt <> tb2.Stt AND tb2.WarehouseCode LIKE '%' + tb1.WarehouseCode + '%';

	--select * from #TMP;

	SELECT 
    CONCAT('000', tb1.Stt) AS Stt, 
    tb1.WarehouseCode, 
    CONCAT(N'  "', 
        CASE 
            WHEN tb1.WarehouseCode = 'ABC' THEN (SELECT CONCAT(N'Có mã lồng tại dòng 000', Stt) FROM #TMP WHERE WarehouseCode = 'A')
            ELSE concat (N'có mã lồng trong ', tb2.WarehouseCode)  
				
        END, 
        '"') AS Description
	FROM 
    #TMP tb1
	left JOIN 
		#TMP tb2 ON tb1.Stt <> tb2.Stt AND tb2.WarehouseCode LIKE '%' + tb1.WarehouseCode + '%';


	DROP TABLE #Warehouse;
	DROP TABLE #TMP;
END
GO

EXEC usp_FILE4_1