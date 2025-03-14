alter table posicoes add column posicao_anterior varchar(8) 
constraint fk_id_posicao_anterior references posicoes(id);