-- https://www.w3resource.com/mysql-exercises/subquery-exercises/index.php
-- MySQL Subquery - Exercises, Practice, Solution
-- MySQL Subquery [22 exercises with solution] 

-- 1. Write a MySQL query to find the name (first_name, last_name) and the salary of the employees who have a higher salary than the employee whose last_name='Bull'. 
select concat(first_name," " ,last_name) as name, salary from employees
where salary > (select salary from employees where last_name ="Bull");

-- 2. Write a MySQL query to find the name (first_name, last_name) of all employees who works in the IT department. 
select concat(first_name," ",last_name) as name from employees where job_id = "IT_PROG";

-- 3. Write a MySQL query to find the name (first_name, last_name) of the employees who have a manager and worked in a USA based department. 
select * from employees
where manager_id in 
	(select employee_id from employees where manager_id in
		(select manager_id from departments where location_id in 
			(select location_id from locations where country_id = "US"
			)
		)
	);

-- 4. Write a MySQL query to find the name (first_name, last_name) of the employees who are managers. 
select  concat(first_name," ",last_name) as name from employees
where employee_id in (select manager_id from employees);

-- 5. Write a MySQL query to find the name (first_name, last_name), and salary of the employees whose salary is greater than the average salary. 
select first_name,last_name from employees
where salary > (select avg(salary) from employees);

-- 6. Write a MySQL query to find the name (first_name, last_name), and salary of the employees whose salary is equal to the minimum salary for their job grade. 
select first_name,last_name,salary from employees
where employees.salary = (select min_salary from jobs
where employees.job_id=jobs.job_id);

-- 7. Write a MySQL query to find the name (first_name, last_name), and salary of the employees who earns more than the average salary and works in any of the IT departments. 
select first_name, last_name,salary from employees
where salary > (select avg(salary) from employees) and department_id in (select department_id from departments where department_name like "IT%");

-- 8. Write a MySQL query to find the name (first_name, last_name), and salary of the employees who earns more than the earning of Mr. Bell. 
select first_name, last_name, salary from employees
where salary > (select salary from employees where last_name = "Bell");

-- 9. Write a MySQL query to find the name (first_name, last_name), and salary of the employees who earn the same salary as the minimum salary for all departments. 
select first_name,last_name,salary from employees
where salary in (select min(salary) from employees);

-- 10. Write a MySQL query to find the name (first_name, last_name), and salary of the employees whose salary is greater than the average salary of each department.
select first_name,last_name,salary from employees e
where salary > (select avg(salary) from employees where department_id = e.department_id);

-- using window function
select first_name,last_name,salary from
(select * ,(avg(e.salary) over (partition by e.department_id)) as dept_avg from employees e) sub
where sub.salary > sub.dept_avg;

-- 11. Write a MySQL query to find the name (first_name, last_name) and salary of the employees who earn a salary that is higher than the salary of all the Shipping Clerk (JOB_ID = 'SH_CLERK'). Sort the results of the salary of the lowest to highest.
select first_name,last_name,salary from employees
where salary > (select max(salary) from employees where job_id = 'SH_CLERK')
order by salary;

-- 12. Write a MySQL query to find the name (first_name, last_name) of the employees who are not supervisors.
select first_name,last_name from employees e
where employee_id not in (select manager_id from employees where manager_id is not null);

-- 13. Write a MySQL query to display the employee ID, first name, last name, and department names of all employees.
select e.employee_id,e.first_name,e.last_name,d.department_name from employees e
join departments d on e.department_id = d.department_id;

-- 14. Write a MySQL query to display the employee ID, first name, last name, salary of all employees whose salary is above average for their departments.
select employee_id,first_name,last_name,salary from employees e
where salary > (select avg(salary) from employees where department_id = e.department_id); 

-- 15. Write a MySQL query to fetch even numbered records from employees table.
select * from employees
where employee_id % 2 =0;
-- using row_number()
with cte as (select *,row_number() over() as rn from employees)
select * from cte
where rn%2 = 0;

SET @i = 0; 
SELECT i, employee_id 
FROM (SELECT @i := @i+1 AS i, employee_id FROM employees) a 
WHERE MOD(a.i, 2) = 0;

-- 16. Write a MySQL query to find the 5th maximum salary in the employees table.
select distinct(salary) from employees
order by salary desc
limit 1 offset 4;

select distinct(salary) from employees e1
where 5 = (select count(distinct salary) from employees e2 where e2.salary>=e1.salary);

-- 17. Write a MySQL query to find the 4th minimum salary in the employees table.
select distinct(salary) from employees e1
where 4 = (select count(distinct salary) from employees e2 where e2.salary<=e1.salary);

select distinct(salary) from employees
order by salary
limit 1 offset 3;

-- 18. Write a MySQL query to select last 10 records from a table.
with cte as(select *,row_number() over() as rn from employees)
select * from (select * from cte order by rn desc
limit 10) a order by rn;

-- 19. Write a MySQL query to list the department ID and name of all the departments where no employee is working.
SELECT d.department_id,department_name FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;

SELECT * FROM departments 
WHERE (department_id) IN (select department_id FROM employees);

-- 20. Write a MySQL query to get 3 maximum salaries.
select distinct salary from employees
order by salary desc limit 3;

select distinct salary from employees a
where 3 >= (select count(distinct salary) from employees b
			where b.salary >= a.salary)
order by salary desc;

-- 21. Write a MySQL query to get 3 minimum salaries.
select distinct salary from employees
order by salary limit 3;

select distinct salary from employees a 
where 3 >= (
			select count(distinct salary) from employees b
            where a.salary >= b.salary
            );

-- 22. Write a MySQL query to get nth max salaries of employees.
set @n =1;
select distinct salary from employees a 
where @n -1 = (select count(distinct salary) from employees b 
			where b.salary > a.salary);
            

use hr;
select * from employees;
select * from departments;
select * from locations;
select * from jobs;