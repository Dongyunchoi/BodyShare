-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

USE `bodyshare` ;

-- -----------------------------------------------------
-- Table `bodyshare`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bodyshare`.`user` ;

CREATE TABLE IF NOT EXISTS `bodyshare`.`user` (
  `userNo` INT NOT NULL AUTO_INCREMENT,
  `userId` VARCHAR(45) NOT NULL,
  `userName` VARCHAR(45) NULL DEFAULT NULL,
  `password` VARCHAR(255) NOT NULL,
  `nickname` VARCHAR(255) NOT NULL,
  `gender` VARCHAR(45) NULL DEFAULT NULL,
  `birthDate` DATETIME NULL DEFAULT NULL,
  `address` VARCHAR(255) NULL DEFAULT NULL,
  `height` FLOAT NOT NULL,
  `weight` FLOAT NOT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `profileImageUrl` VARCHAR(255) NULL DEFAULT 'userProfileDefault.png',
  `bannerImageUrl` VARCHAR(255) NULL DEFAULT 'bannerDefault.png',
  PRIMARY KEY (`userNo`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb3;

CREATE UNIQUE INDEX `userId_UNIQUE` ON `bodyshare`.`user` (`userId` ASC);
CREATE UNIQUE INDEX `nickname_UNIQUE` ON `bodyshare`.`user` (`nickname` ASC);


-- -----------------------------------------------------
-- Table `bodyshare`.`community`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bodyshare`.`community` ;

CREATE TABLE IF NOT EXISTS `bodyshare`.`community` (
  `communityNo` INT NOT NULL AUTO_INCREMENT,
  `adminUserNo` INT NOT NULL,
  `interest` INT NOT NULL,
  `communityName` VARCHAR(255) NOT NULL,
  `createdDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `intro` VARCHAR(255) NOT NULL COMMENT '커뮤니티 소개',
  `profileImageUrl` VARCHAR(255) NULL DEFAULT 'communityProfileDefault.png',
  `bannerImageUrl` VARCHAR(255) NULL DEFAULT 'bannerDefault.png',
  PRIMARY KEY (`communityNo`),
  CONSTRAINT `fk_community_adminUserNo`
    FOREIGN KEY (`adminUserNo`)
    REFERENCES `bodyshare`.`user` (`userNo`),
  CONSTRAINT `fk_community_sports1`
    FOREIGN KEY (`interest`)
    REFERENCES `bodyshare`.`sports` (`no`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_community_adminUserNo_idx` ON `bodyshare`.`community` (`adminUserNo` ASC);

CREATE INDEX `fk_community_sports1_idx` ON `bodyshare`.`community` (`interest` ASC);


-- -----------------------------------------------------
-- Table `bodyshare`.`communityPost`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bodyshare`.`communityPost` ;

CREATE TABLE IF NOT EXISTS `bodyshare`.`communityPost` (
  `postNo` INT NOT NULL AUTO_INCREMENT,
  `communityNo` INT NOT NULL,
  `userNo` INT NOT NULL,
  `createdDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modifiedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `title` VARCHAR(255) NOT NULL,
  `content` VARCHAR(255) NULL,
  `locationLat` DOUBLE NULL DEFAULT NULL COMMENT '위도',
  `locationLong` DOUBLE NULL DEFAULT NULL COMMENT '경도',
  `likes` INT NULL DEFAULT '0' COMMENT '좋아요',
  `contentImageUrl` VARCHAR(255) NULL DEFAULT 'postDefault.png',
  `recordDate` VARCHAR(20) NULL,
  PRIMARY KEY (`postNo`),
  CONSTRAINT `fk_communityPost_communityId`
    FOREIGN KEY (`communityNo`)
    REFERENCES `bodyshare`.`community` (`communityNo`),
  CONSTRAINT `fk_communityPost_userNo`
    FOREIGN KEY (`userNo`)
    REFERENCES `bodyshare`.`user` (`userNo`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_communityPost_community1_idx` ON `bodyshare`.`communityPost` (`communityNo` ASC);

CREATE INDEX `fk_communityPost_userNo_idx` ON `bodyshare`.`communityPost` (`userNo` ASC);


-- -----------------------------------------------------
-- Table `bodyshare`.`communityPostComment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bodyshare`.`communityPostComment` ;

CREATE TABLE IF NOT EXISTS `bodyshare`.`communityPostComment` (
  `commentNo` INT NOT NULL AUTO_INCREMENT,
  `postNo` INT NOT NULL,
  `userNo` INT NOT NULL,
  `content` VARCHAR(255) NOT NULL,
  `createdDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modifiedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`commentNo`),
  CONSTRAINT `fk_communityPostComment_postNo`
    FOREIGN KEY (`postNo`)
    REFERENCES `bodyshare`.`communityPost` (`postNo`),
  CONSTRAINT `fk_communityPostComment_userNo`
    FOREIGN KEY (`userNo`)
    REFERENCES `bodyshare`.`user` (`userNo`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_communityPostComment_communityPost1_idx` ON `bodyshare`.`communityPostComment` (`postNo` ASC);

CREATE INDEX `fk_communityPostComment_userNo_idx` ON `bodyshare`.`communityPostComment` (`userNo` ASC);


-- -----------------------------------------------------
-- Table `bodyshare`.`dietRecord`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bodyshare`.`dietRecord` ;

CREATE TABLE IF NOT EXISTS `bodyshare`.`dietRecord` (
  `planNo` INT NOT NULL AUTO_INCREMENT,
  `userNo` INT NOT NULL,
  `foodNo` INT NOT NULL,
  `dietDate` VARCHAR(20) NOT NULL COMMENT '식단 날짜',
  `mealTime` DATETIME NULL DEFAULT NULL COMMENT '식사 시간( 아침, 점심, 저녁)',
  PRIMARY KEY (`planNo`),
  CONSTRAINT `fk_dietPlan_userNo`
    FOREIGN KEY (`userNo`)
    REFERENCES `bodyshare`.`user` (`userNo`),
  CONSTRAINT `fk_dietRecord_food1`
    FOREIGN KEY (`foodNo`)
    REFERENCES `bodyshare`.`food` (`no`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_dietPlan_userNo_idx` ON `bodyshare`.`dietRecord` (`userNo` ASC);

CREATE INDEX `fk_dietRecord_food1_idx` ON `bodyshare`.`dietRecord` (`foodNo` ASC);


-- -----------------------------------------------------
-- Table `bodyshare`.`exerciseRecord`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bodyshare`.`exerciseRecord` ;

CREATE TABLE IF NOT EXISTS `bodyshare`.`exerciseRecord` (
  `planNo` INT NOT NULL AUTO_INCREMENT,
  `userNo` INT NOT NULL,
  `sportsNo` INT NOT NULL,
  `exerciseDate` VARCHAR(20) NOT NULL COMMENT '계획 날짜 및 시간',
  `exerciseTime` INT NOT NULL COMMENT '실제 운동 시간',
  `sets` INT NULL DEFAULT NULL COMMENT '세트 수',
  `weight` INT NULL DEFAULT NULL COMMENT '중량',
  `distance` DOUBLE NULL DEFAULT NULL COMMENT '거리',
  `consum` DOUBLE NOT NULL COMMENT '계산된 소모 칼로리양',
  PRIMARY KEY (`planNo`),
  CONSTRAINT `fk_exercisePlan_userNo`
    FOREIGN KEY (`userNo`)
    REFERENCES `bodyshare`.`user` (`userNo`),
  CONSTRAINT `fk_exerciseRecord_sports1`
    FOREIGN KEY (`sportsNo`)
    REFERENCES `bodyshare`.`sports` (`no`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_exercisePlan_user_idx` ON `bodyshare`.`exerciseRecord` (`userNo` ASC);

CREATE INDEX `fk_exerciseRecord_sports1_idx` ON `bodyshare`.`exerciseRecord` (`sportsNo` ASC);


-- -----------------------------------------------------
-- Table `bodyshare`.`userInterest`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bodyshare`.`userInterest` ;

CREATE TABLE IF NOT EXISTS `bodyshare`.`userInterest` (
  `no` INT NOT NULL AUTO_INCREMENT,
  `userNo` INT NOT NULL,
  `sportsNo` INT NOT NULL,
  PRIMARY KEY (`no`),
  CONSTRAINT `fk_userInterest_sportsNo`
    FOREIGN KEY (`sportsNo`)
    REFERENCES `bodyshare`.`sports` (`no`),
  CONSTRAINT `fk_userInterest_userNo`
    FOREIGN KEY (`userNo`)
    REFERENCES `bodyshare`.`user` (`userNo`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_userInterest_user1_idx` ON `bodyshare`.`userInterest` (`userNo` ASC);

CREATE INDEX `fk_userInterest_sports1_idx` ON `bodyshare`.`userInterest` (`sportsNo` ASC);


-- -----------------------------------------------------
-- Table `bodyshare`.`usersCommunity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bodyshare`.`usersCommunity` ;

CREATE TABLE IF NOT EXISTS `bodyshare`.`usersCommunity` (
  `no` INT NOT NULL AUTO_INCREMENT,
  `userNo` INT NOT NULL,
  `communityNo` INT NOT NULL,
  PRIMARY KEY (`no`),
  CONSTRAINT `fk_usersCommunity_community1`
    FOREIGN KEY (`communityNo`)
    REFERENCES `bodyshare`.`community` (`communityNo`),
  CONSTRAINT `fk_usersCommunity_user1`
    FOREIGN KEY (`userNo`)
    REFERENCES `bodyshare`.`user` (`userNo`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_usersCommunity_user1_idx` ON `bodyshare`.`usersCommunity` (`userNo` ASC);

CREATE INDEX `fk_usersCommunity_community1_idx` ON `bodyshare`.`usersCommunity` (`communityNo` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
