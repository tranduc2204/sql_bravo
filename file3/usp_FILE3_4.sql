
--4.	Liệt kê ra 3 mặt hàng bán chạy nhất trong tháng 9/2010. ( nhiều người mua nhất; Ma_Vt, Ten_Vt, Sl_Ban, Tong_Tien).
-- 3 MẶT HÀNG THÌ PHẢI SUM LẠI SỐ LƯỢNG

DROP PROC IF EXISTS usp_FILE3_4
GO
CREATE PROC usp_FILE3_4
AS
BEGIN
	CREATE TABLE #HOADON
	(
		Ngay_Ct date,
		So_Ct int,
		SOLUONG INT,
		Ma_SP varchar (50)
	);
	CREATE TABLE #SANPHAM
	(
		Ma_SP VARCHAR (50),
		TEN_SP NVARCHAR (MAX),
		GIASP DECIMAL(10, 2)
	)

	-- Chèn dữ liệu vào bảng #SANPHAM
	INSERT INTO #SANPHAM (Ma_SP, TEN_SP, GIASP)
	VALUES 
	('SP001', N'Sản phẩm A', 1000.50),
	('SP002', N'Sản phẩm B', 2000.75),
	('SP003', N'Sản phẩm C', 1500.25),
	('SP004', N'Sản phẩm D', 1800.00),
	('SP005', N'Sản phẩm E', 2200.00),
	('SP006', N'Sản phẩm F', 1300.00),
	('SP007', N'Sản phẩm G', 2400.50),
	('SP008', N'Sản phẩm H', 1750.75),
	('SP009', N'Sản phẩm I', 1900.25),
	('SP010', N'Sản phẩm J', 2050.00);

	-- Chèn dữ liệu vào bảng #HOADON
	INSERT INTO #HOADON (Ngay_Ct, So_Ct, SOLUONG, Ma_SP)
	VALUES 
	('2010-09-06', 1, 5, 'SP001'),
	('2010-09-06', 2, 3, 'SP002'),
	('2010-09-06', 3, 2, 'SP003'),
	('2010-09-06', 4, 4, 'SP005'),
	('2010-09-06', 5, 1, 'SP005'),
	('2010-09-06', 6, 3, 'SP005'),
	('2010-09-06', 7, 2, 'SP007'),
	('2010-09-06', 8, 4, 'SP008'),
	('2010-09-06', 9, 1, 'SP009'),
	('2010-09-06', 10, 5, 'SP010');

	SELECT TOP 3 WITH TIES SP.Ma_SP, MAX(TEN_SP) TEN_SP, SUM (SOLUONG) SOLUONG, SUM (SOLUONG * GIASP)  Tong_Tien
	FROM #HOADON HD 
	JOIN #SANPHAM SP
		ON HD.Ma_SP = SP.Ma_SP
	WHERE MONTH(Ngay_Ct) =9  AND YEAR (Ngay_Ct) = 2010
	GROUP BY SP.Ma_SP
	ORDER BY SOLUONG DESC;
	
	SELECT *
	FROM #HOADON

	DROP TABLE #HOADON;
	DROP TABLE #SANPHAM;
END 
GO 
EXEC usp_FILE3_4