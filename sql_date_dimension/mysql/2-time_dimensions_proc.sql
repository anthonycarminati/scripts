SELECT CURRENT_USER(), SCHEMA();

DELIMITER $$

DROP PROCEDURE IF EXISTS pop_time_dimension $$

CREATE PROCEDURE pop_time_dimension (IN p_start DATE, IN p_end DATE)
BEGIN

	DECLARE curr_date DATE;
	SET curr_date = p_start;

	WHILE curr_date <= p_end DO

		INSERT time_dimension
			(d,day_of_month,month_id, last_month_id,month_abbr,month_name,
			 month_nbr,yr, last_yr, quarter_nbr,quarter_id, last_quarter_id, first_day_of_month_ind,
			 last_day_of_month_ind,day_of_week)
		VALUES(curr_date,-- as day,
			   DAYOFMONTH(curr_date), -- as day_of_month,
			   concat(year(curr_date), LPAD(month(curr_date),2, '0')) , -- as month_id,
			   concat(year(curr_date - interval 1 month), LPAD(month(curr_date - interval 1 month),2, '0')) , -- as last_month_id,
			   substring(monthname(curr_date), 1, 3), -- as month_abbr,
			   monthname(curr_date), -- as month_name,
			   month(curr_date), -- as month_nbr, 
			   YEAR(curr_date), -- as year,
			   YEAR(curr_date)-1, -- as last_year,
			   floor((MONTH(curr_date)-1)/3) +1, -- as quarter_nbr, 	 
			   Concat(year(curr_date), floor((MONTH(curr_date)-1)/3) +1), -- as quarter_id,
			   Concat(year(curr_date- interval 3 month), floor((MONTH(curr_date- interval 3 month)-1)/3) +1), -- as last_quarter_id,
			   CASE WHEN DAYOFMONTH(curr_date) = 1 then 'Y' else 'N' END, -- as first_day_of_month_ind ,
			   CASE WHEN last_day(curr_date) =curr_date then 'Y' else 'N' END, -- as last_day_of_month_ind,
				substring(dayname(curr_date), 1, 3)); -- as day_of_week  
	   
		SET curr_date = ADDDATE(curr_date, INTERVAL 1 day);
	END WHILE;

END$$

DELIMITER ;
