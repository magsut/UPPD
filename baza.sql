-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema uppd
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema uppd
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema uppd
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `uppd` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `uppd` ;

-- -----------------------------------------------------
-- Table `uppd`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uppd`.`user` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `token` VARCHAR(512) NOT NULL,
  `UserName` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(256) NOT NULL,
  `UserLogen` VARCHAR(45) NOT NULL,
  `Age` VARCHAR(45) NOT NULL,
  `Icon` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idUser`),
  UNIQUE INDEX `idUser_UNIQUE` (`idUser` ASC) VISIBLE,
  UNIQUE INDEX `UserName_UNIQUE` (`UserName` ASC) VISIBLE,
  UNIQUE INDEX `token_UNIQUE` (`token` ASC) VISIBLE,
  UNIQUE INDEX `UserLogen_UNIQUE` (`UserLogen` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 42
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
