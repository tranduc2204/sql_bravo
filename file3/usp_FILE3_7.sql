
--7.	Liệt kê ra các nhân viên chờ nghỉ hưu ( nam >=55 và nữ >=50) .

-- NAM 60 NGHỈ NỮ 60

DROP PROC IF EXISTS usp_FILE3_7
GO
CREATE PROC usp_FILE3_7
AS
BEGIN
	CREATE TABLE #NHANVIEN
	(
		ID INT IDENTITY,
		MANV VARCHAR (MAX),
		TENNV NVARCHAR (MAX),
		TUOI INT,
		GIOITINH BIT
	)
	INSERT INTO #NHANVIEN (MANV, TENNV, TUOI, GIOITINH)
	VALUES 
		('NV001', N'Nguyễn Văn A', 56, 1), -- Giới tính nam (1: true)
		('NV002', N'Trần Thị B', 51, 0),    -- Giới tính nữ (0: false)
		('NV003', N'Lê Văn C', 55, 1),
		('NV004', N'Hồ Thị D', 11, 0),
		('NV005', N'Phạm Văn E', 32, 1);

	
	SELECT 
		CASE 
			WHEN GIOITINH = 1 AND TUOI >= 55
				THEN MANV
			WHEN  GIOITINH = 0 AND TUOI >= 50
				THEN MANV
		END AS MANV, TENNV
	INTO #TB
	FROM #NHANVIEN;
	
	SELECT *
	FROM #TB;
	SELECT * 
	FROM #TB 
	WHERE #TB.MANV IS NOT NULL ;

	DROP TABLE #TB;
	DROP TABLE #NHANVIEN;


	
END

GO
EXEC usp_FILE3_7
