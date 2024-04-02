
--5.	Thống kê doanh số bán hàng của từng nhân viên kinh doanh trong tháng 9/2010 
--và tổng doanh số của phòng kinh doanh là bao nhiêu. ( 1.5% trên tổng số tiền kí hoá đơn của từng nhân viên) .

DROP PROC IF EXISTS usp_FILE3_5
GO
CREATE PROC usp_FILE3_5
AS
BEGIN
	CREATE TABLE #HOADON
	(
		Ngay_Ct date,
		So_Ct int,
		SOLUONG INT,
		Ma_SP varchar (50),
		Ma_NV varchar (50)
	);
	CREATE TABLE #SANPHAM
	(
		Ma_SP VARCHAR (50),
		TEN_SP NVARCHAR (MAX),
		GIASP DECIMAL(10, 2)
	);
	CREATE TABLE #NHANVIEN
	(
		Ma_NV varchar (50),
		TeN_NV NVARCHAR (MAX)
	);


	-- Chèn dữ liệu vào bảng #SANPHAM (một số dữ liệu mẫu)
	INSERT INTO #SANPHAM (Ma_SP, TEN_SP, GIASP)
	VALUES 
	('SP001', N'Sản phẩm A', 1000.50),
	('SP002', N'Sản phẩm B', 2000.75),
	('SP003', N'Sản phẩm C', 1500.25),
	('SP004', N'Sản phẩm D', 1800.00),
	('SP005', N'Sản phẩm E', 2200.00);

	-- Chèn dữ liệu vào bảng #NHANVIEN (một số dữ liệu mẫu)
	INSERT INTO #NHANVIEN (Ma_NV, TeN_NV)
	VALUES 
	('NV001', N'Nhân viên A'),
	('NV002', N'Nhân viên B'),
	('NV003', N'Nhân viên C'),
	('NV004', N'Nhân viên D'),
	('NV005', N'Nhân viên E');

	-- Chèn dữ liệu vào bảng #HOADON với Ngay_Ct nằm trong tháng 9 năm 2010
	INSERT INTO #HOADON (Ngay_Ct, So_Ct, SOLUONG, Ma_SP, Ma_NV)
	VALUES 
	('2010-09-01', 1, 5, 'SP001', 'NV001'),
	('2010-09-02', 2, 3, 'SP002', 'NV002'),
	('2010-09-03', 3, 2, 'SP003', 'NV003'),
	('2010-09-04', 4, 4, 'SP004', 'NV004'),
	('2010-09-05', 5, 1, 'SP005', 'NV005');
	
	
	SELECT  NV.Ma_NV, MAX (TeN_NV) TeN_NV, SUM (SOLUONG * GIASP) DOANHSO
	INTO #TMP
	FROM #HOADON HD 
	JOIN #NHANVIEN NV
		ON HD.Ma_NV = NV.Ma_NV
	JOIN #SANPHAM SP 
		ON SP.Ma_SP = HD.Ma_SP
	WHERE MONTH(Ngay_Ct) =9  AND YEAR (Ngay_Ct) = 2010
	GROUP BY NV.Ma_NV;


	SELECT * FROM #TMP

	SELECT SUM(DOANHSO) * 1.5
	FROM #TMP

	DROP TABLE #HOADON;
	DROP  TABLE #NHANVIEN;
	DROP TABLE #SANPHAM;
	DROP TABLE #TMP;

END

GO
EXEC usp_FILE3_5