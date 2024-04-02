﻿
--j.	Tìm bộ phận bán hàng có doanh số bán thấp hơn mức bán trung bình của các bộ phận trong từng tháng trong năm 2014


DROP PROC IF EXISTS usp_FILE5P2_j
GO 
CREATE PROC usp_FILE5P2_j
AS 
BEGIN
	CREATE TABLE #B30AccDocSales (
		Stt INT,
		DocDate DATE,
		ItemCode VARCHAR(50),
		CustomerCode VARCHAR(50),
		EmployeeCode VARCHAR(50),
		DeptCode VARCHAR(50),
		Quantity INT,
		Amount DECIMAL(10, 2)
	);

	INSERT INTO #B30AccDocSales (Stt, DocDate, ItemCode, CustomerCode, EmployeeCode, DeptCode, Quantity, Amount)
	VALUES
		(1, '2014-12-01', 'IT001', 'C001', 'E001', 'D001', 5, 1000.00),
		(2, '2014-12-02', 'IT002', 'C002', 'E002', 'D002', 3, 500.00),
		(3, '2014-07-03', 'IT003', 'C003', 'E002', 'D003', 4, 800.00),
		(4, '2014-01-04', 'IT004', 'C004', 'E004', 'D004', 6, 1200.00),
		(5, '2014-01-05', 'IT005', 'C005', 'E005', 'D005', 2, 400.00),
		(6, '2023-01-06', 'IT006', 'C006', 'E006', 'D006', 7, 1400.00),
		(7, '2014-07-07', 'IT007', 'C007', 'E007', 'D007', 4, 800.00),
		(8, '2023-01-08', 'IT008', 'C008', 'E008', 'D008', 5, 1000.00),
		(9, '2023-01-09', 'IT009', 'C009', 'E009', 'D009', 3, 600.00),
		(10, '2023-01-10', 'IT010', 'C010', 'E010', 'D010', 6, 1200.00);
		
	CREATE TABLE #B20Dept (
		Code VARCHAR(50),
		Name NVARCHAR(255)
	);

	INSERT INTO #B20Dept (Code, Name)
	VALUES
		('D001', N'Phòng Kinh Doanh 1'),
		('D002', N'Phòng Kinh Doanh 2'),
		('D003', N'Phòng Kinh Doanh 3'),
		('D004', N'Phòng Kinh Doanh 4'),
		('D005', N'Phòng Kinh Doanh 5'),
		('D006', N'Phòng Kinh Doanh 6'),
		('D007', N'Phòng Kinh Doanh 7'),
		('D008', N'Phòng Kinh Doanh 8'),
		('D009', N'Phòng Kinh Doanh 9'),
		('D010', N'Phòng Kinh Doanh 10');

	CREATE TABLE #B20Employee (
		Code VARCHAR(50),
		Name NVARCHAR(255),
		ManagerCode VARCHAR(50)
	);

	INSERT INTO #B20Employee (Code, Name, ManagerCode)
	VALUES
		('E001', N'Nguyễn Văn A', NULL),
		('E002', N'Trần Thị B', 'E001'),
		('E003', N'Lê Văn C', 'E001'),
		('E004', N'Phạm Thị D', 'E002'),
		('E005', N'Hoàng Văn E', 'E002'),
		('E006', N'Đặng Thị F', 'E003'),
		('E007', N'Mai Văn G', 'E003'),
		('E008', N'Vũ Thị H', 'E004'),
		('E009', N'Lý Văn I', 'E004'),
		('E010', N'Bùi Thị K', 'E005');

	CREATE TABLE #B20Customer (
		Code VARCHAR(50),
		Name NVARCHAR(255)
	);

	INSERT INTO #B20Customer (Code, Name)
	VALUES
		('C001', N'Khách Hàng A'),
		('C002', N'Khách Hàng B'),
		('C003', N'Khách Hàng C'),
		('C004', N'Khách Hàng D'),
		('C005', N'Khách Hàng E'),
		('C006', N'Khách Hàng F'),
		('C007', N'Khách Hàng G'),
		('C008', N'Khách Hàng H'),
		('C011', N'Khách Hàng tRẦN đỨC');
	
--j.	Tìm bộ phận bán hàng có doanh số bán thấp hơn mức bán trung bình của các bộ phận trong từng tháng trong năm 2014

	SELECT TB2.Code, MAX (TB2.Name), SUM(Quantity * Amount) TONG
	,(SELECT AVG (Quantity * Amount) FROM #B30AccDocSales) DOANHTHUTRB
	FROM #B30AccDocSales TB1 
	JOIN #B20Dept TB2
		ON TB1.DeptCode =  TB2.Code
	GROUP BY CODE
	HAVING  SUM(Quantity * Amount) < (SELECT AVG (Quantity * Amount) FROM #B30AccDocSales);
	



	DROP TABLE #B20Customer;
	DROP TABLE #B20Dept;
	DROP TABLE #B20Employee;
	DROP TABLE #B30AccDocSales;

	
END
GO
EXEC usp_FILE5P2_j