
DROP PROC IF EXISTS usp_FILE2_3
GO
CREATE PROC usp_FILE2_3
AS 
BEGIN 
	DECLARE @string varchar (MAX) = 'A,B,C';

	CREATE TABLE #temp (
		ID INT IDENTITY(1,1) PRIMARY KEY, -- id tự động tăng bắt đầu 1 bước nhảy 1
		Name NVARCHAR(50)
	);
	INSERT INTO #temp (Name)
	select  value
	FROM STRING_SPLIT(@string, ',');

	SELECT * FROM #temp;

	DROP TABLE #temp;

END
GO
EXEC usp_FILE2_3