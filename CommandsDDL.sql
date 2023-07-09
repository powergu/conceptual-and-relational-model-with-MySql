-- explorando comandos DDL

select now() as Timestamp;

create database if not exists manipulation;
use manipulation;
show tables;

CREATE TABLE  if not exists bankAccount (
	Id_account INT auto_increment PRIMARY KEY,
    Ag_num INT NOT NULL,
    Ac_num INT NOT NULL,
    Saldo FLOAT,
    CONSTRAINT identification_account_constraint UNIQUE (Ag_num, Ac_num)
);

ALTER TABLE bankAccount ADD LimiteCredito FLOAT NOT NULL DEFAULT 500.00;
ALTER table bankAccount ADD Email VARCHAR(60);
ALTER TABLE bankAccount drop Email;
desc bankAccount;

INSERT INTO bankAccount (Ag_num, Ac_num, Saldo) VALUES ('156','123456','0');
select * from bankAccount;

CREATE TABLE  if not exists bankClient (
	Id_client INT auto_increment,
    ClientAccount INT,
    CPF CHAR(11) NOT NULL,
    RG CHAR(9) NOT NULL,
    Nome VARCHAR(50) NOT NULL,
    Endereço VARCHAR(100) NOT NULL,
    Renda_mensal FLOAT,
    primary key(Id_Client,ClientAccount),
    CONSTRAINT fk_account_client foreign key (ClientAccount) REFERENCES bankAccount (Id_account)
    ON UPDATE CASCADE
    );
    
    drop table bankClient;
    
    desc bankclient;
ALTER TABLE bankClient ADD UFF CHAR(2) NOT NULL DEFAULT 'RJ';

UPDATE bankClient SET UFF='MG' WHERE Nome='Fulano';

INSERT INTO bankClient (ClientAccount, CPF, RG, Nome, Endereço, Renda_mensal) 
VALUES (
	'1','12345678911','123456789','Fulano','Rua X e B','5560.00'
);

select * from bankClient;


    
CREATE TABLE bankTransactions(
	Id_transaction INT auto_increment PRIMARY KEY,
    Ocorrencia datetime,
    Status_transaction VARCHAR(20),
    Valor_transferido FLOAT,
    Source_account INT,
    Destination_account INT,
    CONSTRAINT fk_source_transaction foreign key(Source_account) REFERENCES bankAccount(Id_account),
    CONSTRAINT fk_destination_transaction foreign key(Destination_account) REFERENCES bankAccount(Id_Account)
);

select * from bankAccount, bankClient;



-- ALTER TABLE nome_tabela MODIFY COLUMN nome_atributo tipo_dados CONDICAO;
-- ALTER TABLE nome_tabela ADD CONSTRAINT nome_constraint CONDICOES;


-- ORDER BY

select Id_account from bankAccount ORDER BY Saldo LIMIT 5;
    