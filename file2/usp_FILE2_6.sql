DROP PROC IF EXISTS usp_FILE2_6
GO
CREATE PROC usp_FILE2_6
AS
BEGIN
	CREATE TABLE #tblResource(
	Date_ Date ,
	Code varchar (MAX),
	Name_ nvarchar (MAX));

	INSERT INTO #tblResource (Date_, Code, Name_)
	VALUES
		('2013-01-01', 'A', 'Mr.Nam'),
		('2013-05-15', 'A', 'Mr.Tung'),
		('2013-02-01', 'B', 'Mrs.Lam'),
		('2013-04-30', 'B', 'Mrs.Hoa'),
		('2013-04-12', 'C', 'Ms.Hanh'),
		('2013-06-23', 'C', 'Ms.Han'),
		('2013-08-30', 'C', 'Ms.Huong');
	CREATE TABLE #tblResource1(
	Date_ Date ,
	Code varchar (MAX),
	);
	INSERT INTO #tblResource1 (Date_, Code)
	VALUES
		('2013-01-01', 'A'),
		('2013-03-11', 'A'),
		('2013-06-15', 'A'),
		('2013-01-01', 'B'),
		('2013-02-14', 'B'),
		('2013-05-02', 'B'),
		('2013-02-11', 'C'),
		('2013-04-18', 'C'),
		('2013-08-17', 'C');

	

	SELECT TB1.Date_ AS DATE1, TB1.Code, Name_, TB2.Date_ AS DATE2
	INTO #TMP
	FROM #tblResource TB1
	LEFT JOIN #tblResource1 TB2
		ON TB1.Code = TB2.Code AND TB1.Date_ < TB2.Date_
	WHERE TB2.Code IS NOT NULL;
	
	SELECT *, ROW_NUMBER ()OVER (ORDER BY (SELECT NULL)) AS COUNT_
	INTO #TMP1
	FROM #TMP;

	SELECT * ,ROW_NUMBER ()OVER (ORDER BY (SELECT NULL)) AS COUNT_
	INTO #TMP2
	FROM #tblResource1 TB2;

	
	SELECT  TB2.Date_, TB2.Code,
	CASE
		WHEN TB2.Date_ BETWEEN TB1.DATE1 AND TB1.DATE2 THEN TB1.Name_
		
	END AS HI
	FROM #TMP1 TB1
	JOIN #TMP2 TB2
		ON TB1.Code = TB2.Code AND TB1.COUNT_ = TB2.COUNT_


	DROP TABLE #tblResource;
	DROP TABLE #tblResource1;
end
GO
EXEC usp_FILE2_6