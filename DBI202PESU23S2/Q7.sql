select c.country_id, c.country_name, count(e.employee_id) as [number of employees]
from employees e full join departments d on e.department_id = d.department_id
full join locations l on d.location_id = l.location_id
full join countries c on l.country_id = c.country_id
group by c.country_id, c.country_name 
having count(e.employee_id) >= 2
order by [number of employees] DESC