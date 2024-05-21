select e.employee_id, e.first_name + ', ' + e.last_name as full_name, j.job_title, e.phone_number from employees e
full join jobs j on e.job_id = j.job_id
where e.phone_number like '%590%'