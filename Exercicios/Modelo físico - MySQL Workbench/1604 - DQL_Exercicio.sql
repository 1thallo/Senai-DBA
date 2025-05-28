-- 01. Quais os países cadastrados?
SELECT PAIS
FROM PAIS;

-- 02. Quantos países estão cadastrados?
SELECT COUNT(*)
FROM PAIS;

-- 03. Quantos países que terminam com a letra "A" estão cadastrados?
SELECT PAIS
FROM PAIS
WHERE PAIS REGEXP '[a]$';

-- 04. Listar, sem repetição, os anos que houveram lançamento de filme.
SELECT DISTINCT ANO_DE_LANCAMENTO
FROM FILME;

-- 05. Alterar o ano de lançamento igual 2007 para filmes que iniciem com a Letra "B".
SELECT *
FROM FILME
WHERE ANO_DE_LANCAMENTO = 2006
AND TITULO REGEXP '^[b]';

UPDATE FILME
	SET ANO_DE_LANCAMENTO = 2007
    WHERE TITULO REGEXP '^[b]';

SELECT *
FROM FILME
WHERE TITULO REGEXP '^[b]';

-- 06. Listar os filmes que possuem duração do filme maior que 100 e classificação igual a "G".
SELECT *
FROM FILME
WHERE DURACAO_DO_FILME > 100
AND CLASSIFICACAO = 'G';

-- 07. Alterar o ano de lançamento igual 2008 para filmes que possuem duração da locação menor que 4 e classificação igual a "PG".
SELECT * 
FROM FILME
WHERE DURACAO_DA_LOCACAO < 4
    AND CLASSIFICACAO = 'PG';
    
UPDATE FILME
	SET ANO_DE_LANCAMENTO = 2008
    WHERE DURACAO_DA_LOCACAO < 4
    AND CLASSIFICACAO = 'PG';

SELECT * 
FROM FILME
WHERE DURACAO_DA_LOCACAO < 4
    AND CLASSIFICACAO = 'PG';
    
-- 08. Listar a quantidade de filmes que estejam classificados como "PG-13" e preço da locação maior que 2.40.
SELECT COUNT(*)
FROM FILME
WHERE CLASSIFICACAO LIKE 'PG-13'
AND PRECO_DA_LOCACAO > 2.40;

-- 09. Listar a quantidade de filmes por classificação.
SELECT CLASSIFICACAO, COUNT(*)
FROM FILME
GROUP BY CLASSIFICACAO;

-- 10. Listar, sem repetição, os preços de locação dos filmes cadastrados.
SELECT DISTINCT PRECO_DA_LOCACAO
FROM FILME;