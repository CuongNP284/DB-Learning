select top 10 e1.first_name, e1.last_name from employees e full join employees e1 on e.manager_id = e1.employee_id
where e.employee_id is null
group by e1.first_name, e1.last_name
order by e1.last_name ASC
