--1. List the teachers who have NULL for their department 

SELECT name FROM teachers 
    WHERE dept is NULL

--2. Note: Inner Join removes rows with nulls (based on ON function targets)

SELECT teacher.name, dept.name
    FROM teacher INNER JOIN dept ON (teacher.dept=dept.id)

--3. Use a different JOIN so that all teachers are listed

SELECT teacher.name, dept.name
    FROM teacher LEFT JOIN dept ON (teacher.dept = dept.id)

--4. Use a different JOIN so that all departments are listed

SELECT teacher.name, dept.name
    FROM teacher RIGHT JOIN dept ON (teacher.dept = dept.id)

--5. Use COALESCE to print the mobile number '07986 444 2266' if Null

SELECT name, COALESCE(mobile, '07986 444 2266') FROM teacher

--6. Use the COALESCE function and a LEFT JOIN to print the teacher name and department name. Use the string 'None' when there is no department.

SELECT COALESCE(teacher.name, 'None'), COALESCE(dept.name, 'None')
    FROM teacher LEFT JOIN dept ON (teacher.dept = dept.id)

--7. Use COUNT to show the number of teachers and the number of mobile phones

SELECT COUNT(teacher.name), COUNT(teacher.mobile)
    FROM teacher

--8. Use COUNT & GROUP BY dept.name to show each department and the number of staff. Use a RIGHT JOIN to ensure that the Engineering department is listed.

SELECT dept.name, COUNT(teacher.name)
    FROM teacher RIGHT JOIN dept ON (teacher.dept = dept.id)
    GROUP BY dept.name

--9. Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2 and 'Art' otherwise.

SELECT name,
    CASE WHEN dept IS NULL THEN 'Art' ELSE 'Sci' END dept_type
FROM teacher

--10. Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2, show 'Art' if the teacher's dept is 3 and 'None' otherwise.

SELECT name,
    CASE WHEN dept IS NULL THEN 'None'
        WHEN dept = 3 THEN 'Art'
        ELSE 'Sci'
            END dept_type
FROM teacher