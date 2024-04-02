
---------------------------------------------------- file 6

DROP PROC IF EXISTS usp_FILE6_1
GO
CREATE PROC usp_FILE6_1
AS
BEGIN
--1.	Bảng giá các mặt hàng B20Prices(ItemCode, EffectiveDate, Amount)
	CREATE TABLE #B20Prices
	(
		ItemCode VARCHAR (MAX),
		EffectiveDate DATE,
		Amount INT 
	);
--2.	Bảng các chứng từ hóa đơn bán hàng B30AccDocDetail(Id, DocNo, DocDate, CustomerCode, ItemCode, Quantity, Price, Amount)
	CREATE TABLE #B30AccDocDetail
	(
		Id VARCHAR (MAX),
		DocNo VARCHAR (MAX),
		DocDate date,
		CustomerCode varchar (MAX), 
		ItemCode varchar (MAX),
		Quantity int,
		Price float, 
		Amount int
	)
--3.	Danh mục các khách hàng hiện tại của công ty B20Customer(Code, Name)
	CREATE TABLE #B20Customer
	(
		Code VARCHAR (MAX),
		Name NVARCHAR(MAX)
	)
--4.	Danh mục các mặt hàng bán B20Item(Code, Name)
	CREATE TABLE #B20Item
	(
		Code varchar (max),
		Name_ nvarchar (max)
	)

	DECLARE @val AS INT = 1;
	WHILE @val <= 50
		BEGIN
       
			DECLARE @RandomNumber INT;
			SET @RandomNumber = CONVERT(INT, (RAND() * 9998) + 1);

			-- Chuyển đổi số ngẫu nhiên thành chuỗi có 4 ký tự
			DECLARE @Result VARCHAR(4);
			SET @Result = RIGHT('000' + CAST(@RandomNumber AS VARCHAR(4)), 4);

			--SELECT concat ('I',@Result) AS RandomString;

			DECLARE @ProductName NVARCHAR (MAX) ='';

			DECLARE @RandomChar CHAR(1);
			SET @RandomChar = CHAR(65 + CAST(RAND() * 26 AS INT)); -- Sinh ngẫu nhiên một ký tự chữ cái từ A đến Z
			SET @ProductName = @ProductName + @RandomChar; -- Thêm ký tự vào tên sản phẩm



			INSERT INTO #B20Item (Code, Name_)
			VALUES (CONCAT('I', @Result), @ProductName);

			INSERT INTO #B20Customer (Code)
			VALUES (CONCAT(@ProductName, @Result));

			SET @val = @val + 1;

			
	END
	

	--select * 
	--from #B20Item
	--join #B20Customer
	--	on #B20Item.Code = #B20Customer.Code

------d.	Xóa các dữ liệu trùng lập mã trong các bảng B20Item, B20Customer, giữ lại một trong các dữ liệu trùng mã đó.
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Code ORDER BY (SELECT NULL)) AS RowNumber
	into #temp
    FROM #B20Item;
	DELETE FROM #temp WHERE RowNumber > 1;
	

	SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Code ORDER BY (SELECT NULL)) AS RowNumber
	into #temp1
    FROM #B20Customer;
	DELETE FROM #temp1 WHERE RowNumber > 1;

	

	UPDATE #B20Prices
	SET Amount = (CONVERT(INT, RAND() * 1501) + 1000) * 1000
	WHERE EffectiveDate = '2014-01-01';

	--select *
	--from #B20Prices;

--e.	Bổ sung giá bán của tất các mặt hàng, với giá bán ngày 1/1/2014 là giá ngẫu nhiên không dưới 
--500.000 và không lớn hơn 2.000.000. Giá bán là bội số của 1000.
	
	INSERT INTO #B20Prices (ItemCode, EffectiveDate, Amount)
	VALUES 
		('IT001', '2013-01-01', 100),
		('IT002', '2013-01-01', 150),
		('IT003', '2015-01-01', 200),
		('IT001', '2013-02-01', 110),
		('IT002', '2013-02-01', 160),
		('IT003', '2013-02-01', 210),
		('IT001', '2013-03-01', 120),
		('IT002', '2013-03-01', 170),
		('IT003', '2013-03-01', 220);

	-- Chèn dữ liệu vào bảng #B20Item
	INSERT INTO #B20Item (Code, Name_)
	VALUES 
		('IT001', N'Máy tính'),
		('IT002', N'Máy in'),
		('IT003', N'Máy scan');

	

	insert into  #B20Prices (ItemCode, EffectiveDate, Amount)
	select Code, '2014-01-01', FLOOR(RAND() * (2000 - 500 + 1) + 500) / 1000 * 1000
	from #B20Item ;

	UPDATE #B20Prices
	SET Amount = FLOOR(RAND() * (2000 - 500 + 1) + 500) / 1000 * 1000
	WHERE EffectiveDate = '2014-01-01';

	--SELECT *
	--FROM #B20Prices;

	--RAND() * (2000 - 500 + 1): Điều này tạo ra một số ngẫu nhiên trong phạm vi từ 0 đến 1501.

	--RAND() * (2000 - 500 + 1) + 500: Để dịch chuyển phạm vi từ 0 đến 1501 lên phạm vi từ 500 đến 2000, 
	--chúng ta cộng thêm 500. Kết quả là một số ngẫu nhiên trong phạm vi từ 500 đến 2000.


--f.	Bổ sung các giá bán của các mặt hàng chưa khai báo giá bán vào ngày 1/1/2015, 
--giá bán mới bằng giá bán gần nhất trước ngày 1/1/2015 và cộng thêm 10%.
	
--	UPDATE #B20Prices
--SET Amount = (SELECT TOP 1 Amount FROM #B20Prices WHERE EffectiveDate < '2015-01-01' ORDER BY EffectiveDate DESC) * 1.1
--WHERE EffectiveDate = '2015-01-01' AND ItemCode NOT IN (SELECT ItemCode FROM #B20Prices WHERE EffectiveDate < '2015-01-01');


	--- KIẾM MẶT HÀNG CHƯA ĐƯỢC KHAI BÁO GIÁ NGÀY 1/1/2015
	with #tmp as (
		SELECT distinct  code
		FROM #B20Item TB1	JOIN #B20Prices TB2
			ON TB1.Code = TB2.ItemCode
		WHERE EffectiveDate <> '2015-01-01')

	SELECT *
	INTO #TMP2
	FROM #B20Item TEMP
	WHERE EXISTS (SELECT * 
					FROM #tmp
					WHERE Code = TEMP.Code);
	
	-- LẤY GIÁ CỦA CÁC MẶT HÀNG TRƯỚC NGÀY 1/1/2015
	
	Select top 1 with ties code, max (Name_) Name_ ,  EffectiveDate, Amount
	into #TMP3
	FROM #TMP2
	JOIN #B20Prices 
		ON #TMP2.Code = #B20Prices.ItemCode
	WHERE EffectiveDate < '2015-01-01'
	group by code, EffectiveDate, Amount
	order by ROW_NUMBER () over (partition by code order by code, EffectiveDate desc)


	--select *
	--from #TMP3;
	-- show  file giá tiền của từng sản phẩm, có nhiều version nhưng mình sẽ lấy ra version mới nhất gần nhất
	--select *
	--from #TMP3;


	--- lúc chưa insert
	--select *
	--from #B20Prices

	-------------------- end
	insert into #B20Prices(ItemCode, EffectiveDate, Amount)
	select code, '2015-1-1', Amount * 1.1
	from #TMP3;

	select *
	from #B20Prices


end
go 
exec usp_FILE6_1

