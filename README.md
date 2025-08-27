# Snowflake-MiniProject-4
Structured Data + Internal Stage + Copy Command + Data Transformation

In this mini project, you will:

Load employee data from a CSV file into a raw table in Snowflake using the internal stage.

Perform complex transformations on the raw data

Load the transformed data into a new transformed table for further analysis.

Objectives
Learn how to work with Snowflake's internal stages for file storage.

Use the COPY INTO command to load structured data into the Snowflake table .

Perform data transformations in SQL.

Set up raw and transformed tables in Snowflake for analytics purposes.

Tools/Technologies Used
Snowflake: Cloud-based data warehouse

Snowflake Web UI: SQL execution environment

CSV File: Sample Employee data

 






High Level Step-by-Step Implementation
Create a Database & Schema

Database : EMPLOYEE_DATA

Schema : RAW_DATA

Schema : TRANSFORMED_DATA

Create Raw Table in the RAW_DATA schema

Table : 

Database: EMPLOYEE_DATA

Schema: RAW_DATA

Name: EMPLOYEE_RAW 

Table structure

EMPLOYEE_ID STRING

FIRST_NAME STRING

LAST_NAME STRING

DEPARTMENT STRING

SALARY DECIMAL(10,2)

HIRE_DATE DATE

LOCATION STRING

Create Transformed Table in the TRANSFORMED_DATA schema

Table : 

Database: EMPLOYEE_DATA

Schema: TRANSFORMED_DATA

Name: EMPLOYEE_TRANSFORMED 

Table structure

EMPLOYEE_ID STRING

FULL_NAME STRING

DEPARTMENT STRING

ANNUAL_SALARY DECIMAL(10, 2)

HIRE_DATE DATE

EXPERIENCE_LEVEL STRING

TENURE_DAYS STRING

STATE STRING

COUNTRY STRING

BONUS_ELIGIBILITY STRING

HIGH_POTENTIAL_FLAG STRING



Upload the CSV File to an Internal Stage

Create an Internal Stage in the RAW_DATA schema

Database: EMPLOYEE_DATA

Schema: RAW_DATA

Name: EMPLOYEE_STAGE

Upload the employee csv data file in the internal stage

List the file in the internal stage

 
Load Data from the Stage into the Raw Table

To load the raw employee data into the EMPLOYEE_RAW table, use the COPY INTO command

 
Perform Data Transformations and insert data into the Transformed Table

 
Full Name: Concatenate first_name and last_name.

Annual Salary: Multiply the monthly salary by 12.

Experience Level: Classify employees based on the hire date. For example:

New Hire: Less than 1 year.

Mid-level: 1 to 5 years.

Senior: More than 5 years.

Employee Tenure: Calculate how long an employee has been with the company based on the hire_date in days

State: Fetch the value before the hyphen(-) in the location column

Country: Fetch the value after the hyphen(-) in the location column

Employee's Eligibility for Bonus: For example, employees with a salary greater than $ 10,000 are eligible for a bonus.

Flagging High-Potential Employees: Flag employees who have been with the company for more than 3 years.

 
Data Analysis on the transformed data

Employee Count by Department

Provide count of employees by country

Extract employees who were hired within 12 months

Extract the top 10% of employees by salary

Calculate the total salary expense per department for each year.

Determine how many employees with 5+ years with company


