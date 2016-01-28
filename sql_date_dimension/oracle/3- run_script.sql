DECLARE
	v_start_date DATE := to_date('01/01/2011', 'MM/DD/YYYY');
    v_end_date DATE := to_date('01/01/2016', 'MM/DD/YYYY');
BEGIN

	DM_time_dimension_pkg.pop_time_dimension(v_start_date, v_end_date);
	DM_time_dimension_pkg.pop_month_YTD;
	DM_time_dimension_pkg.pop_quarter_YTD;
	DM_time_dimension_pkg.pop_day_YTD;
	DM_time_dimension_pkg.pop_month_QTD;
	DM_time_dimension_pkg.pop_day_QTD;
	DM_time_dimension_pkg.pop_day_MTD;
	COMMIT;
END;
