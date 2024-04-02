
--7.	Nhân viên vào làm 13/01/1983, nghỉ việc đến thời hiện tại. 
--Hãy tính thâm niên nhân viên bao nhiêu ngày, bao nhiêu tháng, bao nhiêu năm.

DROP PROC IF EXISTS usp_FILE5_7
GO
CREATE PROC usp_FILE5_7
	@_Date DATE
AS
BEGIN
	--DECLARE @_Date DATE = '1983-01-13';
	DECLARE @_CurrentDate DATE = GETDATE();


	DECLARE @_SoNgay INT = DATEDIFF(DAY, @_Date, @_CurrentDate)

	DECLARE @_SoNam INT;
	DECLARE @_SoThang INT;
	DECLARE @_SoNgayConLai INT;

	-- Tính số năm
	SET @_SoNam = @_SoNgay / 365;
	SET @_SoNgayConLai = @_SoNgay % 365;

	-- Tính số tháng
	SET @_SoThang = @_SoNgayConLai / 30;
	SET @_SoNgayConLai = @_SoNgayConLai % 30;

	-- Kết quả
	SELECT N'Tổng số năm: ' + CAST(@_SoNam AS NVARCHAR(10)) AS SoNam,
		   N'Tổng số tháng: ' + CAST(@_SoThang AS NVARCHAR(10)) AS SoThang,
		   N'Số ngày: ' + CAST(@_SoNgayConLai AS NVARCHAR(10)) AS SoNgayConLai;
END

GO
EXEC usp_FILE5_7  '1-13-1983'

