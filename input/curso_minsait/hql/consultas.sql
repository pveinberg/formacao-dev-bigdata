-- CONSULTAS
SELECT * FROM cidade c limit 100

select min(dt_pedido), max(dt_pedido) from pedido 

select * from item_pedido ip 
	join pedido p on p.id_pedido = ip.id_pedido 
	WHERE ip.id_pedido = '46624761513'


select id_cidade, ds_cidade, ds_estado 
    from cidade c 
    join estado e on e.id_estado = c.id_estado
    where e.ds_estado = 'PB'
    limit 10;
   
-- CONCEITOS DO MODELO DIMENSIONAL

-- DATA MART (departamental)
-- DATA WEREHOUSE (organização como um todo)

-- DATA MART PRODUÇÃO + DATA MART VENDAS + DATA MART .. = DATA WEREHOUSE


-- DRILLDOWNs

-- Dimensão Categorização
-- CATEGORIA >> SUBCATEGORIA >> PRODUTO 

-- Dimensão Localização
-- ESTADO >> CIDADE >> FILIAL 

-- Dimensão Tempo
-- HORA >> MOMENTO DO DIA (?) MANHÃ | TARDE | NOITE | MADRUGADA >> DIA >> SEMANA >> MÊS >> TRIMESTRE >> SEMESTRE >> ANO >> ...


describe aula_hive.pedido

select p.ds_produto, s.ds_subcategoria, c.ds_categoria  
	from produto p 
	join subcategoria s on s.id_subcategoria  = p.id_subcategoria 
	join categoria c on c.id_categoria = s.id_categoria 
	
	
SELECT DISTINCT (nm_parceiro) from parceiro p 


-- dimensao tempo ----------------------------
create table if not exists dim_tempo (
	id_pedido string,
	full_date string, 
	week string, 
	weekday string, 
	quarter string, 
	year string, 
	month string, 
	day string
)

insert into table dim_tempo select 
	id_pedido,
	dt_pedido as `full_date`, 
	WEEKOFYEAR(dt_pedido) as `week`,
	DAYOFWEEK(dt_pedido) as `weekday`, 
	QUARTER(dt_pedido) as `quarter`,
	YEAR(dt_pedido) as `year`,
	MONTH (dt_pedido) as `month`,
	DAY(dt_pedido) as `day`
	from pedido p 
	limit 10
	
	
--dimensao localização -------------------
describe aula_hive.cidade
	
create table if not exists dim_localizacao (
	id_filial string,
	ds_filial string, 
	ds_cidade string, 
	ds_estado string
)

insert into dim_localizacao select id_filial, ds_filial, ds_cidade, ds_estado 
	from filial f 
	join cidade c on c.id_cidade = f.id_cidade 
	join estado e on e.id_estado = c.id_estado
	
-- dimensao cliente -------------------

	DESCRIBE aula_hive.cliente 
	
-- fato vendas ------------------
	
--	é igual a pedidos?
	
	SELECT * from cliente c WHERE id_cliente = '78768903'
	
	
	create schema dimensional;


describe aula_hive.pedido

describe database aula_hive;

show tables;

CREATE table if not exists dimensional.fato_pedidos (
	chave_pedidos integer,
	chave_produto integer,
	chave_tempo integer,
	chave_cliente integer,
	chave_localizacao integer,
	id_pedido integer,
	quantidade decimal, 
	vr_total decimal, 
	nm_parceiro string, 
	dt_update timestamp
); 

ALTER TABLE dimensional.fato_pedidos ADD CONSTRAINT chave_pedidos_pk PRIMARY KEY (chave_pedidos); 

create table if not exists dimensional.produtos (
	chave_produto integer,
	id_produto integer,
	nm_produto string,
	vr_unitario decimal,
	nm_subcategoria string,
	nm_categoria string,
	perc_parceiro decimal,
	dt_update timestamp
);

alter table dimensional.produtos add constraint chave_produto_pk primary key (chave_produto);

ALTER TABLE dimensional.produtos 
	ADD CONSTRAINT chave_produto_pk 
	PRIMARY KEY(chave_produto);

create table if not exists dimensional.localizacao (
	chave_localizacao integer,
	id_filial integer,
	nm_filial string,
	nm_cidade string, 
	nm_estado string,
	dt_update timestamp
);

ALTER TABLE dimensional.localizacao ADD CONSTRAINT chave_localizacao_pk PRIMARY KEY(chave_localizacao);

create table if not exists dimensional.clientes (
	chave_cliente integer,
	id_cliente integer,
	nm_cliente string,
	dt_update timestamp
);

ALTER TABLE dimensional.clientes ADD CONSTRAINT chave_cliente_pk PRIMARY KEY(chave_cliente);

create table if not exists dimensional.tempo (
	chave_tempo integer,
	dt_data timestamp, 
	nr_semana integer, 
	nr_dia_semana integer, 
	nr_trimestre integer, 
	ano integer, 
	mes integer, 
	dia integer,
	dt_update timestamp
);

ALTER TABLE dimensional.tempo ADD CONSTRAINT chave_tempo_pk PRIMARY KEY(chave_tempo);

ALTER TABLE dimensional.fato_pedidos ADD CONSTRAINT chave_produto_fk FOREIGN KEY(chave_produto) REFERENCES dimensional.produtos;
ALTER TABLE dimensional.fato_pedidos ADD CONSTRAINT chave_tempo_fk FOREIGN KEY(chave_tempo) REFERENCES dimensional.tempo;
ALTER TABLE dimensional.fato_pedidos ADD CONSTRAINT chave_cliente_fk FOREIGN KEY(chave_cliente) REFERENCES dimensional.clientes;
ALTER TABLE dimensional.fato_pedidos ADD CONSTRAINT chave_localizacao_fk FOREIGN KEY(chave_localizacao) REFERENCES dimensional.localizacao;


hive --version; 


show tables

SELECT p2.id_produto as chaveproduto 
	from aula_hive.pedido p 
	join aula_hive.item_pedido ip on ip.id_pedido = p.id_pedido 
	join aula_hive.produto p2  on p2.id_produto = ip.id_produto 
	limit 2
	



