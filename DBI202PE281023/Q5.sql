select d.department_id, d.department_name, MAX(e.salary) as [MAX(salary)] from employees e full join departments d on e.department_id = d.department_id
group by d.department_id, d.department_name
order by  [MAX(salary)] DESC