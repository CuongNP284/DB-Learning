SELECT c.id AS CourseId, c.code, c.title ,COUNT(e1.studentId) AS NumberOfEnrolledStudents
FROM Courses c full JOIN (SELECT * FROM enroll e full JOIN semesters s ON e.semesterId = s.id WHERE s.year = 2019) AS e1
ON c.id = e1.courseId
GROUP BY c.id, c.code, c.title;