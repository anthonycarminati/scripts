SELECT 'DB Name: ' + DB_NAME();

CREATE table TIME_DIMENSION
(d	date NOT NULL,
day_of_month  Integer NOT NULL,
Month_id	Integer not null,
last_month_id Integer NOT NULL,
month_abbr	VARCHAR(3) NOT NULL,
month_name	VARCHAR(30) NOT NULL,
month_nbr	Integer NOT NULL,
yr 	Integer not null,
last_yr Integer not null,
Quarter_nbr Integer NOT NULL,
Quarter_id Integer NOT NULL,
First_day_of_month_ind VARCHAR(1) NOT NULL,
last_day_of_month_ind VARCHAR(1) NOT NULL,
day_of_week	VARCHAR(30) NOT NULL,
constraint time_dimension_pk primary key  (d));

CREATE TABLE YTD_BY_MONTH
(MONTH_ID Integer NOT NULL,
 YTD_MONTH_ID Integer NOT NULL);

CREATE TABLE YTD_BY_QUARTER
(quarter_ID Integer NOT NULL,
 ytd_quarter_id Integer NOT NULL);

CREATE TABLE YTD_BY_DAY
(DAY DATE NOT NULL,
 ytd_DAY DATE NOT NULL);

CREATE TABLE QTD_BY_MONTH
(month_id Integer NOT NULL,
 QTD_MONTH Integer NOT NULL);

CREATE TABLE QTD_BY_DAY
(DAY DATE NOT NULL,
 qtd_DAY DATE NOT NULL);

CREATE TABLE MTD_BY_DAY
(DAY DATE NOT NULL,
 mtd_DAY DATE NOT NULL);
