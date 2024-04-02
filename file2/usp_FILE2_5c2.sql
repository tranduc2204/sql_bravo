
DROP PROC IF EXISTS usp_FILE2_5c2
GO
CREATE PROC usp_FILE2_5c2
AS
BEGIN 
	CREATE TABLE #tblResource(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	Code varchar (MAX),
	Open_ int);

	INSERT INTO #tblResource (Code, Open_)
	VALUES('A','1'),('C','3');
	

	CREATE TABLE #tblResource1(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	Code varchar (MAX),
	Input_ int,
	Output_ int);

	INSERT INTO #tblResource1 (Code, Input_, Output_)
	VALUES('A','1',''),('A','3','2'),('A','1','3')
			,('B','1','1'),('B','2','1'),('C','1','4')
			,('C','2','2');
	
	
	SELECT tb2.ID, tb2.code, COALESCE(Open_, 0)Open_ ,Input_, Output_ 
	INTO #TMP
	FROM #tblResource tb1 
	right join #tblResource1 tb2
		on tb1.Code = tb2.Code;


	--select *
	--from #TMP ;


	-- table sau khi join, table sơ khai
	select *, sum (Input_ - Output_) over (partition by code order by id) + Open_ as close_
	into #tmp1
	from #TMP ;

	select * , 
	CASE 
		WHEN ROW_NUMBER() OVER (PARTITION BY CODE ORDER BY ID) = 1 THEN Open_
		ELSE LAG(CLOSE_, 1) OVER (PARTITION BY CODE ORDER BY ID)END AS OPEN_V2
	INTO #TMP2
	FROM #tmp1;

	SELECT ID, CODE, OPEN_V2, Input_, Output_, close_
	FROM #TMP2

	DROP TABLE #tblResource
	DROP TABLE #tblResource1
END
GO
EXEC usp_FILE2_5c2




-- cách anh Tân

DROP PROC IF EXISTS usp_FILE2_5
GO
CREATE PROC usp_FILE2_5
AS
BEGIN 
	CREATE TABLE #tblResource(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	Code varchar (MAX),
	Open_ int);

	INSERT INTO #tblResource (Code, Open_)
	VALUES('A','1'),('C','3');
	

	CREATE TABLE #tblResource1(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	Code varchar (MAX),
	Input_ int,
	Output_ int);

	INSERT INTO #tblResource1 (Code, Input_, Output_)
	VALUES('A','1',''),('A','3','2'),('A','1','3')
			,('B','1','1'),('B','2','1'),('C','1','4')
			,('C','2','2');
	
	
	;With TblResource1
	AS
	(
		--tạo bảng tạm đánh dấu đếm thứ tự cho phát sinh của từng mã vật tư
		Select *, ROW_NUMBER() OVER (Partition BY Code ORDER BY Id) AS Dem 
		FROM #tblResource1
		
	)
	--left join nối tồn đầu vào dòng dữ liệu phát sinh đầu tiên 
	--Sau đó sử dụng câu lệnh lấy ra sum lũy kế
	SELECT *
		--Dòng này sum dữ liệu open(từ bảng open) + Input - output sum từ lúc bắt đầu dữ liệu tới trước dòng hiện tại 1 dòng (Lưu ý dòng đầu tiên sẽ bị null nên a gán = giá trị tồn đầu)
		, ISNULL(SUM(ISNULL(_OpenData.Open_, 0) + ISNULL(_InOutData.Input_,0) - ISNULL(_InOutData.Output_,0)) OVER (PARTITION BY _InOutData.Code ORDER BY _InOutData.Code ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), ISNULL(_OpenData.Open_,0))  AS Opening
		--Dòng này sẽ sum lũy kế theo data phát sinh 
		, SUM(ISNULL(_OpenData.Open_, 0) + ISNULL(_InOutData.Input_,0) - ISNULL(_InOutData.Output_,0)) OVER (PARTITION BY _InOutData.Code ORDER BY _InOutData.Code ROWS UNBOUNDED PRECEDING) AS Closing
	FROM  TblResource1 AS _InOutData 
	LEFT JOIN #tblResource AS _OpenData ON _InOutData.Code = _OpenData.Code AND _InOutData.Dem = 1
	

	

	DROP TABLE #tblResource
	DROP TABLE #tblResource1
END
GO
EXEC usp_FILE2_5