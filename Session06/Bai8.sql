select 
    s.student_id,
    s.name as student_name,
    s.email,
    c.course_name,
    e.enrollment_date
from enrollments e
join students s on e.student_id = s.student_id
join courses c on e.course_id = c.course_id
where e.student_id in (
    select student_id 
    from enrollments 
    group by student_id 
    having count(course_id) > 1
)
order by s.student_id asc, e.enrollment_date asc;

select 
    s.name as student_name,
    s.email,
    e.enrollment_date,
    c.course_name,
    c.fee
from enrollments e
join students s on e.student_id = s.student_id
join courses c on e.course_id = c.course_id
WHERE e.course_id in (
    select course_id 
    from enrollments 
    join students on enrollments.student_id = students.student_id
    where students.name = 'Nguyen Van An'
)
and s.name <> 'Nguyen Van An';

select 
    c.course_name,
    c.duration,
    c.fee,
    count(e.student_id) as total_students
from enrollments e
join courses c on e.course_id = c.course_id
group by c.course_id, c.course_name, c.duration, c.fee
having coun(e.student_id) > 2;

select 
    s.name as student_name,
    s.email,
    SUM(c.fee) as total_fee_paid,
    COUNT(e.course_id) as courses_count
from enrollments e
join students s on e.student_id = s.student_id
join courses c on e.course_id = c.course_id
where e.student_id in (
    select student_id
    from enrollments e1
    join courses c1 on e1.course_id = c1.course_id
    group by e1.student_id
    having count(e1.course_id) >= 2 
    and min(c1.duration) > 30
)
group by s.student_id, s.name, s.email;


