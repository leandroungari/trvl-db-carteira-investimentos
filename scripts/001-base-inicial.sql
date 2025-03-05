create table if not exists  "usuarios"
(
  id varchar(8) not null primary key,
  nome_completo varchar(100) not null,
  email varchar(100) not null,
  senha varchar(256) not null,
  data_criacao timestamp not null,
  ativo bool default(true)
);

create table if not exists "carteiras"
(
  id varchar(8) not null primary key,
  nome varchar(80) not null,
  descricao varchar(150) not null,
  moeda_principal varchar(3) not null,
  moeda_secundaria varchar(3),
  id_usuario varchar(8) not null,
  data_criacao timestamp not null,
  constraint fk_id_usuario foreign key(id_usuario) references usuarios(id)
);

create table tipos_movimento (
	id serial not null primary key,
	descricao varchar(50) not null
);

insert into tipos_movimento (descricao) 
values ('Depósito'),
('Retirada'),
('Câmbio'),
('Desdobramento'),
('Compra'),
('Venda'),
('Vencimento'),
('Proventos');

create table if not exists movimentos (
	id varchar(8) not null primary key,
	id_carteira varchar(8) not null,
	constraint fk_id_carteira foreign key(id_carteira) references carteiras(id),
	data_referencia date not null,
	tipo_movimento int not null,
	constraint fk_tipo_movimento foreign key(tipo_movimento) references tipos_movimento(id),
	processado bool default(false)
);

-------------

create table if not exists saldo_movimentos (
	id varchar(8) not null primary key,
	moeda varchar(3) not null,
	valor decimal not null,
	operacao char not null
)

create table if not exists eventos_saldo (
	id varchar(8) not null primary key,
	constraint fk_id_movimento foreign key(id) references movimentos(id),
	moeda varchar(3) not null,
	valor decimal not null,
	operacao char not null
)


create table if not exists saldos (
	id_carteira varchar(8) not null,
	constraint fk_id_carteira foreign key(id_carteira) references carteiras(id),
	data_referencia date not null,
	contador int not null,
	valor_primario_interno decimal not null,
	valor_primario_externo decimal not null,
	valor_secundario_interno decimal not null,
	valor_secundario_externo decimal not null,
	primary key(id_carteira, data_referencia, contador),
	id_movimento varchar(8) not null,
	constraint fk_id_movimento foreign key(id_movimento) references movimentos(id)
);

-----
create table if not exists cambios (
	id varchar(8) not null primary key,
	constraint fk_id_movimento foreign key(id) references movimentos(id),
	valor_origem decimal not null,
	valor_destino decimal not null,
	taxa decimal not null
)

create table if not exists negociacoes (
	id varchar(8) not null primary key,
	constraint fk_id_movimento foreign key(id) references movimentos(id),
	titulo varchar(30) not null,
	valor decimal not null,
	corretagem decimal not null
)

create table if not exists ajuste_quantidade (
	id varchar(8) not null primary key,
	constraint fk_id_movimento foreign key(id) references movimentos(id),
	titulo varchar(30) not null,
	nova_quantidade decimal not null
);

-------------

create table if not exists vencimentos (
	id varchar(8) not null primary key,
	constraint fk_id_movimento foreign key(id) references movimentos(id),
	titulo varchar(30) not null,
	valor_bruto decimal not null,
	valor_liquido decimal not null,
	imposto decimal 
);

create table if not exists tipos_provento (
	id serial not null primary key,
	descricao varchar(50) not null,
	moeda_principal varchar(3) not null
);

insert into tipos_provento (descricao, moeda_principal)
values ('Dividendo', 'BRL'),
('Juros sobre Capital Próprio', 'BRL'),
('Rendimentos', 'BRL'),
('Dividendos', 'USD'),
('Juros Bonds', 'USD'),

create table if not exists proventos (
	id varchar(8) not null primary key,
	constraint fk_id_movimento foreign key(id) references movimentos(id),
	titulo varchar(30) not null,
	valor decimal not null,
	imposto decimal not null,
	tipo_provento int not null,
	constraint fk_tipo_provento foreign key(tipo_provento) references tipos_provento(id)
)


