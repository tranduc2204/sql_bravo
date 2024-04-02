
--5.	Tạo ra bảng dữ liệu chứa các mã tài khoản kế toán từ một chuỗi các mã tài khoản kế toán cách nhau bằng dấu phẩy “,”.
DROP PROC IF EXISTS usp_FILE5_5
GO
CREATE PROC usp_FILE5_5
AS
BEGIN 
	DECLARE @_String varchar (MAX)= '111,112,113,131';
	DECLARE @_Output nvarchar (MAX)='';
	SELECT    value 
	FROM string_split (@_String,',');
end

go
exec usp_FILE5_5