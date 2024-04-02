DROP PROC IF EXISTS usp_FILE5_3
GO
CREATE PROC usp_FILE5_3
	@_String NVARCHAR (MAX)
AS
BEGIN 
	--DECLARE @_String varchar (MAX) = '121111A';

	DECLARE @_Symbol varchar (1) =  right (@_String, 1)
	DECLARE @_Number INT =  substring (@_String ,1 , len(@_String) -1)
	--SELECT CONCAT(@_Symbol, CONCAT('-', @_Number))

	IF @_Number < 100000
    BEGIN
        SELECT CONCAT(@_Symbol, CONCAT('-', @_Number))
    END
    ELSE
    BEGIN
        PRINT N'Số nhập vào lớn hơn hoặc bằng 100,000.'
    END
END

GO

EXEC usp_FILE5_3 '2311A'