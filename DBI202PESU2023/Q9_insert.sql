drop trigger Tr1

create trigger Tr1 on enroll
after insert
as
begin
	select i.enrollId, m.assessmentId, m.mark from inserted i full join marks m on m.enrollId = i.enrollId
end

insert into enroll(enrollId, studentId, courseId, semesterId) values (600,9,11,4)
delete from enroll where enrollId = 600
select * from enroll where enrollId = 600
select * from marks where enrollId = 600
