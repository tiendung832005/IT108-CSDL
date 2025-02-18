use session_11;
select *from accounts;

/*
	xây dựng procedure trandferMoney 
    input : acc_sender, acc_recieve, money 
    process:
    1. kiem tra tkhoan gui nhan 
    2.tru tai khoan gui 
    3. kiem tra so du 
    4. cong tai khoan nhan 
    
    Output : result_code 
    + 1: sai tai khoan 
    + 2 : so du ko đủ 
    + 3 : chuyển khoản thành công 
*/

delimiter //
create procedure pro_transferMoney(
acc_sender int,
acc_receive int,
money decimal,
out result_code int 
)

begin 
-- stảt trấnction chuyen khoan 
start transaction;
-- 1 kiem tra tai khoan gui va nhan 
if (select count(accountId) from accounts where accountId = acc_sender) = 0 
or (select count(accountId) from accounts where accountId = acc_receive) = 0 then 
set result_code = 1;
rollback;
	else
		-- 2. Trừ tiền tk gửi
		update accounts
			set balance = balance - money
            where accountid = acc_sender;
		-- 3. Kiểm tra số dư tài khoản gửi
        if (select balance from accounts where accountid = acc_sender) < money then
			set result_code = 2;
            rollback;
		else 
			-- 4. Cộng tiền tài khoản nhận
            update accounts
				set balance = balance + money
                where accountId = acc_money
	end if;
end //
delimiter //
