select TOP(5) e1.first_name, e1.last_name from employees e  join employees e1 on e1.employee_id = e.manager_id
group by e1.first_name, e1.last_name
order by e1.first_name