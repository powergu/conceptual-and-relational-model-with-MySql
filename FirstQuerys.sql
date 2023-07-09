show databases;
create database if not exists first_example;
use first_example;
CREATE TABLE if not exists person(
	person_id smallint unsigned,
	fname varchar(20),
	lname varchar(20),
	gender enum('M','F'),
	birth_date DATE,
	street varchar(30),
	city varchar(20),
	state varchar(20),
	country varchar(20),
	postal_code varchar(20),
    constraint pk_person primary key (person_id)
);
desc person;

create table if not exists favorite_food(
	person_id smallint unsigned,
    food varchar(20),
	constraint pk_favorite_food primary key (person_id, food),
    constraint fk_favorite_food_person_id foreign key (person_id) references person(person_id)
);

desc favorite_food;

show databases;
select * from information_schema.table_constraints
where constraint_schema = 'first_example';
select constraint_name from information_schema.table_constraints;
select * from information_schema.table_constraints where constraint_schema = 'first_example';

desc person;

insert into person values('1','Carolina','Silva','F','1979-08-21',
						 'rua tal','Cidade J','RJ','Brasil','26054-159'),
                         ('2','Paula','Silva','F','1979-08-21',
						 'rua tal','Cidade J','RJ','Brasil','26054-159'),
                         ('3','Roberta','Silva','F','1979-08-21',
						 'rua tal','Cidade J','RJ','Brasil','26054-159');
                         
                         
select * from person;

delete from person where person_id=2 or person_id=3 or person_id=4;

select * from person;

desc favorite_food;

insert into favorite_food values ('1', 'lasanha');

select * from favorite_food;

show databases;
use database first_example; #usar banco de dados
show tables; #mostrar tabelas
desc person; #descricao da tabela
select * from person where lname = 'Silva'; #1 tipo de busca especifica
show databases;  #mostrar banco de dados
select now(); #hora data o agora




