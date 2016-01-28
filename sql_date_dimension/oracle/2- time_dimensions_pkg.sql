CREATE OR REPLACE 
PACKAGE DM_time_dimension_pkg 
AS                           
	 										    		 
	 PROCEDURE pop_time_dimension (p_start_date DATE, p_end_date DATE);	
	 
	 PROCEDURE pop_month_YTD;	
	 
	 PROCEDURE pop_quarter_YTD;
	 
	 PROCEDURE pop_day_YTD;  
 
	 PROCEDURE pop_month_QTD;

	 PROCEDURE pop_day_QTD;  
	 
	 PROCEDURE pop_day_MTD;
				  									 
END DM_time_dimension_pkg;
/

CREATE OR REPLACE
PACKAGE BODY DM_time_dimension_pkg
AS
   PACKAGE_NAME CONSTANT VARCHAR2(30) := 'EIN_EXTRACT_PKG';

   PROCEDURE pop_time_dimension (p_start_date DATE, p_end_date DATE)
   IS
   	v_start_date DATE;
   	v_end_date DATE;
   	
   BEGIN
   	v_start_date := trunc(p_start_date);
   	v_end_date := trunc(p_end_date);
   	
   	INSERT INTO time_dimension
				(day,day_of_month,month_id,month_abbr,month_name,
				 month_nbr,year,quarter_nbr,quarter_id,first_day_of_month_ind,
				 last_day_of_month_ind,day_of_week)
			(SELECT v_start_date  + LEVEL - 1 AS day,
				     EXTRACT(DAY FROM v_start_date  + LEVEL - 1) AS day_of_month,
				     EXTRACT(YEAR FROM v_start_date  + level - 1) || LPAD(EXTRACT(MONTH FROM v_start_date  + LEVEL - 1), 2, '0') AS month_id,
				     TO_CHAR( v_start_date  + LEVEL - 1, 'Mon') AS month_abbr,
				     TO_CHAR( v_start_date  + LEVEL - 1, 'Month') AS month_name,
				     EXTRACT(MONTH FROM v_start_date  + LEVEL - 1) AS month_nbr,
				     EXTRACT(YEAR FROM v_start_date + LEVEL - 1) AS year,
				     FLOOR((EXTRACT(MONTH FROM v_start_date  + LEVEL - 1) -1)/ 3) +1 AS quarter_nbr,
				     EXTRACT(YEAR FROM v_start_date  + LEVEL - 1) || FLOOR((EXTRACT(MONTH FROM v_start_date  + LEVEL - 1) -1)/ 3) +1 AS quarter_id,
				     CASE WHEN EXTRACT(DAY FROM v_start_date  + LEVEL - 1) = 1 THEN 'Y' ELSE 'N' END AS first_day_of_month_ind,
				     CASE WHEN LAST_DAY(v_start_date  + LEVEL - 1) = v_start_date  + LEVEL - 1 THEN 'Y' ELSE 'N' END AS last_day_of_month_ind,
				     TO_CHAR(v_start_date  + LEVEL - 1, 'DY')  as DAY_OF_WEEK
			   FROM dual
			CONNECT BY LEVEL < (p_end_date  - v_start_date +1 ));
  
   END pop_time_dimension;
   
   PROCEDURE pop_month_YTD
   IS
   	
   BEGIN
   	
   	INSERT INTO ytd_by_month
				(month_id, ytd_month_id )
			(SELECT DISTINCT a.month_id , b.month_id
				FROM time_dimension a, time_dimension b
			  WHERE a.year = b.year
			    AND a.month_id >= b.month_id);
			  
   END pop_month_YTD;         
   
   PROCEDURE pop_quarter_YTD
   IS
   	
   BEGIN
   	
   	INSERT INTO ytd_by_quarter
				(quarter_id,ytd_quarter_id )
			(SELECT DISTINCT a.quarter_id , b.quarter_id
				FROM time_dimension a, time_dimension b
			  WHERE a.year = b.year
			    AND a.quarter_id >= b.quarter_id);
			  
   END pop_quarter_YTD;   
   
   PROCEDURE pop_day_YTD
   IS
   	
   BEGIN
   	
   	INSERT INTO ytd_by_day
				(day, ytd_day )
			(SELECT DISTINCT a.day , b.day
				FROM time_dimension a, time_dimension b
			  WHERE a.year = b.year
			    AND a.day >= b.day);
			  
   END pop_day_YTD;
   
   PROCEDURE pop_month_QTD
   IS
   	
   BEGIN
   	
   	INSERT INTO qtd_by_month
				(month_id, qtd_month )
			(SELECT DISTINCT  a.month_id, b.month_id
				FROM time_dimension a, time_dimension b
			  WHERE a.year = b.year
				 AND a.quarter_id = b.quarter_id
				 AND a.month_id >= b.month_id);
			  
   END pop_month_QTD;
	
	PROCEDURE pop_day_QTD
   IS
   	
   BEGIN
   	
   	INSERT INTO qtd_by_day
				(day, qtd_day )
			(SELECT DISTINCT  a.day, b.day
				FROM time_dimension a, time_dimension b
			  WHERE a.year = b.year
				 AND a.quarter_id = b.quarter_id
				 AND a.day >= b.day);
			  
   END pop_day_QTD;
   
   PROCEDURE pop_day_MTD
   IS
   	
   BEGIN
   	
   	INSERT INTO mtd_by_day
				(day, mtd_day )
			(SELECT DISTINCT  a.day, b.day
				FROM time_dimension a, time_dimension b
			  WHERE a.year = b.year
				 AND a.month_id = b.month_id
				 AND a.day >= b.day);
			  
   END pop_day_MTD;

END DM_time_dimension_pkg;
