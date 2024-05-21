create trigger Salary_Min_Max on employees
after update
as
begin
	UPDATE employees SET salary = d.salary
	from deleted d
	where employees.employee_id = d.employee_id
	and d.salary >= (select min(employees.salary) from employees) 
	and d.salary <= (select max(employees.salary) from employees)
end

update employees set salary = 7000.00 where employee_id = 102
select * from employees where employee_id = 102