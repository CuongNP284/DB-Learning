select e.enrollId, c.id as CourseId, c.title, e.studentId, t.name as StudentName, e.semesterId, s.code as SemesterCode,
sum(m.mark * a.[percent]) as AverageMark
from enroll e full join Courses c on e.courseId = c.id
 join Students t on e.studentId = t.id
 join semesters s on e.semesterId = s.id
 join marks m on e.enrollId = m.enrollId
 join Assessments a on m.assessmentId = a.id
group by e.enrollId, c.id , c.title, e.studentId, t.name, e.semesterId, s.code
having c.title = 'Introduction to Databases'
order by e.studentId ASC, e.semesterId DESC