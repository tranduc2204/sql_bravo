
--a.	Tính số lượng, doanh số bán hàng của từng nhân viên trong từng tháng của năm 2014

DROP PROC IF EXISTS usp_FILE5P2_a
GO 
CREATE PROC usp_FILE5P2_a
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
		(1, '2023-01-01', 'IT001', 'C001', 'E001', 'D001', 5, 1000.00),
		(2, '2023-01-02', 'IT002', 'C002', 'E002', 'D002', 3, 500.00),
		(3, '2023-01-03', 'IT003', 'C003', 'E003', 'D003', 4, 800.00),
		(4, '2023-01-04', 'IT004', 'C004', 'E004', 'D004', 6, 1200.00),
		(5, '2023-01-05', 'IT005', 'C005', 'E005', 'D005', 2, 400.00),
		(6, '2023-01-06', 'IT006', 'C006', 'E006', 'D006', 7, 1400.00),
		(7, '2023-01-07', 'IT007', 'C007', 'E007', 'D007', 4, 800.00),
		(8, '2023-01-08', 'IT008', 'C008', 'E008', 'D008', 5, 1000.00),
		(9, '2023-01-09', 'IT009', 'C009', 'E009', 'D009', 3, 600.00),
		(10, '2023-01-10', 'IT010', 'C010', 'E010', 'D010', 6, 1200.00);

	CREATE TABLE #B20Dept (
		Code VARCHAR(50),
		Name NVARCHAR(255)
	);

	INSERT INTO #B20Dept (Code, Name)
	VALUES
		('D001', N'Phòng Kinh Doanh'),
		('D002', N'Phòng Marketing'),
		('D003', N'Phòng Kế Toán'),
		('D004', N'Phòng Nhân Sự'),
		('D005', N'Phòng IT'),
		('D006', N'Phòng Kỹ Thuật'),
		('D007', N'Phòng Quản Lý'),
		('D008', N'Phòng Hành Chính'),
		('D009', N'Phòng Sản Xuất'),
		('D010', N'Phòng Dịch Vụ');

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
		('C008', N'Khách Hàng H');
	
	
	--a.	Tính số lượng, doanh số bán hàng của từng nhân viên trong từng tháng của năm 2014
	SELECT TB2.Code , MAX (TB2.Name) Name , SUM (Quantity) Quantity, SUM (Amount) Amount
	FROM #B30AccDocSales TB1 
	JOIN #B20Employee TB2 
		ON TB1.EmployeeCode = TB2.Code
	GROUP BY TB2.Code;



	DROP TABLE #B20Customer;
	DROP TABLE #B20Dept;
	DROP TABLE #B20Employee;
	DROP TABLE #B30AccDocSales;

	
END
GO
EXEC usp_FILE5P2_a