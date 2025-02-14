create index idx_customers_phonenumber on customers (PhoneNumber);
EXPLAIN SELECT * FROM customers WHERE PhoneNumber = '0901234567';
drop index idx_customers_phone on customers;


create index idx_employees_branch_salary on employees (BranchID, Salary);
EXPLAIN SELECT * FROM Employees WHERE BranchID = 1 AND Salary > 20000000;
drop index idx_employees_branch_salary on employees;

create unique index idx_unique_account_customer on accounts (AccountID, CustomerID);
drop index idx_unique_account_customer on accounts;

show index from customers;
show index from employees;
show index from accounts;




