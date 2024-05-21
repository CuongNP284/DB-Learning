delete from dependents where dependent_id in (select d.dependent_id from dependents d full join employees e
on d.employee_id = e.employee_id
where e.first_name = 'Karen') 

delete from dependents where employee_id in (select employee_id from employees e
where e.first_name = 'Karen') 