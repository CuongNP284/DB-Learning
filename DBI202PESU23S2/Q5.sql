select d.department_id, d.department_name, min(e.salary) as [MIN(salary)] 
from employees e join departments d on e.department_id = d.department_id
group by d.department_id, d.department_name
order by [MIN(salary)]  ASC