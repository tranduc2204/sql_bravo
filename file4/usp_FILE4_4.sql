
-- BÀI 4

DROP PROC IF EXISTS usp_FILE4_4
GO
CREATE PROC usp_FILE4_4
AS
BEGIN 
	CREATE TABLE #B20Item
	(
		Code nvarchar(MAX),
		Name nvarchar(MAX),
		GroupCode nvarchar(MAX)
	)
	INSERT INTO #B20Item
	VALUES
		('Vt1', N'Vật tu 1', 'VT'),
		('Vt2', N'Vật tu 2', 'VT'),
		('Vt3', N'Vật tu 3', 'VT')


	CREATE TABLE #B30OpenStock
	(
		ItemCode nvarchar(MAX),
		Quantity int,
		WarehouseCode nvarchar(MAX)
	)
	INSERT INTO #B30OpenStock
	VALUES
		('Vt1', 5, 'Stock1'),
		('Vt2', 9, 'Stock2'),
		('Vt2', 1, 'Stock3'),
		('Vt3', 3, 'Stock1'),
		('Vt3', 2, 'Stock2'),
		('Vt3', 7, 'Stock3')




	SELECT GroupCode, ItemCode,Name, Quantity, WarehouseCode
	INTO #TMP
	FROM #B20Item TB1
	JOIN #B30OpenStock TB2
		ON TB1.Code = TB2.ItemCode
	--SELECT * 
	--FROM #TMP

	
	SELECT *
	INTO #TMP1
	FROM (
		SELECT GroupCode, ItemCode, Name, Quantity, WarehouseCode
		FROM #TMP
	) AS SourceTable
	PIVOT(
		SUM(Quantity)
		FOR WarehouseCode IN ([Stock1], [Stock2], [Stock3])
	) AS PivotTable
	
	



	SELECT '' AS GroupCode, '' as ItemCode, N'Tổng cộng' as Name, [Stock1], [Stock2], [Stock3]
	INTO #TMP2
	FROM (
		SELECT   Quantity, WarehouseCode
		FROM #TMP
	) AS SourceTable
	PIVOT(
		SUM(Quantity)
		FOR WarehouseCode IN ([Stock1], [Stock2], [Stock3])
	) AS PivotTable
	

	SELECT GroupCode, ItemCode, Name AS ItemName, Stock1, Stock2, Stock3
	FROM #TMP1
	UNION ALL
	SELECT GroupCode, ItemCode, Name AS ItemName, Stock1, Stock2, Stock3
	FROM #TMP2
	
END
GO 
EXEC usp_FILE4_4