
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
	

	select * 
	from #B20Item
	join #B20Customer
		on #B20Item.Code = #B20Customer.Code


end
go 
exec usp_FILE6_1

