-- Banco de Dados Ecommerce PT-BR

-- Criação do banco de dados para o cenário de e-commerce
show databases;
create database ecommerce;
use ecommerce;


-- Criando tabela cliente

-- C: Cliente M: Meio S: Sobre
create table clientes(
	idCliente int auto_increment primary key,
    cnome varchar(10),
    mnome char(3),
    snome varchar(20),
    CPF char(11) not null,
    constraint unique_cpf_cliente unique (CPF),
    endereço varchar(30),
    data_nasc date   
);

desc clientes;

-- Criando tabela produto


create table produtos(
	idProduto int auto_increment primary key,
    produto varchar(10),
    class_criança bool default false,
    categoria enum('Eletronico','Vestimenta','Brinquedos','Alimentos','Móveis') not null,
    avaliação float default 0,
    dimensão varchar(10)
);

desc produtos;


-- Criando tabela pedidos

create table pedidos (
	idPedido int auto_increment primary key,
    idPedidoCliente int,
	status_pedido enum('Em Andamento','Processando','A caminho','Entregue') default 'Processando',
    descrição_pedido varchar(255),
	valor float default 10,
    forma_de_pagamento bool default false,
    constraint fk_pedido_cliente foreign key (idPedidoCliente) references clientes(idCliente)
);

desc pedidos;

-- Criando tabela pagamentos
-- não criada
create table pagamentos(
	idClient int,
    idPagamento int,
    tipo_pagamento enum('Dinheiro','Boleto','Cartão','Dois cartões'),
	limite_disponivel float,
    primary key(idClient, idPagamento),
    constraint fk_pagamento_cliente foreign key(idClient) references clientes(idCliente),
    constraint fk_pagamento_pedido foreign key(idPagamento) references pedidos(idPedido)
);

desc pagamentos;

-- Criando tabela estoque

create table estoque(
	idEstoque int auto_increment primary key,
	localidade varchar(255),
    quantidade int default 0
);

desc estoque;

-- Criando tabela Local Estoque

-- Consertando tabela relação estoque/localestoque

create table localestoque(
	idLproduto int,
    idLestoque int,
	Location varchar(255) not null,
    primary key(idLproduto, idLestoque),
    constraint fk_localestoque_produto foreign key (idLproduto) references produtos(idProduto),
    constraint fk_localestoque_localizacao foreign key (idLestoque) references estoque(idEstoque)
);

-- erro de relação (na versão ENG) corrigido.

desc localestoque;

-- Criando tabela Fornecedor

create table fornecedor(
	idFornecedor int auto_increment primary key,
    nome_social varchar(255) not null,
    CNPJ char(15) not null,
    contato char(11) not null,
    constraint unique_fornecedor unique (CNPJ)
);

desc fornecedor;

-- Criando tabela vendedor 

create table vendedor(
	idVendedor int auto_increment primary key,
    nome_social varchar(255) not null,
    nome_fantasia varchar(255),
    CNPJ char(15) not null,
    CPF char(9) not null,
    localidade varchar(255),
    contato char(11) not null,
    constraint unique_cnpj_vendedor unique (CNPJ),
    constraint unique_cpf_vendedor unique (CPF)
);

desc vendedor;

-- Criando tabela Produto - Vendedor

create table produtovendedor(
	idProdutoVedendor int,
    idPVendendor int,
    produto_quantidade int default 1,
    primary key (idProdutoVedendor, idPVendendor),
    constraint fk_product_seller foreign key (idProdutoVedendor) references vendedor(idVendedor),
    constraint fk_product_productSeller foreign key (idPVendendor) references produtos(idProduto)
);

desc produtovendedor;

-- Criando tabela Produto/Pedido

create table produtopedido(
	idPrProduto int,
    idPrPedido int,
    pr_quantidade int default 1,
    pr_status enum('Disponível','Sem estoque') default 'Disponível',
    primary key (idPrProduto, idPrPedido),
    constraint fk_idPoProduct foreign key(idPrProduto) references produtos(idProduto),
    constraint fk_idPoOrder foreign key(idPrPedido) references pedidos(idPedido)
);

desc produtopedido;














