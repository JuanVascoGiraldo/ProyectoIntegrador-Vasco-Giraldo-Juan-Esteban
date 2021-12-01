-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ListaAnime
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ListaAnime` ;

-- -----------------------------------------------------
-- Schema ListaAnime
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ListaAnime` DEFAULT CHARACTER SET utf8 ;
USE `ListaAnime` ;

-- -----------------------------------------------------
-- Table `ListaAnime`.`musuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ListaAnime`.`musuario` ;

CREATE TABLE IF NOT EXISTS `ListaAnime`.`musuario` (
  `id_usu` INT(8) NOT NULL AUTO_INCREMENT,
  `email_usu` VARCHAR(30) NOT NULL,
  `contra_usu` VARCHAR(20) NOT NULL,
  `nom_usu` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`id_usu`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ListaAnime`.`cgeneroanime`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ListaAnime`.`cgeneroanime` ;

CREATE TABLE IF NOT EXISTS `ListaAnime`.`cgeneroanime` (
  `id_gen` INT(8) NOT NULL,
  `des_gen` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_gen`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ListaAnime`.`mlistaanime`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ListaAnime`.`mlistaanime` ;

CREATE TABLE IF NOT EXISTS `ListaAnime`.`mlistaanime` (
  `id_lista` INT(8) NOT NULL AUTO_INCREMENT,
  `id_usu` INT(8) NOT NULL,
  PRIMARY KEY (`id_lista`),
  INDEX `id_usul_idx` (`id_usu` ASC) ,
  CONSTRAINT `id_usul`
    FOREIGN KEY (`id_usu`)
    REFERENCES `ListaAnime`.`musuario` (`id_usu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ListaAnime`.`Dlistaanime`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ListaAnime`.`Dlistaanime` ;

CREATE TABLE IF NOT EXISTS `ListaAnime`.`Dlistaanime` (
  `id_dlista` INT(8) NOT NULL AUTO_INCREMENT,
  `des_anime` VARCHAR(100) NOT NULL,
  `id_gen` INT(8) NOT NULL,
  `cap` INT(8) NOT NULL,
  `id_lista` INT(8) NOT NULL,
  `estado` INT(2) NOT NULL,
  PRIMARY KEY (`id_dlista`),
  INDEX `id_lista_idx` (`id_lista` ASC) ,
  INDEX `id_gen_idx` (`id_gen` ASC) ,
  CONSTRAINT `id_lista`
    FOREIGN KEY (`id_lista`)
    REFERENCES `ListaAnime`.`mlistaanime` (`id_lista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_gen`
    FOREIGN KEY (`id_gen`)
    REFERENCES `ListaAnime`.`cgeneroanime` (`id_gen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `ListaAnime`.`cgeneroanime`
-- -----------------------------------------------------
START TRANSACTION;
USE `ListaAnime`;
INSERT INTO `ListaAnime`.`cgeneroanime` (`id_gen`, `des_gen`) VALUES (1, 'Comedia');
INSERT INTO `ListaAnime`.`cgeneroanime` (`id_gen`, `des_gen`) VALUES (2, 'Romance');
INSERT INTO `ListaAnime`.`cgeneroanime` (`id_gen`, `des_gen`) VALUES (3, 'Shounen');
INSERT INTO `ListaAnime`.`cgeneroanime` (`id_gen`, `des_gen`) VALUES (4, 'Shoujo');
INSERT INTO `ListaAnime`.`cgeneroanime` (`id_gen`, `des_gen`) VALUES (5, 'Drama');
INSERT INTO `ListaAnime`.`cgeneroanime` (`id_gen`, `des_gen`) VALUES (6, 'Magia');
INSERT INTO `ListaAnime`.`cgeneroanime` (`id_gen`, `des_gen`) VALUES (7, 'Musica');
INSERT INTO `ListaAnime`.`cgeneroanime` (`id_gen`, `des_gen`) VALUES (8, 'Seinen');
INSERT INTO `ListaAnime`.`cgeneroanime` (`id_gen`, `des_gen`) VALUES (9, 'Deportes');
INSERT INTO `ListaAnime`.`cgeneroanime` (`id_gen`, `des_gen`) VALUES (10, 'Fantasia');

COMMIT;

