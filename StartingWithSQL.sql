-- Inicio SQL 

-- Criando um esquema/banco de dados -- if not exists para criação se não existir
create schema if not exists company_constraints;
create database if not exists company_constraints;
use company_constraints;

-- Criando tabelas

create table if not exists employee(
	fname varchar(15) NOT NULL,
	Minit char,
	Lname varchar(15) NOT NULL, #variavel
	Ssn char(9), #fixo NOT NULL
	Bdate date,
	Address varchar(30),
	sex char,
	Salary decimal(10,2),
	Super_ssn char(9),
	Dno int NOT NULL,
	constraint chk_salary_employee check (Salary > 2000.0), #checkando se salario é maior q 2000 check de restrição
	constraint pk_employee primary key (Ssn)  
);

-- Descrevendo atributos de tabelas
desc employee;

create table if not exists departament(
	Dname varchar(15) not null,
    Dnumber int not null,
    Mgr_ssn char(9),
    Mgr_start_date date,
    Dept_create_date date,
    constraint chk_date_dept check (Dept_create_date < Mgr_start_date),
    constraint pk_dept primary key (Dnumber), 
    constraint unique_name_dept Unique (Dname), #ou podia por unique no dname no final
    foreign key (Mgr_ssn) references employee(Ssn)
);

-- Definição de Foreign Key
#'def', 'company_constraints', 'departament_ibfk_1', 'company_constraints', 'departament', 'FOREIGN KEY', 'YES'

-- Modificando constraint foreign key - drop e add
alter table departament drop constraint departament_ibfk_1;
alter table departament add constraint fk_departament foreign key(Mgr_ssn) references employee(Ssn) on update cascade; #deixa banco consistente update cascade para apagar em cascata.

desc departament;

create table if not exists dept_locations(
	Dnumber int not null,
    Dlocation varchar(15) not null, # nao pode ser nulo
    constraint pk_dept_locations primary key (Dnumber, Dlocation),
    constraint fk_dept_locations foreign key (Dnumber) references departament(Dnumber)
);

-- ALTERANDO FOREIGN KEY COM DROP E ADD

alter table dept_locations drop constraint fk_dept_locations;
alter table dept_locations add constraint fk_dept_locations foreign key(Dnumber) references departament(Dnumber) on delete cascade on update cascade;

create table if not exists project(
	Pname varchar(15) not null,
    Pnumber int not null,
    Plocation varchar(15),
    Dnum int not null,
    primary key (Pnumber),
    constraint unique_project Unique (Pname), #constrains vem no final
	constraint fk_project foreign key (Dnum) references departament(Dnumber)
);

create table if not exists works_on(
	Essn char(9) not null,
    Pno int not null,
    Hours decimal(3,1) not null,  
    primary key (Essn, Pno), 
    constraint fk_works_on foreign key(Essn) references employee(Ssn),
    constraint fk_works_on2 foreign key(Pno) references project(Pnumber)
);

create table if not exists dependent(
	Essn char(9) not null,
    Dependent_name varchar(15) not null,
    Sex char, -- M or F
    Bdate date,
    Relationship varchar(8),
    Age int not null,
    constraint chk_age_dependent check (Age < 22),
    primary key(Essn, Dependent_name),
    constraint fk_dependent foreign key(Essn) references employee(Ssn)
);

-- Query constrains relacionadas a determinado banco de dados
select * from information_schema.table_constraints
	where constraint_schema = 'company_constraints'; 
-- Query restrições referenciais 
select * from information_schema.referential_constraints
	where constraint_schema = 'company_constraints'; 
    
-- Alterando tabela e adicionando a exclusão em cascata/ em referência.
alter table employee
	add constraint fk_employee
    foreign key(Super_ssn) references employee(Ssn)
    on delete set null
    on update cascade;  

-- Inserindo de dados em banco de dados
use company_constraints;
show tables;
desc employee;

-- 1
insert into employee values ('Gustavo','F','Guimarães','123456789','1995-11-24','Rua X','M','2200.00','123456789','1');

-- +1
insert into employee values ('Guilherme','F','Guimarães','223456789','1995-11-24','Rua X','M','2200.00','223456789','2'),
							('Pedro','F','Guimarães','323456789','1995-11-24','Rua X','M','2200.00','323456789','3'),
							('Laura','F','Guimarães','423456789','1995-11-24','Rua X','F','2200.00','423456789','4'),
							('Paulo','F','Guimarães','523456789','1995-11-24','Rua X','M','2200.00','523456789','5');
select * from employee;

-- Dependentes
 desc dependent; 
 insert into dependent values ('523456789','Son','M','1999-11-12','Son','11'),
								 ('123456789','Son','M','1999-11-12','Son','11'),
								 ('223456789','Son','M','1999-11-12','Son','11'),
								 ('323456789','Son','M','1999-11-12','Son','11'),
								 ('423456789','Son','M','1999-11-12','Son','11');
 select * from dependent;

-- Departamentos
insert into departament values ('Research','5','123456789','2022-07-07','2021-05-05'),
								('Administrator','4','223456789','2022-05-05','2021-05-05'),
								('Headquarters','1','323456789','2022-04-04','2021-05-05');
select * from departament;

-- Local Departamentos
desc dept_locations;
insert into dept_locations values ('4','Stafford'),('5','Seatle');
select * from dept_locations;

-- Projetos
desc project; 
select * from project;
insert into project values ('Project X','1','Seatle','5')
							('Project D','2','Boston','4'),
							('Project Q','3','Sttaford','4'),
							('Project B','4','Chicago','1');
select * from project;                            
                            
-- Works on
desc works_on;
insert into works_on values ('123456789','1','30.2'),
							('223456789','2','30.2'),
							('323456789','3','30.2'),
							('423456789','4','30.2');
select * from works_on;

-- INICIANDO COM QUERY'S ( CONSULTAS )

select * from employee;

-- Buscando Ssn, Nome, Nome de Departamento em employee e departamentos onde o Ssn seja o mesmo da gerencia do Departamento, especificadamente.
select Ssn, Fname, Dname from employee e, departament d where (e.Ssn = d.Mgr_ssn); 

-- Nome, nome do depentende e relação de employee, dependent onde Essn do Dependente seja = Ssn do Employee.
select Fname, Dependent_name, Relationship from employee, dependent where Essn = Ssn;

-- Tudo de employee, departamento, dept_locations, project, works_on, dependent; em resumo, tudo do banco de dados atual company_constraints.
select * from employee, departament, dept_locations, project, works_on, dependent; #td

-- Data Bdate, Endereço de employee onde Nome='Gustavo'... 
select Bdate, Address from employee where Fname = 'Gustavo' and Minit = 'F' and Lname = 'Guimarães'; 

-- Departamentos com nomes de 'Research'
select * from departament where Dname = 'Research';

-- Nome sobrenome endereço de employee e departamento onde o departamento seja 'Research' e o numero do Dpto conjunte com o Dno do employee, pk&fk
select Fname, Lname, Address from employee, departament where Dname='Research' and Dnumber = Dno;

-- Nome do projeto, Essn FK, Nome e horas de project, works_on e employee onde o Nº do Projeto seja o mesmo nº de projeto de workson e o Essn seja = Ssn de employee;
select Pname, Essn, Fname, Hours from project, works_on, employee where Pnumber = Pno and Essn = Ssn;

-- Acessando descrições do banco de dados e das tabelas(atributos)
use company_constraints;
show tables;
desc departament;
desc dependent;
desc dept_locations;
desc employee;
desc project;
desc works_on;

-- Retirando ambiguidade através do alaising (renoameamento) alias statement
select Dname, l.Dlocation as Departament_location
		from departament as d, dept_locations as l
		where d.Dnumber = l.Dnumber;

-- Concatenando
select concat(Fname, ' ', Lname) as Employee from employee;

-- Atenção:
-- PK & FK Inexistente - insira ta erro 10..
-- Valores violados/condições violadas erro 14..
-- Conversão inválida/padrões inválidos erro 12..  

-- OPERAÇÃO ARITMÉTICA NO SGBD

-- COM CONCATENAÇÃO
SELECT concat(Fname,' ', Lname)Name, Salary, Salary * 0.11 AS INSS FROM employee;

-- POSTGRESQL SELECT Fname, Mint,Lname ||','||','|| Name, Salary, Salary * 0.11 AS INSS FROM employee;

-- Expressões e Alias

select Fname, Lname, Salary, Salary*0.011 as INSS from employee;
select Fname, Lname, Salary, round(Salary*0.11,2) as INSS from employee;

-- Definir aumento de salaário para os gerentes q trabalham em projeto associado a produto x 
select * from employee e, works_on as w, project as p
	where (e.Ssn = w.Essn and w.Pno=p.Pnumber and p.Pname='Project X');

-- Concatenando e renomeando atributos p/ melhor visualização
select concat(Fname,' ', Lname) as Complete_name, Salary, round(1.1*Salary,2) as Increased_salary
	from employee e, works_on as w, project as p
	where (e.Ssn = w.Essn and w.Pno=p.Pnumber);
;

-- Expressões e concatenações de Strings

-- Recuperando informações dos departamentos e localizações com managers;
select Dname as Departament, Mgr_ssn as Manager from departament d, dept_locations l, employee e
	where d.Dnumber = l.Dnumber;
    
-- Recuperando informaççoes de departamentos em locais específicos 
--select Dname as Departament, Mgr_ssn as Manager, Address from departament d, dept_locations l, employee e
	where d.Dnumber = l.Dnumber and Dlocation ='Houston';
    
-- Recuperando todos os gerentes que trabalham em Houston;
select Dname as Departament, concat(Fname,' ',Lname) as Manager, Address from departament d, dept_locations l, employee e
	where d.Dnumber = l.Dnumber and Mgr_ssn = e.Ssn;
    
-- Recuperando gerentes e departamentos com nomes
select Dname as Departament, concat(Fname,' ',Lname) as Name, Dlocation as Manager, Address from departament d, dept_locations l, employee e
	where d.Dnumber = l.Dnumber and Mgr_ssn = e.Ssn;

-- Like e between

-- Like
select concat(Fname, ' ', Lname) Name, Dname as Departament from employee, departament
	where (Dno=Dnumber and Address like '%Houston%');    
select concat(Fname, ' ', Lname) Name, Address from employee
	where (Address like '_Chicago%'); #sendo 1º caracter ou no final para sendo última

-- Between
select Fname, Lname from employee where (Salary between 2000 and 4000);

-- Operadores lógicos 

select Bdate, Address from employee where Fname = 'Gustavo' and Lname='Guimarães';
select Fname, Lname from employee, departament where Dname = 'Research' or 'Administrador' ORDER BY (Fname);
select Fname, Lname from employee, departament where Dname = 'Research' or 'Administrador' ORDER BY (Fname) DESC LIMIT 4;
select concat(Fname,' ', Lname)Name from employee, departament where Dname = 'Research' and Dnumber=Dno ;

