
--i.	Tìm khách hàng có doanh số mua nhiều nhất trong 2 tháng liền trong năm 2014
--------------------------- TEST NGÀY 16/3/2024 SAI KẾT QUẢ

DROP PROC IF EXISTS usp_FILE5P2_i
GO 
CREATE PROC usp_FILE5P2_i
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
		('C008', N'Khách Hàng H'),
		('C011', N'Khách Hàng tRẦN đỨC');
	
--i.	Tìm khách hàng có doanh số mua nhiều nhất trong 2 tháng liền trong năm 2014

	SELECT CODE,MAX (Name) ten, MONTH(DocDate) thang, YEAR (DocDate) nam,SUM(Quantity * Amount) DOANHSO,
	ROW_NUMBER () OVER (PARTITION BY MONTH(DocDate), YEAR (DocDate) ORDER BY SUM(Quantity * Amount) DESC) AS RANK
	INTO #TMP
	FROM #B30AccDocSales TB1
	JOIN #B20Customer TB2 
		ON TB1.CustomerCode = TB2.Code
	GROUP BY CODE, MONTH(DocDate), YEAR (DocDate);
	
	select *
	from #TMP;

	select code, ten, thang, nam, DOANHSO
	into #TMP1
	from #TMP
	where rank =1 and nam = 2014;
	
	select * , ROW_NUMBER () over (partition by thang, nam order by doanhso desc) as rank
	into #TMP2         ---- tiếp tục đánh id để check xem ai có rank hơn 2 nếu rank hơn 2 thì lấy id ròi show ra
	from #TMP1;


	SELECT *
	FROM #TMP2
	where code in (
	SELECT Code
	FROM #TMP2
	WHERE rank >= 2);

	DROP TABLE #B20Customer;
	DROP TABLE #B20Dept;
	DROP TABLE #B20Employee;
	DROP TABLE #B30AccDocSales;

	
END
GO
EXEC usp_FILE5P2_i
