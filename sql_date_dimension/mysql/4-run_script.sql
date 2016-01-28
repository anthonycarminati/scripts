SELECT CURRENT_USER(), SCHEMA();

SET @StartDate = '2010-01-01';
SET @EndDate =  '2020-12-31';


call pop_time_dimension (@StartDate, @EndDate);
call pop_todate_tables ();
