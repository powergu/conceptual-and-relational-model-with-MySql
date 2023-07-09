-- case statement

use company_constraints;
show tables;
select Fname, Salary, Dno from employee;

UPDATE employee SET Salary = 
	case
		when Dno=5 then Salary +1000
        when Dno=4 then Salary +1500
        when Dno=1 then Salary +2000
		else Salary+0
    end;