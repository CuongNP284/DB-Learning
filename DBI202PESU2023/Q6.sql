select a.courseId, c.code, c.title, count(distinct a.type) as [NumberOfAssementTypes], count(a.name) as [NumberOfAssements] 
from Courses c full join Assessments a on c.id = a.courseId
group by a.courseId, c.code, c.title
having count(distinct a.type) >= ALL(select  count(distinct a.type) as [NumberOfAssementTypes]
from Courses c full join Assessments a on c.id = a.courseId
group by a.courseId, c.code, c.title)
and count(a.name) >= ALL(select count(a.name) as [NumberOfAssements] 
from Courses c full join Assessments a on c.id = a.courseId
group by a.courseId, c.code, c.title)