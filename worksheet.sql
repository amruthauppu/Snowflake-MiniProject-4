CREATE DATABASE employee_data
CREATE schema raw_data
CREATE schema transformed_data

CREATE or REPLACE table raw_data.employee_raw(

EMPLOYEE_ID STRING,

FIRST_NAME STRING,

LAST_NAME STRING,

DEPARTMENT STRING,

SALARY DECIMAL(10,2),

HIRE_DATE DATE,

LOCATION STRING);

create or replace table transformed_data.EMPLOYEE_TRANSFORMED

(

EMPLOYEE_ID STRING,

FULL_NAME STRING,

DEPARTMENT STRING,

ANNUAL_SALARY DECIMAL(10, 2),

HIRE_DATE DATE,

EXPERIENCE_LEVEL STRING,

TENURE_DAYS STRING,

STATE STRING,

COUNTRY STRING,

BONUS_ELIGIBILITY STRING,

HIGH_POTENTIAL_FLAG STRING

)

create stage employee_data.raw_data.EMPLOYEE_STAGE;

LIST @raw_data.EMPLOYEE_STAGE;

create or replace file format employee_format
type = 'csv'
FIELD_DELIMITER = ','
RECORD_DELIMITER = '\n'
skip_header = 1;


Copy into raw_data.employee_raw
from @employee_data.raw_data.EMPLOYEE_STAGE/employee_data.csv
file_format =(format_name = employee_format)
ON_ERROR = 'CONTINUE';

INSERT INTO transformed_data.EMPLOYEE_TRANSFORMED 
select EMPLOYEE_ID,concat(first_name,' ',last_name) as FULL_NAME,DEPARTMENT,salary*12 as ANNUAL_SALARY,HIRE_DATE,
CASE
    WHEN DATEDIFF(year, HIRE_DATE, CURRENT_DATE)/365.25 < 1 THEN 'New Hire'
    WHEN DATEDIFF(year, HIRE_DATE, CURRENT_DATE)/365.25 >= 1 
         AND DATEDIFF(year, HIRE_DATE, CURRENT_DATE)/365.25 < 5 THEN 'Mid-level'
    ELSE 'Senior'
END AS EXPERIENCE_LEVEL,
DATEDIFF(day, HIRE_DATE, CURRENT_DATE) as TENURE_DAYS,
SPLIT_PART(LOCATION, '-', 1) AS STATE,SPLIT_PART(LOCATION, '-', 1) AS COUNTRY,
case 
when SALARY>10000 then 'Eligible' 
else 'Noteligible'
END AS BONUS_ELIGIBILITY,
CASE
    WHEN DATEDIFF(year, HIRE_DATE, CURRENT_DATE)/365.25 > 3 THEN 'High-Potential'
    else 'Low-Potential'
END AS HIGH_POTENTIAL_FLAG

from raw_data.employee_raw;

--Employee Count by Department
select Department,count(EMPLOYEE_ID)
from transformed_data.EMPLOYEE_TRANSFORMED 
group by DEPARTMENT;

--Provide count of employees by country
select country,count(EMPLOYEE_ID)
from transformed_data.EMPLOYEE_TRANSFORMED 
group by country;


select * from transformed_data.EMPLOYEE_TRANSFORMED 

--Extract employees who were hired within 12 months
select EMPLOYEE_ID,full_name
from transformed_data.EMPLOYEE_TRANSFORMED 
where TENURE_DAYS / 30.44 < 12

--Extract the top 10% of employees by salary

SELECT count(*)
FROM (
    SELECT *,
           NTILE(10) OVER (ORDER BY ANNUAL_SALARY DESC) AS salary_decile
    FROM transformed_data.EMPLOYEE_TRANSFORMED
) t
WHERE salary_decile = 1
ORDER BY ANNUAL_SALARY DESC;
