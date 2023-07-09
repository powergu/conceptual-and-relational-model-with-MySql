-- Inserindo Dados 

use ecommerce;
show tables;

-- idClient, Fname, Minit, CPF, Address

insert into Clients (Fname, Minit, Lname, CPF, Address) values 
	('Gustavo','F','Guimarães','12398765411','Rua X de X'),
	('Guilherme','F','Guimarães','98765432101','Rua B de B'),
    ('Gabriela','G','Gabs','123456789','Rua J de Japa'),
    ('Carlos','F','Almeida','78945612312','Rua E de Q'),
    ('Beatriz','A','Lopes','12312345612','Rua A de B'),
    ('Paula','C','Oliveira','78978945612','Rua F de N');
    
-- idProduct,Pname, Classification_kids, bool, Category('Eletronico','Vestimenta','Brinquedos','Alimentos','Móveis'), Avaliation, Size
insert into Product(Pname, Classification_kids, Category, Avaliation, Size) values
	('Fone ',false,'Eletronico','4',null),
    ('Barbie ',true,'Brinquedos','3',null),
    ('Body ',true,'Vestimenta','5',null),
    ('Microfone',false,'Eletronico','4',null),
    ('Sofá',false,'Móveis','3','3x57x80');
    
-- idOrder, idOrderClient, orderStatus, OrderDescription, SendValue, PaymentCash

insert into Orders (idOrderClient, orderStatus, OrderDescription, SendValue, PaymentCash) values
(1,default,'Aplicativo',null,1),
(2,default,'Aplicativo',50,0),
(3,'A Caminho',null,null,1),
(4,default,'Web Site',150,0);

-- idPoProduct, idPoOrder, PoQuantity, PoStatus

insert into ProductOrder (idPoProduct, idPoOrder, PoQuantity, PoStatus) values 
(1,5,2,null),
(2,5,1,null),
(3,6,1,null);

desc ProductStorage;
insert into ProductStorage (Location, Quantity) values 
('Rio de Janeiro',1000),
('Rio de Janeiro',500),
('São Paulo',10),
('São Paulo',100),
('São Paulo',10),
('Brasília',60);
show tables;

insert into StorageLocation (idLproduct, idLstorage, Location) values 
(1,2,'RJ'),
(2,6,'GO');

insert into Supplier(SocialName, CNPJ, Contact) values 
('Almeida e Filhos','123456789123456','12345678912'),
('EletroSilva','321654987654321','32165498732'),
('Jardinaria Autolar','789456123456789','12378945632');

desc ProductSupplier;
insert into ProductSupplier (idPsSupplier, idPsProduct, Quantity) values
(1,1,500),
(1,2,400),
(2,4,633),
(3,3,5),
(2,5,10);

desc Seller;

insert into Seller (SocialName, AbstName, CNPJ, CPF, Location, Contact) values
('Tech Eletro',null,123456789456789,789654322,'Rio de Janeiro',32165498798),
('Bar bearia',null,456456456789456,123548674,'Rio de Janeiro',32165498798),
('Kids World',null,654987654987321,332165458,'São Paulo',1199784512);

desc ProductSeller;
select * from Seller;
use ecommerce;
desc productSeller;
insert into productSeller(idP_Seller, idPProduct, ProdQuantity) values (1,6,80), (2,7,10); 	