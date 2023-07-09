-- Buscas rapidas para criação do modelo Relacional 

show databases;

use company_constraints;

show tables;

-- Descrição das Primary & Foreign Key
select * from information_schema.table_constraints
	where constraint_schema = 'company_constraints'; 
    
-- Estruturas de atributos

desc departament;
-- departament
-- 
-- Dname  UNIQUE
-- Dnumber PRIMARY KEY
-- Mgr_ssn FOREIGN KEY 
-- Mgr_start_date
-- Dept_create_date
-- FOREIGN KEY fk_departament

desc dependent;
-- dependent
-- 
-- Essn - PRIMARY KEY
-- Dependent_name - PRIMARY KEY
-- Sex
-- Bdate
-- Relationship
-- Age
-- FOREIGN KEY fk_dependent 

desc dept_locations;
-- dept_locations
--
-- Dnumber PRIMARY KEY
-- Dlocation PRIMARY KEY
-- FOREIGN KEY fk_dept_locations

desc employee;
-- employee
--
-- Fname
-- Minit
-- Lname
-- Ssn PRIMARI KEY
-- Bdate
-- Address
-- sex
-- Salary
-- Super_ssn FOREIGN KEY 
-- Dno
-- FOREIGN KEY fk_employee

desc project;
-- project
--
-- Pname
-- Pnumber
-- Plocation
-- Dnum
-- FOREIGN KEY fk_project

desc works_on;
-- works_on
--
-- Essn
-- Pno
-- Hours
-- FOREIGN KEY fk_works_on fk_works_on2

