
DROP PROC IF EXISTS usp_FILE2_4
GO 
CREATE PROC usp_FILE2_4
as
BEGIN 
	-- dense_rank đùng dể đánh số rank mà pass qua dòng 
	SELECT DENSE_RANK() OVER( ORDER BY code) AS id, ROW_NUMBER() OVER(PARTITION BY CODE ORDER BY VALUE) order_ , code, value
	FROM BAI4 
	ORDER BY CODE ASC, VALUE ASC
end

go 
exec usp_FILE2_4