select e.first_name + ', ' + e.last_name as full_name, j.job_title, d.department_name, e.salary from employees e full join departments d
on e.department_id = d.department_id
full join jobs j on e.job_id = j.job_id
where e.salary > 7000 and j.job_id = 16