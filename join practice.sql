create database join_practice;
use join_practice;
-- 1. departments table
create table departments (
    department_id int,
    department_name varchar(50)
);
insert into departments values
(101, 'HR'),
(102, 'IT'),
(103, 'Finance'),
(104, 'Marketing'),
(105, 'Operations');
-- 2. employees table
create table employees (
    employee_id int,
    name varchar(50),
    department_id int,
    salary int,
    manager_id int
);
insert into employees values
(1, 'Rahul', 102, 50000, null),
(2, 'Priya', 101, 40000, 1),
(3, 'Amit', 102, 45000, 1),
(4, 'Sneha', 103, 42000, 2),
(5, 'Karan', 104, 38000, 2),
(6, 'Neha', null, 35000, 1),
(7, 'Rohan', 999, 36000, 3),
(8, 'Meera', 101, 41000, 3);
-- 3. projects table
create table projects (
    project_id int,
    project_name varchar(50)
);
insert into projects values
(201, 'Website Development'),
(202, 'Data Analysis'),
(203, 'Mobile App'),
(204, 'Cloud Migration');
-- 4. employee_projects table
create table employee_projects (
    employee_id int,
    project_id int
);
insert into employee_projects values
(1, 201),
(1, 202),
(2, 202),
(3, 201),
(3, 203),
(4, 204),
(5, 203),
(6, 202),
(8, 204);

select * from employees;
select * from departments;
select * from projects;
select * from employee_projects;

#Q1.Display employee names and their department names using INNER JOIN.
select e.name,d.department_name
from employees e
inner join departments d 
on e.department_id = d.department_id;

#Q2.Display employee IDs, names, and department IDs for matching employees.
select e.employee_id ,e.name, d.department_id
from employees e
inner join departments d 
on e.department_id = d.department_id;

#Q3.Display employees who belong to the IT department.
select e.*,d.* 
from employees e
inner join departments d
on e.department_id = d.department_id
where department_name = 'IT';

#Q4.Display department names and the number of employees in each department.
select d.department_name,count(employee_id)
from employees e
inner join departments d 
on e.department_id = d.department_id 
group by d.department_name;

#Q5.Display all employees with their department names, including employees without a department.
select e.name,d.department_name
from employees e
left join departments d 
on e.department_id = d.department_id;

#Q6.Display employee IDs, names, and department names using LEFT JOIN.
select e.employee_id,e.name,d.department_name
from employees e
left join departments d 
on e.department_id = d.department_id;

#Q7.Find employees who don't have a matching department.
select e.name, d.department_name
from employees e
left join departments d
on e.department_id = d.department_id
where d.department_id is NULL;

#Q8.Display all departments and their employees using LEFT JOIN.
select d.department_name,e.name
from departments d 
left join employees e
on d.department_id = e.department_id;

#Q9.Display all departments with their employee names using RIGHT JOIN.
select e.name,d.department_name
from employees e
right join  departments d 
on d.department_id = e.department_id;

#Q10.Find departments that have no employees.
select e.name, d.department_name 
from employees e 
right join departments d
on d.department_id = e.department_id
where e.name is NULL;

#Q11.Display all departments, their IDs, and employee names, including departments without employees.
select d.department_id, e.name
from employees e
right join departments d
on e.department_id = d.department_id;

#Q12.Simulate FULL OUTER JOIN in MySQL using LEFT JOIN and RIGHT JOIN with UNION.
select e.*,d.*
from employees e
left join departments d 
on e.department_id = d.department_id
union
select e.*,d.*
from employees e
right join departments d 
on e.department_id = d.department_id;

#Q13.Display all employee names and department names, including unmatched records from both tables.
select e.name,d.department_name
from employees e
left join departments d
on e.department_id = d.department_id
union 
select e.name,d.department_name
from employees e
right join departments d
on e.department_id = d.department_id;

#Q14.Display employee names and their manager names.
select e.name, m.name
from employees e 
left join employees m
on e.manager_id = m.employee_id;

#Q15.Display only employees who have a manager.
select e.name, m.name
from employees e 
left join employees m
on e.manager_id = m.employee_id
where m.name is not NULL;

#Q16.Display employees who report directly to Rahul.
select e.name,m.name
from employees e
left join employees m 
on e.manager_id = m.employee_id
where m.name = 'Rahul';

#Q17.Display every possible combination of employees and projects.
select e.name,p.project_name
from employees e 
cross join projects p;

#Q18.Display employee names, department names, and project names by joining all four tables.
select e.name,d.department_name,p.project_name
from employees e
inner join departments d 
on e.department_id = d.department_id
inner join employee_projects ep
on e.employee_id = ep.employee_id
inner join projects p
on ep.project_id = p.project_id;

#Q19.Display department-wise employee counts, including departments with zero employees.
select d.department_name,count(employee_id)
from employees e 
right join departments d 
on e.department_id = d.department_id
group by department_name;