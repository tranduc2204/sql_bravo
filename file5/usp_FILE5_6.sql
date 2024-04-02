
--6.	Tạo một ngày đầu tháng, một ngày cuối tháng, một ngày đầu năm, ngày đầu năm từ một ngày cho trước.

DROP PROC IF EXISTS usp_FILE5_6
GO
CREATE PROC usp_FILE5_6
	@Date Date
AS
BEGIN 
	-- đầu tháng 
	SELECT DATEADD(month, DATEDIFF(month, 0, @Date), 0) AS FirstDayOfMonth
	-- cuois tháng 
	SELECT DATEADD(month, DATEDIFF(month, 0, @Date) + 1, 0) - 1 AS LastDayOfMonth
	-- đâu năm
	SELECT DATEFROMPARTS(YEAR(@Date), 1, 1) AS FirstDayOfYear
	-- cuối năm 
	SELECT DATEFROMPARTS(YEAR(@Date), 12, 31) AS LastDayOfYear
end

go 
exec usp_FILE5_6 '3-7-2014'