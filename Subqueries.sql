-- Subqueries

use company_constraints;

select * from employee;

 select distinct Pnumber from project 
	where Pnumber IN 
		(
        select Pnumber 
        from project, departament, employee
		where Mgr_ssn = Ssn and Lname ='Gustavo' and Dnum=Dnumber
        )
        or
        (
        select distinct Pno
        from works_on, employee
        where Essn=Ssn and Lname = 'Gustavo'
        );
        

select distinct * from works_on 
	where (Pno,Hours) IN (select Pno, Hours
							from works_on
								where Essn='123456789');
                                
-- Cláusulas com Exists e Unique

-- Quais employes possuem dependentes 
desc dependent;
select e.Fname, e.Lname from employee as e
	where exists (
		select * from dependent as d
			where e.Ssn = d.Essn and Relationship ='Son'
    );
    
-- Gerentes com dependentes

select e.Fname, e.Lname from employee as e, departament as d
	where (e.Ssn = D.Mgr_Ssn) and exists 
    (select * from dependent as d where e.Ssn = d.Essn);
    
    
-- Sem dependentes
select e.Fname, e.Lname from employee as e
	where not exists (
		select * from dependent as d
			where e.Ssn = d.Essn
    );
    
-- Mais de 2 dependentes para cada employee
select Fname, Lname from employee
	where (select count(*) from dependent where Ssn=Essn)>2;

-- Em um range
select distinct Essn, Pno from works_on where Pno in (1,2,3);

