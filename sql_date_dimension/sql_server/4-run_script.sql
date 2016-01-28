SELECT 'DB Name: ' + DB_NAME();

DECLARE @StartDate DATETIME
DECLARE @EndDate DATETIME

SET @StartDate = '2010-01-01' --'01/FEB/14'
SET @EndDate =  '2030-12-31' --'16/MAR/14'


exec pop_time_dimension @StartDate, @EndDate;
exec pop_todate_tables;
