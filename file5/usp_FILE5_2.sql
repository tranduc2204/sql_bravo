DROP PROC IF EXISTS usp_FILE5_2
GO
CREATE PROC usp_FILE5_2
	@_Name NVARCHAR (MAX)
AS
BEGIN 
	--DECLARE @_Name NVARCHAR (MAX) = N'Trần Đức';

	-- đảo ngược chuỗi
	DECLARE @_ReversedName NVARCHAR(MAX) = REVERSE(@_Name); -- đảo ngược chuỗi lại
	DECLARE @_Position INT = CHARINDEX (' ', @_ReversedName); -- kiếm khoảng trắng đầu tiên từ dưới lên
	--select @_Position
	DECLARE @_NameTen NVARCHAR (MAX) = SUBSTRING (@_Name, LEN(@_Name) - @_Position + 1 , len(@_Name)); -- sub chuỗi từ khúc khoảng trăng steen đến hết 
	DECLARE @_Count INT = LEN (SUBSTRING (@_Name, LEN(@_Name) - @_Position + 1 , len(@_Name))); 
	DECLARE @_Ho NVARCHAR (MAX) = SUBSTRING (@_Name, 1, LEN(@_Name) - @_Count); -- cắt lấy họ và tên lót
	SELECT  @_NameTen;
	SELECT @_Ho;
END
GO
EXEC usp_FILE5_2 N'Trần Đức bo'
