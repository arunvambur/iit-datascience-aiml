/*Simple Queries
**************************/
/*1. List all the employee details. */
SELECT * FROM Employee;

/*2. List all the department details.*/
SELECT * FROM Department;

/*3. List all job details.*/
SELECT * FROM Job;

/*4. List all the locations.*/
SELECT * FROM Location;

/*5. List out the First Name, Last Name, Salary, Commission for allEmployees.*/
SELECT First_Name, Last_Name, Salary, Comm Commission 
FROM Employee;

/*6. List out the Employee ID, Last Name, Department ID for all employees and
alias Employee ID as "ID of the Employee", Last Name as "Name of the
Employee", Department ID as "Dep_id". */
SELECT EMPLOYEE_ID ID, LAST_NAME Name, DEPARTMENT_ID Dep_id 
FROM Employee;

/*7. List out the annual salary of the employees with their names only.*/
SELECT FIRST_NAME, MIDDLE_NAME, LAST_NAME, SALARY
FROM Employee;

/*WHERE Condition:
*************************************/

/*1. List the details about "Smith".*/
SELECT * 
FROM Employee
WHERE LAST_NAME = 'SMITH';

/*2. List out the employees who are working in department 20. */
SELECT * 
FROM Employee
WHERE DEPARTMENT_ID = 20;

/*3. List out the employees who are earning salaries between 3000 and4500. */
SELECT * 
FROM Employee
WHERE SALARY BETWEEN 3000 AND 4500;

/*4. List out the employees who are working in department 10 or 20. */
SELECT * 
FROM Employee
WHERE DEPARTMENT_ID IN(10, 20);

/*5. Find out the employees who are not working in department 10 or 30. */
SELECT * 
FROM Employee
WHERE DEPARTMENT_ID NOT IN(10, 30);

/*6. List out the employees whose name starts with 'S'.*/
SELECT * 
FROM Employee
WHERE LAST_NAME LIKE 'S%';

/*7. List out the employees whose name starts with 'S' and ends with 'H'. */
SELECT * 
FROM Employee
WHERE LAST_NAME LIKE 'S%H';

/*8. List out the employees whose name length is 4 and start with 'S'. */
SELECT * 
FROM Employee
WHERE LAST_NAME LIKE 'S%' AND LEN(LAST_NAME) = 4;


/*9. List out employees who are working in department 10 and draw salaries more than 3500. */
SELECT * 
FROM Employee
WHERE DEPARTMENT_ID = 10 AND Salary > 3500;

/*10. List out the employees who are not receiving commission.*/
SELECT * 
FROM Employee
WHERE COMM IS NULL;

/*ORDER BY Clause:
****************************************************/

/*1. List out the Employee ID and Last Name in ascending order based on the Employee ID. */
SELECT EMPLOYEE_ID, LAST_NAME 
FROM Employee
ORDER BY EMPLOYEE_ID;


/*2. List out the Employee ID and Name in descending order based onsalary. */
SELECT EMPLOYEE_ID, LAST_NAME, SALARY
FROM Employee
ORDER BY SALARY DESC;

/*3. List out the employee details according to their Last Name in ascending-order.*/
SELECT *
FROM Employee
ORDER BY LAST_NAME;

/*4. List out the employee details according to their Last Name in ascending order and then Department ID in descending order */
SELECT *
FROM Employee
ORDER BY LAST_NAME, DEPARTMENT_ID DESC;

/*GROUP BY and HAVING Clause:
*****************************************/

/*1. How many employees are in different departments in the organization?*/
SELECT Department_id, COUNT(*)
FROM Employee
GROUP BY DEPARTMENT_ID;

/*2. List out the department wise maximum salary, minimum salary and average salary of the employees.*/
SELECT DEPARTMENT_ID, MAX(SALARY), MIN(SALARY), AVG(SALARY)
FROM Employee
GROUP BY DEPARTMENT_ID;

/*3. List out the job wise maximum salary, minimum salary and average salary of the employees. */
SELECT JOB_ID, MAX(SALARY), MIN(SALARY), AVG(SALARY)
FROM Employee
GROUP BY JOB_ID;

/*4. List out the number of employees who joined each month in ascending order. */
SELECT MONTH(HIRE_DATE), COUNT(*)
FROM EMPLOYEE
GROUP BY  MONTH(HIRE_DATE)

/*5. List out the number of employees for each month and year in ascending order based on the year and month. */
SELECT YEAR(HIRE_DATE), MONTH(HIRE_DATE), COUNT(*)
FROM EMPLOYEE
GROUP BY YEAR(HIRE_DATE), MONTH(HIRE_DATE)


/*6. List out the Department ID having at least four employees. */
SELECT Department_id, COUNT(*)
FROM Employee
GROUP BY DEPARTMENT_ID
HAVING  COUNT(*) >= 4


/*7. How many employees joined in the month of January?*/
SELECT MONTH(HIRE_DATE), COUNT(*)
FROM EMPLOYEE
GROUP BY  MONTH(HIRE_DATE)
HAVING MONTH(HIRE_DATE) = 1

/*8. How many employees joined in the month of January or September?*/

SELECT MONTH(HIRE_DATE), COUNT(*)
FROM EMPLOYEE
GROUP BY  MONTH(HIRE_DATE)
HAVING MONTH(HIRE_DATE) IN(1, 9)

/*9. How many employees joined in 1985?*/
SELECT YEAR(HIRE_DATE), COUNT(*)
FROM EMPLOYEE
GROUP BY  YEAR(HIRE_DATE)
HAVING YEAR(HIRE_DATE) = 1985

/*10. How many employees joined each month in 1985?*/
SELECT YEAR(HIRE_DATE), MONTH(HIRE_DATE), COUNT(*)
FROM EMPLOYEE
GROUP BY YEAR(HIRE_DATE), MONTH(HIRE_DATE)
HAVING YEAR(HIRE_DATE) = 1985;

/*11. How many employees joined in March 1985?*/
SELECT YEAR(HIRE_DATE), MONTH(HIRE_DATE), COUNT(*)
FROM EMPLOYEE
GROUP BY YEAR(HIRE_DATE), MONTH(HIRE_DATE)
HAVING YEAR(HIRE_DATE) = 1985 AND MONTH(HIRE_DATE) = 3;


/*12. Which is the Department ID having greater than or equal to 3 employees joining in April 1985?*/
SELECT DEPARTMENT_ID
FROM EMPLOYEE
GROUP BY DEPARTMENT_ID, YEAR(HIRE_DATE), MONTH(HIRE_DATE)
HAVING YEAR(HIRE_DATE) = 1985 AND MONTH(HIRE_DATE) = 4;


/*SET Operators:
****************************************************/

/*1. List out the distinct jobs in sales and accounting departments. */
SELECT DISTINCT DESIGNATION FROM JOB
WHERE JOB_ID IN(
SELECT JOB_ID FROM EMPLOYEE
WHERE DEPARTMENT_ID IN (SELECT Department_Id FROM DEPARTMENT WHERE Name IN ('Sales', 'Accounting'))
)

/*2. List out all the jobs in sales and accounting departments. */
SELECT DISTINCT DESIGNATION FROM JOB
WHERE JOB_ID IN(
SELECT JOB_ID FROM EMPLOYEE
WHERE DEPARTMENT_ID IN (SELECT Department_Id FROM DEPARTMENT WHERE Name IN ('Sales', 'Accounting'))
)

/*3. List out the common jobs in research and accounting departments in ascending order.*/

SELECT DISTINCT DESIGNATION FROM JOB
WHERE JOB_ID IN(
SELECT JOB_ID FROM EMPLOYEE
WHERE DEPARTMENT_ID IN (SELECT Department_Id FROM DEPARTMENT WHERE Name IN ('Research', 'Accounting'))
)
 
/*Subqueries:
****************************/

/*1. Display the employees list who got the maximum salary.*/
SELECT * FROM EMPLOYEE
WHERE SALARY  IN (
SELECT MAX(SALARY) FROM EMPLOYEE)

/*2. Display the employees who are working in the sales department. */
SELECT * FROM EMPLOYEE
WHERE DEPARTMENT_ID IN (SELECT Department_Id FROM DEPARTMENT WHERE Name IN ('Sales'))


/*3. Display the employees who are working as 'Clerk'. */
SELECT * FROM EMPLOYEE
WHERE JOB_ID IN (SELECT JOB_ID FROM JOB WHERE Designation IN ('Clerk'))

/*4. Display the list of employees who are living in "New York". */
SELECT * FROM EMPLOYEE
WHERE DEPARTMENT_ID IN (SELECT Department_Id FROM DEPARTMENT WHERE Location_ID IN (SELECT Location_ID FROM LOCATION WHERE City = 'New York'));

/*5. Find out the number of employees working in the sales department. */
SELECT  COUNT(*)  FROM EMPLOYEE
WHERE DEPARTMENT_ID IN (SELECT Department_Id FROM DEPARTMENT WHERE Name IN ('Sales'))

/*6. Update the salaries of employees who are working as clerks on the basis of 10%. */
SELECT SALARY FROM EMPLOYEE
WHERE JOB_ID IN (SELECT JOB_ID FROM JOB WHERE Designation IN ('Clerk'))

/*7. Delete the employees who are working in the accounting department. */
DELETE  FROM EMPLOYEE
WHERE DEPARTMENT_ID IN (SELECT Department_Id FROM DEPARTMENT WHERE Name IN ('Accounting'))

/*8. Display the second highest salary drawing employee details.*/ 

SELECT * FROM EMPLOYEE
WHERE EMPLOYEE_ID = (
SELECT EMPLOYEE_ID FROM(
SELECT ROW_NUMBER() OVER(ORDER BY SALARY DESC) RANK, e.* FROM EMPLOYEE e
) a
WHERE Rank = 2)

/*9. Display the nth highest salary drawing employee details. */
SELECT * FROM(
SELECT ROW_NUMBER() OVER(ORDER BY SALARY DESC) RANK, e.* FROM EMPLOYEE e
) a
WHERE Rank = 2

/*10. List out the employees who earn more than every employee in department 30. */
SELECT * FROM EMPLOYEE 
WHERE SALARY > (
SELECT  MAX(SALARY)  FROM EMPLOYEE
WHERE DEPARTMENT_ID = 30)
AND DEPARTMENT_ID != 30

/*11. List out the employees who earn more than the lowest salary in department. */
SELECT * FROM EMPLOYEE 
WHERE SALARY > (
SELECT  MIN(SALARY)  FROM EMPLOYEE
WHERE DEPARTMENT_ID = 30)
AND DEPARTMENT_ID != 30


/*12. Find out which department has no employees. */
SELECT * FROM DEPARTMENT
WHERE DEPARTMENT_ID NOT IN (SELECT DEPARTMENT_ID FROM EMPLOYEE)

/*13. Find out the employees who earn greater than the average salary for their department*/
SELECT * 
FROM EMPLOYEE e,
(
	SELECT DEPARTMENT_ID, AVG(SALARY) AvgSal FROM EMPLOYEE
	GROUP BY DEPARTMENT_ID
) a
WHERE e.DEPARTMENT_ID = a.DEPARTMENT_ID AND e.SALARY = a.AvgSal
