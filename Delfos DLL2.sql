-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema delfos
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `delfos` ;

-- -----------------------------------------------------
-- Schema delfos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `delfos` DEFAULT CHARACTER SET utf8mb3 ;
USE `delfos` ;

-- -----------------------------------------------------
-- Table `delfos`.`empresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `delfos`.`empresa` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `cnpj_cpf` VARCHAR(255) NULL DEFAULT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  `password` VARCHAR(255) NULL DEFAULT NULL,
  `razao_social` VARCHAR(255) NULL DEFAULT NULL,
  `nome_responssavel` VARCHAR(255) NULL DEFAULT NULL,
  `telefone` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `delfos`.`anuncio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `delfos`.`anuncio` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `avaliacao` INT NULL DEFAULT NULL,
  `data_postagem` DATE NOT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `telefone` VARCHAR(255) NULL DEFAULT NULL,
  `texto` VARCHAR(600) NULL DEFAULT NULL,
  `tipo` VARCHAR(255) NULL DEFAULT NULL,
  `nome_anuncio` VARCHAR(255) NULL DEFAULT NULL,
  `valor` VARCHAR(255) NULL DEFAULT NULL,
  `empresa_id` BIGINT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_empresa_anuncio` (`empresa_id` ASC) VISIBLE,
  CONSTRAINT `FK_empresa_anuncio`
    FOREIGN KEY (`empresa_id`)
    REFERENCES `delfos`.`empresa` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `delfos`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `delfos`.`clientes` (
  `id_cliente` BIGINT NOT NULL AUTO_INCREMENT,
  `data_nascimento` DATE NOT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `nome` VARCHAR(180) NULL DEFAULT NULL,
  `password` VARCHAR(255) NULL DEFAULT NULL,
  `telefone` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `delfos`.`comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `delfos`.`comentario` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `avaliacao` INT NULL DEFAULT NULL,
  `texto` VARCHAR(255) NULL DEFAULT NULL,
  `anuncio_id` BIGINT NOT NULL,
  `clientes_id_cliente` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_comentario_anuncio` (`anuncio_id` ASC) VISIBLE,
  INDEX `fk_comentario_clientes1_idx` (`clientes_id_cliente` ASC) VISIBLE,
  CONSTRAINT `FK_comentario_anuncio`
    FOREIGN KEY (`anuncio_id`)
    REFERENCES `delfos`.`anuncio` (`id`),
  CONSTRAINT `fk_comentario_clientes1`
    FOREIGN KEY (`clientes_id_cliente`)
    REFERENCES `delfos`.`clientes` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb3;

CREATE TABLE log (
  id INT AUTO_INCREMENT PRIMARY KEY,
  mensagem VARCHAR(255),
  data_hora DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ALTERS
 alter table empresa modify column email varchar(100);
  
  alter table clientes add ativo boolean;
  
  alter table clientes drop column ativo;
 
 alter table clientes add pagante boolean;
  
  alter table clientes drop column pagante;
  
  

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
SET SQL_SAFE_UPDATES=0;
USE delfos;
