create proc P2 @studentId int, @semesterCode varchar(20), @numberOfCourses int output
as
begin
	select @numberOfCourses = count(*) from enroll e join semesters s on e.semesterId = s.id
	group by e.studentId, s.code
	having e.studentId = @studentId and s.code = @semesterCode
end

declare @x int
exec P2 9, 'Sp2019', @x output
select @x as NumberOfCourses

