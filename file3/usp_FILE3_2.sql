
--2.	Liệt kê ra các hoá đơn trong tháng 9/2010 (Ngay_Ct, So_Ct, Dien_Giai0, Doanh thu, tiền thuế, Tổng tiền).

DROP PROC IF EXISTS usp_FILE3_2
GO 
CREATE PROC usp_FILE3_2
AS
BEGIN
	CREATE TABLE #HOADON
	(
		Ngay_Ct date,
		So_Ct int,
		DienGiai0 ntext,
		DoanhThu DECIMAL(10, 2),
		TienThue DECIMAL(10, 2)
	)
	-- Chèn dữ liệu vào bảng #HOADON
	INSERT INTO #HOADON (Ngay_Ct, So_Ct, DienGiai0, DoanhThu, TienThue)
	VALUES 
	('2010-09-06', 1001, N'Hóa đơn số 1001', 500.75, 75.50),
	('2010-09-02', 1002, N'Hóa đơn số 1002', 800.00, 120.00),
	('2024-03-08', 1003, N'Hóa đơn số 1003', 1200.50, 180.08),
	('2024-03-09', 1004, N'Hóa đơn số 1004', 1500.25, 225.03),
	('2024-03-10', 1005, N'Hóa đơn số 1005', 2000.00, 300.00);


	SELECT *, DoanhThu- TienThue as TongTien
	FROM #HOADON
	WHERE MONTH(Ngay_Ct) =9  AND YEAR (Ngay_Ct) = 2010 ;


	DROP TABLE #HOADON;
END
GO 
EXEC usp_FILE3_2