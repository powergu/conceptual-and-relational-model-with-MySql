-- Criação do banco de dados para o cenário de e-commerce

create database ecommerce;
use ecommerce;

-- Criando tabela cliente

create table Clients(
	idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    constraint unique_cpf_cliente unique (CPF),
    Address varchar(30),
    Bdate date   
);

desc Clients;
-- Criando tabela produto

-- size = dimensão do produto

create table Product(
	idProduct int auto_increment primary key,
    Pname varchar(10),
    Classification_kids bool default false,
    Category enum('Eletronico','Vestimenta','Brinquedos','Alimentos','Móveis') not null,
    Avaliation float default 0,
    Size varchar(10)
);

desc Product;

-- Criando tabela order

create table Orders (
	idOrder int auto_increment primary key,
    idOrderClient int,
	orderStatus enum('Em Andamento','Processando','A caminho','Entregue') default 'Processando',
    OrderDescription varchar(255),
	SendValue float default 10,
    PaymentCash bool default false,
    constraint fk_orders_client foreign key (idOrderClient) references Clients(idClient)
);

-- Criando tabela pagamentos
-- não criada
create table Payments(
	idClient int,
    idPayment int,
    TypePayment enum('Dinheiro','Boleto','Cartão','Dois cartões'),
	LimitAvailable float,
    primary key(idClient, idPayment),
    constraint fk_payment_client foreign key(idClient) references Clients(idClient),
    constraint fk_payment_orders foreign key(idPayment) references Orders(idOrder)
);

-- Criando tabela estoque

create table ProductStorage(
	idStorage int auto_increment primary key,
	Location varchar(255),
    Quantity int default 0
);

-- Criando tabela Fornecedor

create table Supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    Contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);

-- Criando tabela vendedor 

create table Seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    AbstName varchar(255),
    CNPJ char(15) not null,
    CPF char(9) not null,
    Location varchar(255),
    Contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);

-- Criando tabela Produto - Vendedor

create table productSeller(
	idProductSeller int,
    idpProduct int,
    ProdQuantity int default 1,
    primary key (idProductSeller, idpProduct),
    constraint fk_product_seller foreign key (idProductSeller) references Seller(idSeller),
    constraint fk_product_productSeller foreign key (idpProduct) references Product(idProduct)
);

-- Criando tabela Produto/Pedido

create table ProductOrder(
	idPoProduct int,
    idPoOrder int,
    PoQuantity int default 1,
    PoStatus enum('Disponível','Sem estoque') default 'Disponível',
    primary key (idPoProduct, idPoOrder),
    constraint fk_idPoProduct foreign key(idPoProduct) references Product(idProduct),
    constraint fk_idPoOrder foreign key(idPoOrder) references Orders(idOrder)
);

-- Criando tabela Local Estoque

create table storageLocation(
	idLproduct int,
    idLstorage int,
	Location varchar(255) not null,
    primary key(idLproduct, idLstorage),
    constraint fk_SL_product foreign key (idLproduct) references Product(idProduct),
    constraint fk_SL_location foreign key (idLstorage) references ProductStorage(idStorage)
);

