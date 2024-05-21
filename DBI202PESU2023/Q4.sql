select e.studentId, t.name as StudentName, t.department, s.code as SemesterCode, s.year, c.title as CourseTitle  
from enroll e full join Courses c on e.courseId = c.id
full join semesters s on e.semesterId = s.id
full join Students t on e.studentId = t.id
where c.title = 'Operating Systems'
order by s.year ASC, s.code ASC, e.studentId ASC