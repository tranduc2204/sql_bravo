
--10.	Dùng câu truy vấn SQL thêm vào bảng #tblCt các filed Ten_Vt, Ten_Kho, Ten_Dt.

DROP PROC IF EXISTS  usp_FILE3_10
GO
CREATE PROC usp_FILE3_10
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

	ALTER TABLE #tblCt
	ADD Ten_Vt NVARCHAR (MAX);

	ALTER TABLE #tblCt
	ADD Ten_KHO NVARCHAR (MAX);
	ALTER TABLE #tblCt
	ADD Ten_Dt NVARCHAR (MAX);

	SELECT *
	FROM #tblCt
	
END
GO
EXEC usp_FILE3_10
