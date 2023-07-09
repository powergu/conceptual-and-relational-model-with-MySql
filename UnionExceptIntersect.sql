-- UNION, EXCEPT E INTERSECT
show databases;
show tables;
create database teste;
use teste;

create table R(
	A char(2)
);

create table S(
	A char(2)
);

insert into R(A) values ('A1'),('A2'),('A2'),('A3');
INSERT INTO S(A) VALUES ('A1'),('A1'),('A2'),('A3'),('A4'),('A5');

SELECT * FROM R;
SELECT * FROM S;

-- EXCEPT USA-SE NOT IN
select * from S where A not in (select A from R);

-- UNION
(select distinct R.A from R) UNION (select distinct S.A from S);
(select R.A from R) UNION (select S.A from S);

-- INTERSECT 
select R.A from R where R.A in (select S.A from S);



