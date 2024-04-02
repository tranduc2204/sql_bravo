
-- bài 3
DROP PROC IF EXISTS usp_FILE4_3
go
CREATE PROC usp_FILE4_3
AS
BEGIN
	-- Bảng B30AccDoc
	CREATE TABLE #B30AccDoc (
		Id INT IDENTITY (1,1),
		DocDate DATE,
		DocNo varchar (20),
		Description NVARCHAR(MAX),
		CustomerCode VARCHAR(50)
	);
	INSERT INTO #B30AccDoc (DocDate, DocNo, Description, CustomerCode)
	VALUES
		('2010-01-01', 001, N'Bán hành 01', 'ABC1'),

		('2010-01-02', 002, N'Bán hành 02', 'ABC2'),

		('2010-03-01', 003, N'Bán hành 03', 'BCD1'),

		('2010-03-02', 004, N'Bán hành 04', 'BCD2')


	-- Bảng B20Customer
	CREATE TABLE #B20Customer (
		Code VARCHAR(50),
		Name NVARCHAR(MAX)
	);
	INSERT INTO #B20Customer
	VALUES
		('ABC', N'Cty ABC'),
		('BCD', N'Cty BCD')

	-- Bảng B30AccDocSales
	CREATE TABLE #B30AccDocSales (
		Id INT IDENTITY (1,1),
		ItemCode VARCHAR(50),
		Quantity INT,
		Amount DECIMAL(18, 2)
	);
	INSERT INTO #B30AccDocSales
	VALUES
		('ABC1', 10, 10000000),

		('ABC2', 5, 5000000),

		('BCD1', 8, 20000000),

		('BCD2', 5, 15000000)
	
	-- Bảng B20Item
	CREATE TABLE #B20Item (
		Code VARCHAR(50),
		Name NVARCHAR(MAX)
	);
	

	SELECT   MAX(code)code,  MAX(Name)Name, SUM(Quantity)Quantity,  SUM(Amount)Amount, SUM ( CASE 
		WHEN Amount < 10000000
			THEN Amount * 3 /100 
		WHEN Amount <20000000 AND Amount >= 10000000
			THEN Amount * 5 /100
		WHEN Amount >=20000000
			THEN Amount * 7 /100
	END ) AS Discount
	INTO #TEMP
	FROM #B30AccDoc TB1
	JOIN #B30AccDocSales TB2
		ON TB1.Id = TB2.Id
	JOIN #B20Customer TB3
		ON TB3.Code = LEFT (TB2.ItemCode,3)
	group by left (ItemCode,3);

	--SELECT * 
	--FROM #TEMP;

	with tempp as (
	SELECT NULL AS 'NO.',code, null as DocDate, null as DocNo, Name as Description, Quantity,   Amount, Discount, CODE AS ItemCode
	FROM  #TEMP
	union
	SELECT ROW_NUMBER () OVER (PARTITION BY LEFT (ItemCode,3) ORDER BY (DocDate)) AS 'NO.',
	'HD' as Code, DocDate, DocNo, Description,Quantity,Amount, 
	CASE 
		WHEN Amount < 10000000
			THEN Amount * 3 /100 
		WHEN Amount <20000000 AND Amount >= 10000000
			THEN Amount * 5 /100
		WHEN Amount >=20000000
			THEN Amount * 7 /100
	END AS Discount
	,  LEFT (ItemCode,3) ItemCode
	FROM #B30AccDoc TB1
	JOIN #B30AccDocSales TB2
		ON TB1.Id = TB2.Id
	)
	select * ,ROW_NUMBER () OVER (PARTITION BY ItemCode ORDER BY (DocDate)) AS RANK
	into #TABLENODISCOUNT
	from tempp;




	WITH #TABLE1 AS (
	SELECT [NO.], code, DocDate, DocNo, Description, Quantity, Amount,  Discount
	FROM #TABLENODISCOUNT
	UNION ALL -- DÙNG ALL ĐỂ K ẢNH HƯỞNG TỚI SẮP XẾP CỦA BẢNG 
	SELECT NULL AS 'NO.', NULL AS code, null as DocDate, null as DocNo, N'Tổng cộng' as  Description, SUM(Quantity)Quantity, SUM (Amount)Amount, 
	SUM ( CASE 
		WHEN Amount < 10000000
			THEN Amount * 3 /100 
		WHEN Amount <20000000 AND Amount >= 10000000
			THEN Amount * 5 /100
		WHEN Amount >=20000000
			THEN Amount * 7 /100
	END ) AS Discount
	FROM #B30AccDocSales)
	
	SELECT *
	INTO #TABLEEND
	FROM #TABLE1
	;
	SELECT *
	FROM #TABLEEND;
	SELECT  ISNULL([NO.], ' ') AS 'NO.', ISNULL(code, ' ') AS 'Code',ISNULL(DocDate, ' ') AS 'DocDate', ISNULL(DocNo, ' ') AS 'DocNo',
	Description,Quantity, Amount, Discount
	FROM #TABLEEND;
	
END
GO 
EXEC usp_FILE4_3
