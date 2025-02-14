create view EmployeeBranch as
select e.EmployeeID, e.FullName,e.Position,e.Salary,b.BranchName,b.Location
from employees e
join branch b on e.BranchID = b.BranchID;
select * from EmployeeBranch;

create view HighSalaryEmployees as
select EmployeeID,FullName,Position,Salary
from employees
where Salary >= 15000000
with check option;
select * from HighSalaryEmployees;

create or replace view EmployeeBranch as
select e.EmployeeID,e.FullName,e.Position,e.Salary,e.PhoneNumber,b.BranchName,b.Location
from employees e
join branch b on e.BranchID = b.BranchID;

delete from employees 
where BranchID = (select BranchID from branch where BranchName = 'Chi nhánh Hà Nội');

