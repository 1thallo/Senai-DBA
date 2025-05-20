-- Adição de colunas essenciais para a carga de dados do arquivo .csv
ALTER TABLE rsttb001_comanda 
	ADD NR_COMANDA INT;

ALTER TABLE rsttb001_comanda
	MODIFY DH_FECHAMENTO DATETIME NULL;

INSERT INTO rsttb001_comanda(NR_COMANDA, NR_MESA, DH_ABERTURA)
VALUES (FLOOR(RAND()*100) + 1, FLOOR(RAND()*60)+1, NOW());