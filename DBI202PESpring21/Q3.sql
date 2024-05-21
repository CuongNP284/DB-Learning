select j.JobID, j.JobTitle, j.min_salary from Jobs j where j.JobTitle like '%Manager%' and j.min_salary > 5000
order by j.min_salary DESC, j.JobTitle ASC