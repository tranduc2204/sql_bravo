--1.	Liệt kê ra các mặt hàng thuộc nhóm Hàng Hoá
DROP PROC IF EXISTS usp_FILE3_1
GO
CREATE PROC usp_FILE3_1
AS
BEGIN
	CREATE TABLE #MatHang
	(
		ID INT IDENTITY PRIMARY KEY,
		TemMH Nvarchar (MAX),
		ID_Loai int
	);
	CREATE TABLE #LoaiMatHang
	(
		ID INT IDENTITY PRIMARY KEY,
		TenLoaiMatHang nvarchar (max)
	);

	-- Chèn dữ liệu vào bảng #LoaiMatHang
	INSERT INTO #LoaiMatHang (TenLoaiMatHang)
	VALUES (N'Loại mặt hàng A'), (N'Hàng Hóa'), (N'Hàng Hóa'), (N'Loại mặt hàng D'), (N'Loại mặt hàng E');

	-- Chèn dữ liệu vào bảng #MatHang, mỗi mặt hàng sẽ trỏ đến một loại mặt hàng cụ thể
	INSERT INTO #MatHang (TemMH, ID_Loai)
	VALUES 
	(N'Mặt hàng 1', 1), 
	(N'Mặt hàng 2', 2), 
	(N'Mặt hàng 3', 3), 
	(N'Mặt hàng 4', 4), 
	(N'Mặt hàng 5', 5);

	-- lấy thông tin của tất cả loại mặt hàng
	SELECT * 
	FROM #LoaiMatHang;
	-- lấy thông tin của các mặt hàng
	SELECT * 
	FROM #MatHang;

	--- câu giải
	SELECT * 
	FROM #MatHang MH
	JOIN #LoaiMatHang LMH
		ON MH.ID_Loai = LMH.ID
	WHERE TenLoaiMatHang LIKE N'Hàng Hóa';

	DROP TABLE #MatHang;
	DROP TABLE #LoaiMatHang;
END

GO
EXEC usp_FILE3_1