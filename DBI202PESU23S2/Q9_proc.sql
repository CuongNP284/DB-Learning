create proc Get_ManagerID @idEmloyee int, @idManager int output
as
begin
	select @idManager = e.manager_id from employees e where e.employee_id = @idEmloyee
end

DECLARE @X INT;
DECLARE @in INT = 101;
EXECUTE Get_ManagerID @in
                     ,@X OUTPUT;
SELECT @in as EmployeeID,
  @X AS ManagerID;