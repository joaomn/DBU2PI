

-- Selecionar todos os anúncios juntamente com as informações da empresa correspondente

SELECT anuncio.*, empresa.razao_social
FROM anuncio
INNER JOIN empresa ON anuncio.empresa_id = empresa.id;


-- Selecionar todos os comentários de um determinado anúncio

SELECT *
FROM comentario
WHERE anuncio_id = 3;

-- Selecionar todos os anúncios com avaliação superior a 4

SELECT *
FROM anuncio
WHERE avaliacao > 4;

-- Selecionar todos os clientes que não fizeram nenhum comentário
SELECT *
FROM clientes
WHERE id_cliente NOT IN (SELECT DISTINCT clientes_id_cliente FROM comentario);

-- Selecionar todos os anúncios e contar quantos comentários cada um possui
SELECT anuncio.*, (SELECT COUNT(*) FROM comentario WHERE anuncio_id = anuncio.id) AS total_comentarios
FROM anuncio;


-- Selecionar as 5  empresas com mais anúncios

SELECT empresa.*, COUNT(anuncio.id) AS total_anuncios
FROM empresa
LEFT JOIN anuncio ON empresa.id = anuncio.empresa_id
GROUP BY empresa.id
ORDER BY total_anuncios DESC
LIMIT 5;

-- Selecionar os clientes que fizeram  3 ou mais comentários

SELECT clientes.*
FROM clientes
INNER JOIN comentario ON clientes.id_cliente = comentario.clientes_id_cliente
GROUP BY clientes.id_cliente
HAVING COUNT(comentario.id) >= 3;

-- Selecionar os anúncios de uma determinada empresa ordenados por data de postagem

SELECT anuncio.*
FROM anuncio
INNER JOIN empresa ON anuncio.empresa_id = empresa.id
WHERE empresa.id = 5
ORDER BY anuncio.data_postagem DESC;


-- Selecionar os anúncios com avaliação superior à média de avaliações de todos os anúncios

SELECT *
FROM anuncio
WHERE avaliacao > (SELECT AVG(avaliacao) FROM anuncio);

-- Selecionar as empresas que possuem o anúncio com a maior avaliação

SELECT empresa.*
FROM empresa
INNER JOIN anuncio ON empresa.id = anuncio.empresa_id
WHERE anuncio.avaliacao = (SELECT MAX(avaliacao) FROM anuncio);

-- Selecionar os anúncios que possuem pelo menos um comentário com avaliação 3 ou inferior

SELECT anuncio.*
FROM anuncio
INNER JOIN comentario ON anuncio.id = comentario.anuncio_id
WHERE comentario.avaliacao <= 3;

-- Selecionar os clientes que fizeram comentários nos anúncios de uma determinada empresa

SELECT clientes.*
FROM clientes
INNER JOIN comentario ON clientes.id_cliente = comentario.clientes_id_cliente
INNER JOIN anuncio ON comentario.anuncio_id = anuncio.id
INNER JOIN empresa ON anuncio.empresa_id = empresa.id
WHERE empresa.id = 10;

-- Selecionar os anúncios com mais de 45 caracteres de texto

SELECT *
FROM anuncio
WHERE LENGTH(texto) > 45;

-- Selecionar os anúncios que possuem o mesmo tipo de um determinado anúncio

SELECT *
FROM anuncio
WHERE tipo = (SELECT tipo FROM anuncio WHERE id = 1);

-- Selecionar os clientes que possuem pelo menos um comentário com avaliação superior à média de avaliações de todos os comentários

SELECT clientes.*
FROM clientes
WHERE id_cliente IN (SELECT DISTINCT clientes_id_cliente FROM comentario WHERE avaliacao > (SELECT AVG(avaliacao) FROM comentario));

-- Selecionar os anúncios e a quantidade de comentários de cada um, ordenados pelo número de comentários em ordem decrescente

SELECT anuncio.*, (SELECT COUNT(*) FROM comentario WHERE comentario.anuncio_id = anuncio.id) AS total_comentarios
FROM anuncio
ORDER BY total_comentarios DESC;


-- Selecionar os anúncios que possuem pelo menos um comentário do cliente com um determinado ID

SELECT anuncio.*
FROM anuncio
INNER JOIN comentario ON anuncio.id = comentario.anuncio_id
WHERE comentario.clientes_id_cliente = 32;

-- Relatório de clientes com a quantidade de comentários realizados em anúncios de uma determinada empresa
SELECT clientes.nome, COUNT(comentario.id) AS total_comentarios
FROM clientes
INNER JOIN comentario ON clientes.id_cliente = comentario.clientes_id_cliente
INNER JOIN anuncio ON comentario.anuncio_id = anuncio.id
INNER JOIN empresa ON anuncio.empresa_id = empresa.id
WHERE empresa.id = 10
GROUP BY clientes.id_cliente;

-- Relatório de anúncios com a média de avaliação e o nome da empresa correspondente
SELECT anuncio.*, round( AVG(comentario.avaliacao), 2) AS media_avaliacao, empresa.razao_social
FROM anuncio
LEFT JOIN comentario ON anuncio.id = comentario.anuncio_id
LEFT JOIN empresa ON anuncio.empresa_id = empresa.id
GROUP BY anuncio.id;


-- Relatorio de todos os anuncios do mes de junho do ano de 2023
SELECT *
FROM anuncio
WHERE MONTH(data_postagem) = 6 AND YEAR(data_postagem) = 2023;

-- Relatorio dos anuncios com valor abaixo do valor medio dos anunicos
SELECT *
FROM anuncio
WHERE valor < (
    SELECT AVG(valor)
    FROM anuncio
);

