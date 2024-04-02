
DROP PROC IF EXISTS usp_FILE2_2
GO
CREATE PROC usp_FILE2_2
AS 
BEGIN 
	DECLARE @outputt VARCHAR(max) = '';

	select @outputt = @outputt +  code+','
	from bai2;
	set @outputt = replace(@outputt ,' ','');
	--print @outputt;
	set @outputt =LEFT(@outputt, LEN(@outputt) - 1); -- bỏ dấu , ở sau
	print @outputt

END
GO
EXEC usp_FILE2_2 

