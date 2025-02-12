create view view_manager_summary as
select manager_id, count(*) as total_employees
from employees
where manager_id is not null
group by manager_id;

select * from view_manager_summary;

select e.name as manager_name, v.total_employees
from view_manager_summary v
join employees e on v.manager_id = e.employee_id;




