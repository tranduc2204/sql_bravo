
DROP PROC IF EXISTS usp_FILE5_8
GO
CREATE PROC usp_FILE5_8
AS
BEGIN
	DECLARE @_NgayDauThang DATE = '2024-03-07'; 

	WITH AllDays AS (
		SELECT @_NgayDauThang AS Ngay
		UNION ALL
		SELECT DATEADD(DAY, 1, Ngay)
		FROM AllDays
		WHERE MONTH(DATEADD(DAY, 1, Ngay)) = MONTH(@_NgayDauThang)
	)

	SELECT 
		Ngay AS NgayTrongThang,
		DATENAME(WEEKDAY, Ngay) AS TenThu
	INTO #BangThu
	FROM 
		AllDays
	OPTION (MAXRECURSION 0);

	select * from #BangThu
END
GO
EXEC usp_FILE5_8