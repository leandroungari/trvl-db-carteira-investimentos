create table if not exists posicoes (
	id varchar(8) not null primary key,
	id_carteira varchar(8) not null,
	data_referencia date not null,
	titulo varchar(40) not null,
	quantidade decimal not null,
	custo_total decimal not null,
	corretagem_total decimal not null,
    data_criacao date not null,
    id_movimento varchar(8) not null,
    constraint fk_id_movimento foreign key(id_movimento) references movimentos(id),
    constraint fk_id_carteira foreign key(id_carteira) references carteiras(id)
);