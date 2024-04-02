
DROP PROC IF EXISTS usp_FILE5_4
GO
CREATE PROC usp_FILE5_4
AS
BEGIN 
	DECLARE @_String varchar (MAX)= '111,112,113,131';
	DECLARE @_Output nvarchar (MAX)='';
	SELECT @_Output = @_Output + 'DebitAccount LIKE ‘' +  value + '%’ OR' 
	FROM string_split (@_String,',');
	set @_Output = left (@_Output, len(@_Output) -3)
	print (@_Output)
end

go
exec usp_FILE5_4