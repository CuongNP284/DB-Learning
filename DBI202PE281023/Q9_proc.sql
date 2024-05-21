create proc Get_ManagerID @id int, @idManager int output
as
begin
	select @idManager = e.manager_id from employees e where e.employee_id = @id
end

DECLARE @X INT;
DECLARE @in INT = 101;
EXECUTE Get_ManagerID @in
                     ,@X OUTPUT;
SELECT
  @X AS ManagerID;