-- cláusulas de ordenação

use company_constraints;

select * from employee ORDER BY Fname;

select * from employee ORDER BY Fname, Lname;

-- nome do departamento, nome do gerente, 
select distinct d.Dname, concat(Fname, ' ',Lname) as Manager, Address 
	from departament as d, employee as e, works_on as w, project p
	where (d.Dnumber = e.Dno and e.Ssn=d.Mgr_ssn and w.Pno = p.Pnumber) 
    order by d.Dname;
    
select d.Dname as Departament, concat(Fname, ' ',Lname) as Employee, p.Pname as Project_Name, Address
	from departament as d, employee as e, works_on as w, project p
	where (d.Dnumber = e.Dno and e.Ssn=w.Essn and w.Pno=p.Pnumber)
    order by d.Dname desc, e.Fname asc, e.Lname asc;

-- funções e cláusulas de agrupamento group by

select * from employee;

select count(*) from employee;

select count(*) as C from employee, departament
	where Dno=Dnumber and Dname= 'Research';
    
select Dno, count(*) as Employee_per_Departament, round(avg(Salary),2) as Average_Salary from employee, departament
	group by Dno;
    
select Pnumber, Pname, count(*) as Employee_per_Departament from project, works_on 
    where Pnumber=Pno
		group by Pnumber, Pname;

select count(distinct Salary) as Salary_Distinct from employee;

select sum(Salary) as T_Salary, max(Salary) M_Salary, min(Salary) as Min_Salary, avg(Salary) as Media_Salary from employee;
    
-- group by

select Pnumber, Pname, count(*) as C, round(avg(Salary),2) as Average from project, works_on, employee
	where Pnumber = Pno and Ssn = Essn
    group by Pnumber
    order by Pnumber asc ,avg(Salary) desc;

select Pnumber, Pname, count(*) as Employee_per_Departament from project, works_on 
    where Pnumber=Pno
		group by Pnumber, Pname
			having count(*)>=1;

select Dno, count(*)
	from employee
		where Salary > 2000 
        group by Dno
        having count(*) >=1;
        
select Dno as Departament, count(*) as Number_Employee from employee 
where Salary>2000 and Dno in (select Dno from employee group by Dno having count(*)>=1) 
group by Dno;
