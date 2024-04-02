
--2.2	Tìm 10 khách hàng có doanh số bán nhiều nhất trong khoảng thời gian từ ‘01/01/2013’ đến ‘31/01/2013’

DROP PROCEDURE IF EXISTS usp_FILE1_2
GO 
CREATE PROCEDURE usp_FILE1_2
	@TuNgay NVARCHAR(500),
	@DenNgay NVARCHAR(500)
as 
BEGIN
	DECLARE @sql NVARCHAR(MAX);
	SET @sql = '
	select top 10 DmDt.Ma_Dt, sum(So_Luong*Tien)
	from BanHang BH
	join DmDt 
		on BH.Ma_Dt = DmDt.Ma_Dt
	where Ngay_Ct between '''+ @TuNgay+''' and ''' + @DenNgay + '''
	group by DmDt.Ma_Dt
	order by sum(So_Luong*Tien) desc';
	EXEC sp_executesql @sql;
end
GO
EXEC usp_FILE1_2 '2013-01-01', '2013-01-31';