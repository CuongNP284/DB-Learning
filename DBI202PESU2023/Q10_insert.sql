insert into Students (id, name, birthdate, gender, department)
values (110, 'Mary Jane', '2001-05-12', 'Female', (select d.Code from Departments d where d.Name = 'Business Administration'))

select * from Students where id = 110
