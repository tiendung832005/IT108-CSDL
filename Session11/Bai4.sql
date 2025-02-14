DELIMITER &&
	create procedure UpdateSalaryByID(in EmployeeID int, inout newSalary decimal(10,2))
begin
	if newSalary < 20000000 then
		set newSalary = newSalary * 1.10;
	else
		set newSalary = newSalary * 1.05;
	end if;
    update employees set salary = newSalary where  EmployeeID = employeeId;
end &&
DELIMITER &&;

call UpdateSalaryByID (4, @newSalary);
select @newSalary;
drop procedure if exists UpdateSalaryByID;

DELIMITER &&
create procedure GetLoanAmountByCustomerID(in CustomerID int, out TotalLoanAmount decimal(15,2))
begin
	select sum(LoanAmount) into TotalLoanAmount from loans where CustomerID = customerId;
end &&
DELIMITER &&;

call GetLoanAmountByCustomerID (1, @TotalLoanAmount);
drop procedure if exists GetLoanAmountByCustomerID;

DELIMITER &&
create procedure DeleteAccountIfLowBalance (in AccountID int, out balance decimal(15,2))
begin
	select balance from accounts where AccountID = accountid;
    
    if balance is not null then
		if balance < 1000000 then
			delete from accounts where AccountID = accountid;
            select 'Tai khoan da dc xoa' as message;
		else 
			select 'Khong the xoa' as message;
		end if;
        else 
			select 'tai khoan khong ton tai' as message;
		end if;
end &&
DELIMITER &&

call DeleteAccountIfLowBalance (8, @balance);
drop procedure if exists DeleteAccountIfLowBalance;

DELIMITER &&
create procedure TransferMoney (in senderAccountID int, in receiverAccountID int, inout transferAmount decimal(15,2))
begin
	declare senderBalance decimal(15,2);
    
    select balance into senderBalance from accounts where accountId = senderAccountID;
    
    if senderBalance is not null then
		if senderBalance >= transferAmount then
			update accounts
            set balance = balance - transferAmount
            where accountId = senderAccountID;
			
            update accounts
            set balance = balance + transferAmount
            where accountId = senderAccountID;
            
		else
			set transferAmount = 0;
		end if;
        end if;
end &&
DELIMITER &&;

set @amount = 2000000;
call TransferMoney(1, 3, @amount);
select @amount;
drop procedure if exists TransferMoney;

