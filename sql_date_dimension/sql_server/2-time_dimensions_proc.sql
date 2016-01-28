SELECT 'DB Name: ' + DB_NAME();

if object_id('dbo.pop_time_dimension', 'p') is null
    exec ('create procedure pop_time_dimension(@p_start DATE, @p_end DATE) as select 1 a')
go

Alter PROCEDURE pop_time_dimension (@p_start DATE, @p_end DATE)
AS
DECLARE @curr_date DATE;
SET @curr_date=@p_start;

WHILE @curr_date <= @p_end
BEGIN 
    INSERT time_dimension
		(d,day_of_month,month_id, last_month_id,month_abbr,month_name,
		 month_nbr,yr, last_yr, quarter_nbr,quarter_id,first_day_of_month_ind,
		 last_day_of_month_ind,day_of_week)
VALUES( @curr_date, -- as day,
	   day(@curr_date), -- as day_of_month,
	   cast(YEAR(@curr_date)as varchar(4)) + Right('0' +cast(MONTH(@curr_date) as varchar(2)),2), -- as month_id,
	   cast(YEAR(DATEADD(MM, -1,@curr_date))as varchar(4)) + Right('0' +cast(MONTH(DATEADD(MM, -1,@curr_date)) as varchar(2)),2), -- as month_id,
	   Left(DATENAME(MONTH, @curr_date), 3), -- as month_abbr,
	   DATENAME(MONTH, @curr_date), -- as month_name,
	   MONTH(@curr_date), -- as month_nbr, 
	   YEAR(@curr_date), -- as year,
	   YEAR(@curr_date)-1, -- as last_year,
	   floor((MONTH(@curr_date)-1)/3) +1, -- as quarter_nbr, 
	   cast(YEAR(@curr_date)as varchar(4)) + cast(floor(((MONTH(@curr_date)-1)/3) +1)  as varchar(1)), -- as quarter_id,
	   CASE WHEN day(@curr_date) = 1 then 'Y' else 'N' END, -- as first_day_of_month_ind ,
	   CASE WHEN eomonth(@curr_date) = @curr_date then 'Y' else 'N' END, -- as last_day_of_month_ind,
	   Left(DATENAME(weekDAY, @curr_date), 3)); -- as day_of_week  
   
    SET @curr_date = DATEADD(day,1,@curr_date);
END 
GO

