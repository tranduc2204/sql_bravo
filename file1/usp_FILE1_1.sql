--1.	Tạo các bảng dữ liệu sau:
--1.1	DmVt(Ma_Vt VARCHAR(16), Ten_Vt NVARCHAR(128)
--1.2	DmDt(Ma_Dt VARCHAR(16), Ten_Dt NVARCHAR(128)
--1.3	BanHang(Ngay_Ct SmallDateTime, So_Ct VARCHAR(20), Ma_Dt VARCHAR(16), Ma_Vt VARCHAR(16), So_Luong NUMERIC(18,2), 
--Tien NUMERIC(18))
--2.	Truy vấn các câu sau:
--2.1	Tìm các khách hàng có số lượng mua hàng nhiều nhất trong khoảng thời gian từ ‘01/01/2013’ đến ‘31/01/2013’
--2.2	Tìm 10 khách hàng có doanh số bán nhiều nhất trong khoảng thời gian từ ‘01/01/2013’ đến ‘31/01/2013’
--2.3	Tìm mặt hàng nào bán chạy nhất trong khoảng thời gian từ ‘01/01/2013’ đến ‘31/01/2013’


create database thuviec
go
use thuviec
go
create table DmVt
(
	Ma_Vt varchar (16), --kc
	Ten_Vt nvarchar (128)
)
go
create table DmDt -- danh mục đối tượng
(
	Ma_Dt varchar (16), -- kc
	Ten_Dt nvarchar (128)
)
go
create table BanHang 
(
	Ngay_Ct SmallDateTime, -- ngày lập chứng từ
	So_Ct varchar(20),
	Ma_Dt VARCHAR(16),  --- kg
	Ma_Vt VARCHAR(16),  -- kg
	So_Luong NUMERIC(18,2),
	Tien NUMERIC(18)
)

-- 2.1	Tìm các khách hàng có số lượng mua hàng nhiều nhất trong khoảng thời gian từ ‘01/01/2013’ đến ‘31/01/2013’

DROP PROCEDURE IF EXISTS usp_FILE1_1 
go
CREATE PROCEDURE usp_FILE1_1
	@TuNgay nvarchar(500),
	@DenNgay nvarchar(500)
as
BEGIN 
	DECLARE @sql NVARCHAR(MAX);

	--DROP TABLE IF EXISTS #BanHang
	
	SET @sql = '
	select DmDt.Ma_Dt, Ten_Dt, sum (So_Luong)
	from BanHang BH
	join DmDt 
		on BH.Ma_Dt = DmDT.Ma_Dt
	group by DmDt.Ma_Dt, Ten_Dt
	having sum(So_Luong) >= (select top 1 sum (So_Luong)
								from BanHang BH
								join DmDt 
									on BH.Ma_Dt = DmDT.Ma_Dt
								where Ngay_Ct between '''+ @TuNgay+''' and ''' + @DenNgay + '''
								group by DmDt.Ma_Dt
								order by sum (So_Luong) desc)';   
	EXEC sp_executesql @sql;
END

GO

EXEC usp_FILE1_1 '2013-01-01', '2013-01-31';
GO