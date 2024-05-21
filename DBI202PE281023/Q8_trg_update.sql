create trigger Salary_Not_Decrease
On employees
after update
as
begin
	UPDATE employees
	SET salary = d.salary
	from deleted d
	where employees.employee_id = d.employee_id and d.salary > employees.salary
end

  UPDATE employees
  SET salary = 18000
  WHERE employee_id = 101;
  SELECT
    e.salary
  FROM employees e
  WHERE e.employee_id = 101;