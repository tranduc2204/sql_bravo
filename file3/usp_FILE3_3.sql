
--3.	Liệt kê ra các hoá đơn do NV kinh doanh Nguyễn Văn A bán vào tháng 9/2010. (Ngay_Ct, So_Ct, Ma_CbNv, Ten_CbNv, Tong_Tien)

DROP PROC IF EXISTS usp_FILE3_3
GO
CREATE PROC usp_FILE3_3
AS
BEGIN
	CREATE TABLE #HOADON
	(
		Ngay_Ct date,
		So_Ct int,
		DienGiai0 text,
		DoanhThu DECIMAL(10, 2),
		TienThue DECIMAL(10, 2),
		Ma_CbNv varchar (50)
	);
	CREATE TABLE #NHANVIEN
	(
		Ma_CbNv varchar (50),
		Ten_CbNv NVARCHAR (MAX)
 	)

	-- Chèn dữ liệu vào bảng #NHANVIEN
	INSERT INTO #NHANVIEN (Ma_CbNv, Ten_CbNv)
	VALUES 
	('NV001', N'Nguyễn Văn A'),
	('NV002', N'Trần Thị B'),
	('NV003', N'Lê Văn C'),
	('NV004', N'Hoàng Thị D'),
	('NV005', N'Phạm Văn E');

	-- Chèn dữ liệu vào bảng #HOADON
	INSERT INTO #HOADON (Ngay_Ct, So_Ct, DienGiai0, DoanhThu, TienThue, Ma_CbNv)
	VALUES 
	('2010-09-06', 1, N'Mua hàng A', 1000.50, 100.25, 'NV001'),
	('2010-09-06', 2, N'Mua hàng B', 2000.75, 150.50, 'NV001'),
	('2024-03-07', 3, N'Mua hàng C', 1500.25, 120.00, 'NV003'),
	('2024-03-07', 4, N'Mua hàng D', 1800.00, 160.75, 'NV004'),
	('2024-03-08', 5, N'Mua hàng E', 2200.00, 200.00, 'NV005');


	SELECT Ngay_Ct, So_Ct, NV.Ma_CbNv, Ten_CbNv, (DoanhThu - TienThue) AS Tong_Tien
	FROM #HOADON HD
	JOIN #NHANVIEN NV
		ON HD.Ma_CbNv = NV.Ma_CbNv
	WHERE MONTH(Ngay_Ct) =9  AND YEAR (Ngay_Ct) = 2010 AND Ten_CbNv LIKE N'Nguyễn Văn A' ;


END
GO
EXEC usp_FILE3_3