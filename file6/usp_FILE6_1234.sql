
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

end
go 
exec usp_FILE6_1

