SELECT
  c.country_id
 ,c.country_name
 ,COUNT(e.employee_id) AS 'number of employees'
FROM locations l
full JOIN countries c
  ON l.country_id = c.country_id
full JOIN departments d
  ON l.location_id = d.location_id
full JOIN employees e
  ON d.department_id = e.department_id
GROUP BY c.country_id
        ,c.country_name
HAVING COUNT(e.employee_id) > 2
ORDER BY 'number of employees' DESC;