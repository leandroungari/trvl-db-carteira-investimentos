alter table posicoes add column custo_interno decimal not null, add column custo_externo decimal not null;
alter table posicoes drop column corretagem_total;
alter table posicoes add column cotacao_media decimal;

