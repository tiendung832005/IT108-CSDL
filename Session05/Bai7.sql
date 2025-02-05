SELECT 
    students.name, 
    students.email, 
    courses.course_name, 
    enrollments.enrollment_date
FROM students
LEFT JOIN enrollments ON students.student_id = enrollments.student_id
LEFT JOIN courses ON enrollments.course_id = courses.course_id
WHERE students.email IS NULL 
   OR (enrollments.enrollment_date BETWEEN '2025-01-12' AND '2025-01-18')
ORDER BY students.name;

SELECT 
    courses.course_name, 
    courses.fee, 
    students.name, 
    enrollments.enrollment_date
FROM courses
LEFT JOIN enrollments ON courses.course_id = enrollments.course_id
LEFT JOIN students ON enrollments.student_id = students.student_id
WHERE courses.fee > 1000000 
   OR enrollments.student_id IS NULL
ORDER BY courses.fee DESC, courses.course_name;

SELECT 
    students.name, 
    students.email, 
    courses.course_name, 
    enrollments.enrollment_date
FROM students
LEFT JOIN enrollments ON students.student_id = enrollments.student_id
LEFT JOIN courses ON enrollments.course_id = courses.course_id
WHERE students.email IS NULL 
   OR courses.fee > 1000000
ORDER BY students.name, courses.course_name;



