SELECT 'DB Name: ' + DB_NAME();

IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'pop_todate_tables')
BEGIN
	DROP  Procedure  pop_todate_tables
END
GO

CREATE PROCEDURE pop_todate_tables 
AS

BEGIN 
    
    INSERT INTO ytd_by_month
				(month_id, ytd_month_id )
			(SELECT DISTINCT a.month_id , b.month_id
				FROM time_dimension a, time_dimension b
			  WHERE a.yr = b.yr
			    AND a.month_id >= b.month_id);
    
    INSERT INTO ytd_by_quarter
				(quarter_id,ytd_quarter_id )
			(SELECT DISTINCT a.quarter_id , b.quarter_id
				FROM time_dimension a, time_dimension b
			  WHERE a.yr = b.yr
			    AND a.quarter_id >= b.quarter_id);
	
	INSERT INTO ytd_by_day
				(day, ytd_day )
			(SELECT DISTINCT a.d , b.d
				FROM time_dimension a, time_dimension b
			  WHERE a.yr = b.yr
			    AND a.d >= b.d);
	
	INSERT INTO qtd_by_month
				(month_id, qtd_month )
			(SELECT DISTINCT  a.month_id, b.month_id
				FROM time_dimension a, time_dimension b
			  WHERE a.yr = b.yr
				 AND a.quarter_id = b.quarter_id
				 AND a.month_id >= b.month_id);
	
	INSERT INTO qtd_by_day
				(day, qtd_day )
			(SELECT DISTINCT  a.d, b.d
				FROM time_dimension a, time_dimension b
			  WHERE a.yr = b.yr
				 AND a.quarter_id = b.quarter_id
				 AND a.d >= b.d);
	
	INSERT INTO mtd_by_day
				(day, mtd_day )
			(SELECT DISTINCT  a.d, b.d
				FROM time_dimension a, time_dimension b
			  WHERE a.yr = b.yr
				 AND a.month_id = b.month_id
				 AND a.d >= b.d);		  
			  		  		
END
GO

