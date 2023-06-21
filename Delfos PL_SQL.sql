
DELIMITER //

CREATE PROCEDURE inserir_cliente(
    IN data_nascimento DATE,
    IN email_cliente VARCHAR(255),
    IN nome_cliente VARCHAR(180),
    IN senha VARCHAR(255),
    IN telefone_cliente VARCHAR(255)
)
BEGIN
    INSERT INTO clientes (data_nascimento, email, nome, password, telefone)
    VALUES (data_nascimento, email_cliente, nome_cliente, senha, telefone_cliente);
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE selecionar_cliente_por_id(
    IN id_cliente BIGINT
)
BEGIN
    SELECT *
    FROM clientes
    WHERE id_cliente = id_cliente;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE selecionar_todos_clientes()
BEGIN
    SELECT * FROM clientes;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE alterar_email_e_telefone_cliente(
    IN id_cliente BIGINT,
    IN novo_email VARCHAR(255),
    IN novo_telefone VARCHAR(255)
)
BEGIN
    UPDATE clientes
    SET email = novo_email,
        telefone = novo_telefone
    WHERE id_cliente = id_cliente;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE deletar_cliente_por_id(
    IN id_cliente BIGINT
)
BEGIN
    DELETE FROM clientes
    WHERE id_cliente = id_cliente;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE selecionar_anuncios_por_palavra_chave(
    IN palavra_chave VARCHAR(255)
)
BEGIN
    SELECT *
    FROM anuncio
    WHERE nome_anuncio LIKE CONCAT(palavra_chave, '%');
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE inserir_anuncio(
    IN p_avaliacao INT,
    IN p_data_postagem DATE,
    IN p_email VARCHAR(255),
    IN p_telefone VARCHAR(255),
    IN p_texto VARCHAR(600),
    IN p_tipo VARCHAR(255),
    IN p_nome_anuncio VARCHAR(255),
    IN p_valor VARCHAR(255),
    IN p_empresa_id BIGINT
)
BEGIN
    INSERT INTO anuncio (avaliacao, data_postagem, email, telefone, texto, tipo, nome_anuncio, valor, empresa_id)
    VALUES (p_avaliacao, p_data_postagem, p_email, p_telefone, p_texto, p_tipo, p_nome_anuncio, p_valor, p_empresa_id);
END //

DELIMITER ;

DELIMITER //



CREATE PROCEDURE deletar_anuncio_por_id(
    IN p_id_anuncio BIGINT
)
BEGIN
    DELETE FROM anuncio
    WHERE id = p_id_anuncio;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE inserir_empresa(
    IN p_cnpj_cpf VARCHAR(255),
    IN p_email VARCHAR(100),
    IN p_password VARCHAR(255),
    IN p_razao_social VARCHAR(255),
    IN p_nome_responsavel VARCHAR(255),
    IN p_telefone VARCHAR(255)
)
BEGIN
    INSERT INTO empresa (cnpj_cpf, email, password, razao_social, nome_responssavel, telefone)
    VALUES (p_cnpj_cpf, p_email, p_password, p_razao_social, p_nome_responsavel, p_telefone);
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE selecionar_todas_empresas()
BEGIN
    SELECT * FROM empresa;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE alterar_avaliacao_empresa_por_id(
    IN p_id_empresa BIGINT,
    IN p_avaliacao INT
)
BEGIN
    UPDATE empresa
    SET avaliacao = p_avaliacao
    WHERE id = p_id_empresa;
END //

DELIMITER ;


-- TRIGGERS

DELIMITER //

CREATE TRIGGER tr_deletar_empresa_anuncio
BEFORE DELETE ON empresa
FOR EACH ROW
BEGIN
    
    DELETE FROM anuncio WHERE empresa_id = OLD.id;
END //

DELIMITER ;


DELIMITER //

CREATE TRIGGER tr_deletar_cliente_comentario
BEFORE DELETE ON clientes
FOR EACH ROW
BEGIN
    
    DELETE FROM comentario WHERE clientes_id_cliente = OLD.id_cliente;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER novo_comentario_trigger
AFTER INSERT ON delfos.comentario
FOR EACH ROW
BEGIN
   
    INSERT INTO log (mensagem) VALUES(CONCAT('Novo comentário inserido: ', NEW.texto));
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER novo_anuncio_trigger
AFTER INSERT ON delfos.anuncio
FOR EACH ROW
BEGIN
    
    INSERT INTO log (mensagem) VALUES (CONCAT('Novo anúncio inserido: ', NEW.nome_anuncio));
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER novo_cliente_trigger
AFTER INSERT ON delfos.clientes
FOR EACH ROW
BEGIN
   
    INSERT INTO log (mensagem) VALUES (CONCAT('Novo cliente inserido: ', NEW.nome));
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER nova_empresa_trigger
AFTER INSERT ON delfos.empresa
FOR EACH ROW
BEGIN
   
    INSERT INTO log (mensagem) VALUES (CONCAT('Nova empresa inserida: ', NEW.razao_social));
END //

DELIMITER ;

