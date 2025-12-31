-- https://www.w3resource.com/mysql-exercises/join-exercises/index.php
-- MySQL JOINS - Exercises, Practice, Solution
-- MySQL Joins [13 exercises with solution]

-- 1. Write a MySQL query to find the addresses (location_id, street_address, city, state_province, country_name) of all the departments. Hint : Use NATURAL JOIN.
select d.department_id,d.department_name,l.location_id, l.street_address, l.city, l.state_province, c.country_name from locations l
join departments d on d.location_id = l.location_id 
join countries c on c.country_id = l.country_id;

select location_id, street_address, city, state_province, country_name from locations
natural join countries;
-- 2. Write a MySQL query to find the name (first_name, last name), department ID and name of all the employees.
select concat(e.first_name," ",e.last_name) as name, e.department_id, d.department_name from employees e
left join departments d on e.department_id = d.department_id;

-- 3. Write a MySQL query to find the name (first_name, last_name), job, department ID and name of the employees who works in London.
select concat(e.first_name," ",e.last_name) as name, e.department_id, d.department_name from employees e
left join departments d on e.department_id = d.department_id
left join locations l on d.location_id = l.location_id
where l.city = "London";

-- 4. Write a MySQL query to find the employee id, name (last_name) along with their manager_id and name (last_name).
select e1.employee_id,e1.last_name, e1.manager_id, e2.last_name from employees e1
join employees e2 on e1.manager_id =e2.employee_id;

-- 5. Write a MySQL query to find the name (first_name, last_name) and hire date of the employees who was hired after 'Jones'.
select  concat(e.first_name," ",e.last_name) as name, e.hire_date from employees e
where e.hire_date > (select hire_date from employees where last_name = "Jones" );

SELECT e.first_name, e.last_name, e.hire_date FROM employees e 
JOIN employees davies ON   (davies.last_name = 'Jones') -- Performing a join based on the condition where the last name in 'davies' is 'Jones'.
WHERE   davies.hire_date < e.hire_date;

-- 	6. Write a MySQL query to get the department name and number of employees in the department.
select d.department_name, count(e.employee_id) from employees e
left join departments d on e.department_id = d.department_id
group by d.department_name;

-- 7. Write a MySQL query to find the employee ID, job title, number of days between ending date and starting date for all jobs in department 90.
SELECT employee_id, job_title, end_date - start_date AS Days FROM job_history 
NATURAL JOIN  jobs 
WHERE department_id = 90;

-- 8. Write a MySQL query to display the department ID and name and first name of manager.
select distinct(d.department_id), d.department_name, (e.first_name) from departments d
left join employees e on d.manager_id = e.employee_id; 

-- 9. Write a MySQL query to display the department name, manager name, and city.
select distinct(d.department_id), d.department_name, concat((e.first_name)," ",(e.last_name)) as name,l.city from departments d
left join employees e on d.manager_id = e.employee_id
join locations l on l.location_id = d.location_id; 

-- 10. Write a MySQL query to display the job title and average salary of employees.
select j.job_title, round(avg(e.salary),2) from employees e
natural join jobs j
group by j.job_title
order by j.job_title;

select job_id, salary from employees e
where salary = (select avg(salary) from employees
						where salary = e.salary)
order by job_id;

-- 12. Write a MySQL query to display the job history that were done by any employee who is currently drawing more than 10000 of salary.
select jh.employee_id,jh.start_date,jh.end_date,jh.job_id,e.salary from job_history jh
left join employees e on jh.employee_id = e.employee_id
where salary > 10000;

-- 13. Write a MySQL query to display department name, name (first_name, last_name), hire date, salary of the manager for all managers whose experience is more than 15 years.
select d.department_name,concat(e.first_name," ",e.last_name) as name,(datediff (now() , e.hire_date))/365 as Y_o_E from departments d
join employees e on d.manager_id = e.employee_id 
where (datediff (now() , e.hire_date))/365 >15;

use hr;
select * from employees ; 
select * from departments;
select * from job_history;
select * from countries;
select * from locations;
select * from regions;