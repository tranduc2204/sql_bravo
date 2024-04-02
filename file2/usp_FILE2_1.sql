
--1.	Tạo chuỗi “Tk LIKE ‘111%’ OR Tk LIKE ‘112%’ OR Tk LIKE ‘131%’” từ chuỗi cho trước “111,112,131”




DECLARE @inputString NVARCHAR(MAX) = '111,112,131';
DECLARE @outputString NVARCHAR(MAX) = '';

SELECT @outputString = @outputString + 'Tk LIKE ''' + value + '%'' OR '
FROM STRING_SPLIT(@inputString, ',');
SET @outputString = LEFT(@outputString, LEN(@outputString) - 3);
PRINT @outputString;

GO

---------------
DROP PROC IF EXISTS  usp_FILE2_1
go
CREATE PROC usp_FILE2_1
AS
BEGIN 
	DECLARE @inputString NVARCHAR(MAX) = '111,112,131';
	DECLARE @outputString NVARCHAR(MAX) = '';

	--select value
	--from STRING_SPLIT(@inputString, ',');

	SELECT @outputString = @outputString + 'Tk LIKE ''' + value + '%'' OR '
	FROM STRING_SPLIT(@inputString, ',');
	SET @outputString = LEFT(@outputString, LEN(@outputString) - 3);--- cắt chữ or
	PRINT @outputString;





END
go
EXEC usp_FILE2_1; 

