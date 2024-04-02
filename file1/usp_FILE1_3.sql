
--2.3	Tìm mặt hàng nào bán chạy nhất trong khoảng thời gian từ ‘01/01/2013’ đến ‘31/01/2013’

select DmVt.Ma_Vt, sum(So_Luong)
from BanHang bh
join DmVt 
	on bh.Ma_Vt = DmVt.Ma_Vt
where Ngay_Ct between '1/1/2013' and  '1/31/2013'
group by DmVt.Ma_Vt
having sum(So_Luong) = (select top 1 sum(So_Luong)
						from BanHang bh
						join DmVt 
							on bh.Ma_Vt = DmVt.Ma_Vt
						group by DmVt.Ma_Vt 
						order by sum(So_Luong) desc)

GO

DROP PROC IF EXISTS usp_FILE1_3
GO
CREATE PROC usp_FILE1_3
	@TuNgay NVARCHAR (500),
	@DenNgay NVARCHAR (500)
as
BEGIN
	DECLARE @sql nvarchar (MAX);
	SET @sql = '
	select DmVt.Ma_Vt, sum(So_Luong)
	from BanHang bh
	join DmVt 
		on bh.Ma_Vt = DmVt.Ma_Vt
	where Ngay_Ct between '''+ @TuNgay+''' and ''' + @DenNgay + '''
	group by DmVt.Ma_Vt
	having sum(So_Luong) = (select top 1 sum(So_Luong)
							from BanHang bh
							join DmVt 
								on bh.Ma_Vt = DmVt.Ma_Vt
							group by DmVt.Ma_Vt 
							order by sum(So_Luong) desc)';
	EXEC sp_executesql @sql;
end
GO
EXEC usp_FILE1_3 '2013-01-01', '2013-01-31';

