
--8.	Tạo một TABLE tạm #tblCt bằng câu lệnh CREATE gồm các field :
--Ma_Ct, Ngay_ct, So_Ct, Ma_Vt, So_Luong, Don_Gia, Thanh_tien, Ma_Kho, Ma_Dt, Ma_Nx, Ma_Tte kiểu dữ liệu giống như chương trình BRAVO.

DROP PROC IF EXISTS usp_FILE3_8_VA_9
GO 
CREATE PROC usp_FILE3_8_VA_9
AS
BEGIN
	CREATE TABLE #tblCt
	(
		Ma_Ct VARCHAR (20),
		Ngay_ct DATE,
		So_Ct INT , 
		Ma_Vt VARCHAR (20),
		So_Luong INT, 
		Don_Gia DECIMAL(10, 2), 
		Thanh_tien DECIMAL(10, 2),
		Ma_Kho VARCHAR (20),
		Ma_Dt VARCHAR (20),
		Ma_Nx VARCHAR (20),
		Ma_Tte VARCHAR (20)
	)
	INSERT INTO #tblCt (Ma_Ct, Ngay_ct, So_Ct, Ma_Vt, So_Luong, Don_Gia, Thanh_tien, Ma_Kho, Ma_Dt, Ma_Nx, Ma_Tte)
	VALUES 
	('CT001', '2024-03-06', 1, 'VT001', 5, 1000.50, 5002.50, 'KHO001', 'DT001', 'NX001', 'TTE001'),
	('CT002', '2024-03-06', 2, 'VT002', 3, 2000.75, 6020.25, 'KHO002', 'DT002', 'NX002', 'TTE002'),
	('CT003', '2024-03-07', 3, 'VT003', 2, 1500.25, 3000.50, 'KHO003', 'DT003', 'NX003', 'TTE003'),
	('CT004', '2024-03-07', 4, 'VT004', 4, 1800.00, 7200.00, 'KHO004', 'DT004', 'NX004', 'TTE004'),
	('CT005', '2024-03-08', 5, 'VT005', 1, 2200.00, 2200.00, 'KHO005', 'DT005', 'NX005', 'TTE005');

	SELECT * FROM #tblCt;

	DROP TABLE #tblCt

END
GO 
EXEC usp_FILE3_8_VA_9;