drop table time_dimension;
CREATE table time_dimension
(day	date NOT NULL,
day_of_month  Number NOT NULL,
Month_id	Number not null,
month_abbr	VARCHAR2(3) NOT NULL,
month_name	VARCHAR2(30) NOT NULL,
month_nbr	NUMBER NOT NULL,
year 	number not null,
Quarter_nbr NUMBER NOT NULL,
Quarter_id NUMBER NOT NULL,
First_day_of_month_ind VARCHAR2(1) NOT NULL,
last_day_of_month_ind VARCHAR2(1) NOT NULL,
day_of_week	VARCHAR2(30) NOT NULL,
constraint time_dimension primary key  (day));

DROP TABLE YTD_BY_MONTH;
CREATE TABLE YTD_BY_MONTH
(MONTH_ID NUMBER NOT NULL,
 YTD_MONTH_ID NUMBER NOT NULL);

DROP TABLE YTD_BY_QUARTER;
CREATE TABLE YTD_BY_QUARTER
(quarter_ID NUMBER NOT NULL,
 ytd_quarter_id NUMBER NOT NULL);

DROP TABLE YTD_BY_DAY;
CREATE TABLE YTD_BY_DAY
(DAY DATE NOT NULL,
 ytd_DAY DATE NOT NULL);

DROP TABLE QTD_BY_MONTH;
CREATE TABLE QTD_BY_MONTH
(month_id NUMBER NOT NULL,
 QTD_MONTH NUMBER NOT NULL);

DROP TABLE QTD_BY_DAY;
CREATE TABLE QTD_BY_DAY
(DAY DATE NOT NULL,
 qtd_DAY DATE NOT NULL);

DROP TABLE MTD_BY_DAY;
CREATE TABLE MTD_BY_DAY
(DAY DATE NOT NULL,
 mtd_DAY DATE NOT NULL);
