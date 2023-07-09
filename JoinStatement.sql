-- JOIN STATEMENT


USE company_constraints;


select * from employee, works_on where Ssn=Essn;

-- JOIN
select * from employee JOIN works_on;

-- JOIN ON --> INNER JOIN
select * from employee JOIN works_on on Ssn=Essn;
select * from employee JOIN departament on Ssn=Mgr_ssn;

select Fname, Lname, Address from (employee join departament on Dno=Dnumber)
	where Dname = 'Research';

select * from dept_locations; -- Address Dnumber
select * from departament; -- Dname, Dept_create_date

select Dname as Departament, Dept_create_date as Start_Date, Dlocation as Location
	from departament INNER JOIN dept_locations USING(Dnumber) ORDER By Departament;
    

-- CROSS JOIN - produto cartesiano

select * from employee CROSS JOIN dependent;


-- JOIN COM MAIS DE 3 TABELAS 

-- project, works_on, employee
select concat(Fname, ' ',Lname) Name, Dno as Dept, Pname as Project, Plocation from employee 
	inner join works_on on Ssn = Essn
	inner join project on Pnumber = Pno
    inner join departament on Dno = Dnumber
    where Plocation like 'S%'
	order by Pnumber;

-- departament, dept_location, employee
select Dnumber as Nº, Dname as Departament, concat(Fname,' ',Lname)as Manager, Salary, round(Salary*0.102,2) as AddExtra from departament as d 
	inner join dept_locations as dp using(Dnumber)
    inner join employee as e on Ssn = Mgr_ssn
    group by Dnumber
    having count(*)>=1;
    
-- gerentes q possuem dependentes
select Dnumber as Nº, Dname as Departament, concat(Fname,' ',Lname)as Manager, Salary, round(Salary*0.102,2) as AddExtra from departament as d 
	inner join dept_locations as dp using(Dnumber)
    inner join (dependent inner join employee as e on Ssn = Essn) on Ssn=Mgr_ssn
    group by Dnumber;


-- OUTER JOIN
--

select * from employee;
select * from dependent;

select * from employee inner join dependent on Ssn = Essn; -- interseção completa
select * from employee left join dependent on Ssn = Essn; -- interseção a esquerda
select * from employee right join dependent on Ssn = Essn; -- interseção a direita
select * from employee right outer join dependent on Ssn = Essn; -- outer // match a direita
select * from employee full  outer join dependent on Ssn = Essn; -- outer // match completo
select * from employee left outer join dependent on Ssn = Essn; -- outer // match a esquerda

-- anti left join anti right join anti outer join cross join-- onde esta x excluindo a interseção // crossjoin não quero atributos comuns

-- NATURAL JOIN





