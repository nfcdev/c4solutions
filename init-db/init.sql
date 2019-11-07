CREATE DATABASE IF NOT EXISTS c4db;
USE c4db;

DROP TABLE IF EXISTS `Package`;
DROP TABLE IF EXISTS `Shelf`;
DROP TABLE IF EXISTS `StorageEvent`;
DROP TABLE IF EXISTS `StorageMap`;
DROP TABLE IF EXISTS `Container`;
DROP TABLE IF EXISTS `StorageRoom`;
DROP TABLE IF EXISTS `Branch`;
DROP TABLE IF EXISTS `Article`;
DROP TABLE IF EXISTS `Case`;
DROP TABLE IF EXISTS `User`;

CREATE TABLE `Case` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`reference_number` VARCHAR(255) NOT NULL UNIQUE,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Article` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`material_number` VARCHAR(255) NOT NULL UNIQUE,
	`description` varchar(255),
	`case` INT NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `StorageEvent` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`action` varchar(30) NOT NULL,
	`timestamp` INT(10) NOT NULL,
	`user` INT NOT NULL,
	`comment` varchar(255),
	`package` varchar(255),
	`shelf` varchar(255) NOT NULL,
	`storage_room` varchar(255) NOT NULL,
	`article` INT NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `StorageRoom` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`branch` INT NOT NULL,
	`name` varchar(60) NOT NULL UNIQUE,
	PRIMARY KEY (`id`)
);

CREATE TABLE `StorageMap` (
	`article` INT NOT NULL,
	`container` INT NOT NULL,
	PRIMARY KEY (`article`)
);

CREATE TABLE `Branch` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`name` varchar(60) NOT NULL UNIQUE,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Package` (
	`id` INT NOT NULL,
	`package_number` varchar(255) NOT NULL UNIQUE,
	`shelf` INT NOT NULL,
	`case` INT NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Container` (
	`current_storage_room` INT NOT NULL,
	`id` INT NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Shelf` (
	`id` INT NOT NULL,
	`shelf_name` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `User` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`employee_no` varchar(30) NOT NULL UNIQUE,
	`email` varchar(60) NOT NULL,
	`role` varchar(10) NOT NULL,
	PRIMARY KEY (`id`)
);

select 'ADDING FOREIGN KEY CONSTRAINTS' AS '';


ALTER TABLE `Article` ADD CONSTRAINT `Article_fk0` FOREIGN KEY (`case`) REFERENCES `Case`(`id`);

ALTER TABLE `StorageEvent` ADD CONSTRAINT `StorageEvent_fk0` FOREIGN KEY (`user`) REFERENCES `User`(`id`);

ALTER TABLE `StorageEvent` ADD CONSTRAINT `StorageEvent_fk1` FOREIGN KEY (`article`) REFERENCES `Article`(`id`);

ALTER TABLE `StorageRoom` ADD CONSTRAINT `StorageRoom_fk0` FOREIGN KEY (`branch`) REFERENCES `Branch`(`id`);

ALTER TABLE `StorageMap` ADD CONSTRAINT `StorageMap_fk0` FOREIGN KEY (`article`) REFERENCES `Article`(`id`);

ALTER TABLE `StorageMap` ADD CONSTRAINT `StorageMap_fk1` FOREIGN KEY (`container`) REFERENCES `Container`(`id`);

ALTER TABLE `Package` ADD CONSTRAINT `Package_fk0` FOREIGN KEY (`id`) REFERENCES `Container`(`id`);

ALTER TABLE `Package` ADD CONSTRAINT `Package_fk1` FOREIGN KEY (`shelf`) REFERENCES `Shelf`(`id`);

ALTER TABLE `Package` ADD CONSTRAINT `Package_fk2` FOREIGN KEY (`case`) REFERENCES `Case`(`id`);

ALTER TABLE `Container` ADD CONSTRAINT `Container_fk0` FOREIGN KEY (`current_storage_room`) REFERENCES `StorageRoom`(`id`);

ALTER TABLE `Shelf` ADD CONSTRAINT `Shelf_fk0` FOREIGN KEY (`id`) REFERENCES `Container`(`id`);

select 'INSERTING INTO BRANCH' AS '';

INSERT INTO `Branch` (`name`) VALUES ("DNA"),("Finger"),("Uppackning"),("Vapen"),("Bio-analys");

select 'INSERTING INTO STORAGE ROOM' AS '';

INSERT INTO `StorageRoom` (`name`, `branch`) VALUES ("DNA materialrum 1", 1), ("DNA materialrum 2", 1),("Finger materialrum", 2),("Uppackning förråd", 3),("Vapen 1", 4),("Bio-analys rum 1", 5);

select 'INSERTING INTO USER' AS '';

INSERT INTO `User` (`employee_no`, `email`, `role`) VALUES ("1", "user1@example.com", "user"), ("2", "user2@example.com", "admin");

select 'INSERTING INTO CASE' AS '';

INSERT INTO `Case` (`reference_number`) VALUES ("607345"),("782393"),("440305"),("295073"),("700439"),("493064"),("013931"),("868911"),("587912"),("268182");
INSERT INTO `Case` (`reference_number`) VALUES ("926656"),("846405"),("468240"),("137492"),("976316"),("434857"),("371777"),("657496"),("813814"),("688496");
INSERT INTO `Case` (`reference_number`) VALUES ("783524"),("486184"),("515426"),("954898"),("594120"),("747238"),("869172"),("293190"),("759037"),("840264");
INSERT INTO `Case` (`reference_number`) VALUES ("948555"),("654425"),("795245"),("267294"),("985407"),("918521"),("079699"),("214030"),("207526"),("944992");
INSERT INTO `Case` (`reference_number`) VALUES ("408528"),("724999"),("728492"),("102912"),("194874"),("267992"),("410104"),("822745"),("757591"),("532509");
INSERT INTO `Case` (`reference_number`) VALUES ("040340"),("769251"),("158130"),("772381"),("959888"),("958520"),("303457"),("896836"),("199699"),("044556");
INSERT INTO `Case` (`reference_number`) VALUES ("129274"),("925869"),("486272"),("505841"),("053729"),("930088"),("928874"),("443033"),("744052"),("355155");
INSERT INTO `Case` (`reference_number`) VALUES ("648555"),("230017"),("661583"),("677953"),("040639"),("805560"),("801350"),("149017"),("065957"),("161510");
INSERT INTO `Case` (`reference_number`) VALUES ("848771"),("058801"),("473815"),("121938"),("743996"),("138214"),("870365"),("330957"),("992829"),("507902");
INSERT INTO `Case` (`reference_number`) VALUES ("122703"),("191558"),("720254"),("316845"),("987617"),("794692"),("522771"),("999568"),("850522"),("408022");

select 'INSERTING INTO ARTICLE' AS '';

INSERT INTO `Article` (`material_number`,`description`,`case`) VALUES ("129274-90","Gevärspipa",61),("743996-44","Tops med saliv",85),("505841-57","Gevärspipa",64),("657496-88","Del av finger",18),("587912-24","Bomullstopp med krutrester",9),("999568-01","Tavla med blodstänk",98),("515426-76","Dryckesglas",23),("987617-29","Gevärspipa",95),("316845-62","Dryckesglas",94),("468240-93","Tavla med blodstänk",13);
INSERT INTO `Article` (`material_number`,`description`,`case`) VALUES ("700439-82","Slagträ",5),("728492-20","Revolver",43),("822745-68","Del av finger",48),("493064-62","Tomhylsa",6),("443033-11","Glas-skärva",68),("505841-51","Pilspets",64),("149017-72","Tavla med blodstänk",78),("720254-31","Tomhylsa",93),("293190-62","Tavla med blodstänk",28),("954898-31","Slagträ",24);
INSERT INTO `Article` (`material_number`,`description`,`case`) VALUES ("958520-44","Kula",56),("515426-15","Revolver",23),("102912-28","Tavla med blodstänk",44),("129274-77","Bomullstopp med krutrester",61),("846405-08","Glas-skärva",12),("846405-04","Pilspets",74),("330957-26","Slagträ",88),("408022-99","Pilspets",100),("408022-03","Tavla med blodstänk",100),("928874-55","Dryckesglas",67);
INSERT INTO `Article` (`material_number`,`description`,`case`) VALUES ("985407-57","Pilspets",35),("747238-57","Tavla med blodstänk",26),("728492-56","Glas-skärva",43),("440305-77","Slagträ",3),("959888-01","Tomhylsa",55),("976316-64","Tomhylsa",15),("532509-45","Blodig kniv",50),("772381-80","Tops med saliv",54),("985407-99","Blodig kniv",35),("158130-22","Revolver",53);
INSERT INTO `Article` (`material_number`,`description`,`case`) VALUES ("303457-40","Glas-skärva",57),("040340-59","Del av finger",51),("728492-73","Bomullstopp med krutrester",43),("48-137492","Kula",14),("813814-59","Del av finger",19),("161510-07","Revolver",80),("918521-23","Tomhylsa",36),("079699-21","Tops med saliv",37),("587912-72","Del av finger",9),("959888-66","Gevärspipa",55);
INSERT INTO `Article` (`material_number`,`description`,`case`) VALUES ("846405-48","Blodig kniv",12),("724999-89","Glas-skärva",42),("199699-73","Blodig kniv",59),("813814-48","Tops med saliv",19),("744052-24","Bomullstopp med krutrester",69),("795245-66","Tops med saliv",33),("868911-55","Slagträ",8),("207526-35","Gevärspipa",39),("607345-09","Pilspets",1),("607345-19","Bomullstopp med krutrester",1);
INSERT INTO `Article` (`material_number`,`description`,`case`) VALUES ("408528-36","Tomhylsa",41),("044556-91","Glas-skärva",60),("065957-81","Dryckesglas",79),("976316-70","Kula",15),("443033-03","Bomullstopp med krutrester",68),("728492-85","Glas-skärva",43),("848771-37","Tavla med blodstänk",81),("058801-96","Glas-skärva",82),("677953-20","Slagträ",74),("926656-99","Pilspets",11);
INSERT INTO `Article` (`material_number`,`description`,`case`) VALUES ("594120-38","Del av finger",25),("303457-73","Bomullstopp med krutrester",57),("295073-10","Tops med saliv",4),("434857-28","Slagträ",16),("846405-10","Blodig kniv",12),("230017-92","Tavla med blodstänk",72),("976316-56","Tops med saliv",15),("769251-29","Glas-skärva",52),("840264-26","Del av finger",30),("058801-54","Kula",82);
INSERT INTO `Article` (`material_number`,`description`,`case`) VALUES ("493064-07","Kula",6),("805560-44","Tomhylsa",76),("408528-58","Dryckesglas",41),("743996-92","Revolver",85),("954898-69","Tavla med blodstänk",24),("102912-41","Tops med saliv",44),("316845-11","Tops med saliv",94),("954898-68","Tops med saliv",24),("594120-62","Tomhylsa",25),("999568-62","Tavla med blodstänk",98);
INSERT INTO `Article` (`material_number`,`description`,`case`) VALUES ("677953-53","Bomullstopp med krutrester",74),("158130-87","Tops med saliv",53),("121938-18","Tomhylsa",84),("408528-75","Tops med saliv",41),("058801-36","Tavla med blodstänk",82),("330957-03","Gevärspipa",88),("925869-86","Tavla med blodstänk",62),("948555-50","Dryckesglas",31),("930088-45","Del av finger",66);

select 'INSERTING INTO CONTAINER' AS '';

INSERT INTO `Container` (`current_storage_room`) VALUES (3),(3),(2),(3),(1),(3),(3),(6),(2),(6);
INSERT INTO `Container` (`current_storage_room`) VALUES (6),(6),(1),(5),(3),(3),(2),(4),(3),(4);
INSERT INTO `Container` (`current_storage_room`) VALUES (5),(4),(5),(5),(6),(3),(4),(2),(5),(1);
INSERT INTO `Container` (`current_storage_room`) VALUES (5),(4),(4),(3),(1),(6),(4),(1),(1),(5);
INSERT INTO `Container` (`current_storage_room`) VALUES (3),(3),(1),(4),(4),(1),(1),(3),(5),(6);
INSERT INTO `Container` (`current_storage_room`) VALUES (6),(3),(2),(5),(1),(1),(1),(2),(6),(4);
INSERT INTO `Container` (`current_storage_room`) VALUES (3),(4),(2),(2),(2),(5),(2),(3),(3),(3);
INSERT INTO `Container` (`current_storage_room`) VALUES (3),(4),(3),(4),(5),(6),(1),(2),(3),(6);
INSERT INTO `Container` (`current_storage_room`) VALUES (5),(6),(4),(3),(1),(2),(4),(5),(6),(5);
INSERT INTO `Container` (`current_storage_room`) VALUES (2),(4),(1),(3),(2),(1),(1),(4),(4),(4);

select 'INSERTING INTO SHELF' AS '';

INSERT INTO `Shelf` (`shelf_name`,`id`) VALUES ("A1",1),("A1",2),("A7",3),("B9",4),("B5",5),("A7",6),("A5",7),("B5",8),("Hylla 9",9),("Hylla 6",10);
INSERT INTO `Shelf` (`shelf_name`,`id`) VALUES ("Hylla 1",11),("B7",12),("A2",13),("B6",14),("Hylla 9",15),("Hylla 5",16),("Hylla 4",17),("Hylla 9",18),("A5",19),("A7",20);
INSERT INTO `Shelf` (`shelf_name`,`id`) VALUES ("Hylla 2",21),("Hylla 7",22),("Hylla 8",23),("B1",24),("Hylla 9",25),("Hylla 8",26),("Hylla 9",27),("Hylla 8",28),("B7",29),("B4",30);
INSERT INTO `Shelf` (`shelf_name`,`id`) VALUES ("Hylla 6",31),("B5",32),("A6",33),("Hylla 8",34),("B2",35),("A4",36),("A8",37),("A2",38),("B4",39),("A9",40);
INSERT INTO `Shelf` (`shelf_name`,`id`) VALUES ("A6",41),("A3",42),("B6",43),("A8",44),("Hylla 5",45),("Hylla 1",46),("B5",47),("A4",48),("A2",49),("Hylla 3",50);

select 'INSERTING INTO PACKAGE' AS '';

INSERT INTO `Package` (`package_number`,`shelf`,`case`,`id`) VALUES (CONCAT((SELECT reference_number FROM `Case` WHERE id = 23),"-01"),41,23,51),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 61),"-01"),34,61,52),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 91),"-02"),26,91,53),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 54),"-01"),39,77,54),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 34),"-01"),38,34,55),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 69),"-02"),24,69,56),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 75),"-01"),16,75,57),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 80),"-01"),19,80,58),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 68),"-01"),39,68,59),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 32),"-02"),14,32,60);
INSERT INTO `Package` (`package_number`,`shelf`,`case`,`id`) VALUES (CONCAT((SELECT reference_number FROM `Case` WHERE id = 12),"-01"),3,12,61),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 51),"-01"),22,51,62),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 66),"-01"),33,66,63),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 9),"-01"),5,9,64),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 16),"-02"),38,16,65),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 53),"-02"),21,53,66),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 69),"-01"),12,69,67),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 16),"-01"),24,16,68),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 44),"-01"),15,44,69),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 85),"-01"),30,85,70);
INSERT INTO `Package` (`package_number`,`shelf`,`case`,`id`) VALUES (CONCAT((SELECT reference_number FROM `Case` WHERE id = 60),"-01"),42,60,71),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 27),"-01"),46,27,72),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 53),"-01"),45,53,73),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 32),"-01"),22,32,74),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 9),"-03"),2,9,75),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 42),"-01"),49,42,76),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 65),"-02"),26,65,77),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 31),"-02"),36,31,78),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 24),"-01"),45,24,79),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 39),"-01"),5,39,80);
INSERT INTO `Package` (`package_number`,`shelf`,`case`,`id`) VALUES (CONCAT((SELECT reference_number FROM `Case` WHERE id = 21),"-01"),21,21,81),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 63),"-01"),12,63,82),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 83),"-01"),47,83,83),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 21),"-02"),37,21,84),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 76),"-01"),36,76,85),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 22),"-01"),18,22,86),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 71),"-01"),25,71,87),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 81),"-02"),38,81,88),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 65),"-01"),7,65,89),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 73),"-01"),31,73,90);
INSERT INTO `Package` (`package_number`,`shelf`,`case`,`id`) VALUES (CONCAT((SELECT reference_number FROM `Case` WHERE id = 5),"-01"),34,5,91),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 62),"-01"),13,62,92),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 36),"-01"),35,36,93),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 30),"-02"),27,30,94),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 74),"-01"),20,74,95),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 77),"-01"),8,77,96),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 56),"-02"),38,56,97),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 58),"-01"),28,58,98),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 81),"-01"),21,81,99),(CONCAT((SELECT reference_number FROM `Case` WHERE id = 56),"-01"),18,56,100);

select 'INSERTING INTO STORAGE EVENT' AS '';

INSERT INTO `StorageEvent` (`action`,`timestamp`,`user`,`shelf`,`storage_room`,`article`) VALUES ("checked_out","1579679491",1,"Hylla 8",(SELECT name FROM `StorageRoom` WHERE id = 3),58),("processed","1539888637",1,"B3",(SELECT name FROM `StorageRoom` WHERE id = 1),43),("checked_in","1568421059",1,"B4",(SELECT name FROM `StorageRoom` WHERE id = 5),90),("checked_out","1603385263",1,"B1",(SELECT name FROM `StorageRoom` WHERE id = 2),34),("checked_in","1556825202",1,"B5",(SELECT name FROM `StorageRoom` WHERE id = 1),31),("checked_out","1570842595",1,"B7",(SELECT name FROM `StorageRoom` WHERE id = 1),73),("checked_in","1570472260",1,"A7",(SELECT name FROM `StorageRoom` WHERE id = 4),19),("checked_out","1555426322",1,"B5",(SELECT name FROM `StorageRoom` WHERE id = 1),76),("discarded","1566570749",1,"A3",(SELECT name FROM `StorageRoom` WHERE id = 1),16),("checked_in","1561245403",1,"Hylla 8",(SELECT name FROM `StorageRoom` WHERE id = 2),22);
INSERT INTO `StorageEvent` (`action`,`timestamp`,`user`,`shelf`,`storage_room`,`article`) VALUES ("checked_out","1586481335",1,"Hylla 8",(SELECT name FROM `StorageRoom` WHERE id = 1),34),("discarded","1572944369",1,"Hylla 4",(SELECT name FROM `StorageRoom` WHERE id = 6),42),("processed","1578808903",1,"B4",(SELECT name FROM `StorageRoom` WHERE id = 3),63),("discarded","1561640116",1,"A8",(SELECT name FROM `StorageRoom` WHERE id = 6),41),("discarded","1550741776",1,"A2",(SELECT name FROM `StorageRoom` WHERE id = 5),80),("processed","1578346979",1,"A1",(SELECT name FROM `StorageRoom` WHERE id = 5),14),("discarded","1559963157",1,"B10",(SELECT name FROM `StorageRoom` WHERE id = 3),28),("discarded","1551758491",1,"B1",(SELECT name FROM `StorageRoom` WHERE id = 4),49),("discarded","1538438024",1,"Hylla 3",(SELECT name FROM `StorageRoom` WHERE id = 5),94),("checked_in","1579695921",1,"B6",(SELECT name FROM `StorageRoom` WHERE id = 6),10);
INSERT INTO `StorageEvent` (`action`,`timestamp`,`user`,`shelf`,`storage_room`,`article`) VALUES ("processed","1599075310",1,"B4",(SELECT name FROM `StorageRoom` WHERE id = 2),98),("checked_out","1569820201",1,"Hylla 4",(SELECT name FROM `StorageRoom` WHERE id = 5),95),("checked_in","1540395734",1,"A1",(SELECT name FROM `StorageRoom` WHERE id = 2),68),("discarded","1541561798",1,"A5",(SELECT name FROM `StorageRoom` WHERE id = 4),2),("checked_in","1553482881",1,"Hylla 7",(SELECT name FROM `StorageRoom` WHERE id = 1),53),("processed","1551590615",1,"Hylla 5",(SELECT name FROM `StorageRoom` WHERE id = 2),3),("checked_out","1602439366",1,"A9",(SELECT name FROM `StorageRoom` WHERE id = 5),38),("checked_in","1548471201",1,"Hylla 8",(SELECT name FROM `StorageRoom` WHERE id = 4),79),("processed","1571953521",1,"B1",(SELECT name FROM `StorageRoom` WHERE id = 2),10),("processed","1578682453",1,"Hylla 3",(SELECT name FROM `StorageRoom` WHERE id = 3),69);
INSERT INTO `StorageEvent` (`action`,`timestamp`,`user`,`shelf`,`storage_room`,`article`) VALUES ("checked_out","1562701860",1,"B1",(SELECT name FROM `StorageRoom` WHERE id = 1),5),("processed","1592412062",1,"",(SELECT name FROM `StorageRoom` WHERE id = 4),26),("processed","1562493096",1,"A2",(SELECT name FROM `StorageRoom` WHERE id = 6),56),("checked_in","1578276463",1,"B9",(SELECT name FROM `StorageRoom` WHERE id = 3),75),("checked_in","1598590044",1,"A4",(SELECT name FROM `StorageRoom` WHERE id = 6),18),("checked_in","1568870213",1,"",(SELECT name FROM `StorageRoom` WHERE id = 2),49),("processed","1599156214",1,"B5",(SELECT name FROM `StorageRoom` WHERE id = 1),67),("checked_in","1587669829",1,"B5",(SELECT name FROM `StorageRoom` WHERE id = 1),81),("processed","1541359586",1,"B4",(SELECT name FROM `StorageRoom` WHERE id = 1),93),("checked_out","1549445134",1,"A4",(SELECT name FROM `StorageRoom` WHERE id = 6),30);
INSERT INTO `StorageEvent` (`action`,`timestamp`,`user`,`shelf`,`storage_room`,`article`) VALUES ("checked_in","1554301769",1,"A9",(SELECT name FROM `StorageRoom` WHERE id = 3),1),("checked_out","1578399938",1,"A4",(SELECT name FROM `StorageRoom` WHERE id = 3),33),("checked_out","1580459629",1,"A4",(SELECT name FROM `StorageRoom` WHERE id = 3),99),("checked_out","1542981890",1,"A9",(SELECT name FROM `StorageRoom` WHERE id = 2),34),("checked_in","1585151037",1,"A2",(SELECT name FROM `StorageRoom` WHERE id = 1),33),("checked_out","1576601984",1,"B6",(SELECT name FROM `StorageRoom` WHERE id = 1),33),("discarded","1603178506",1,"Hylla 2",(SELECT name FROM `StorageRoom` WHERE id = 3),3),("discarded","1589933513",1,"Hylla 1",(SELECT name FROM `StorageRoom` WHERE id = 2),97),("checked_in","1545584474",1,"A8",(SELECT name FROM `StorageRoom` WHERE id = 6),64),("discarded","1545510671",1,"",(SELECT name FROM `StorageRoom` WHERE id = 3),62);
INSERT INTO `StorageEvent` (`action`,`timestamp`,`user`,`shelf`,`storage_room`,`article`) VALUES ("processed","1550097308",1,"B3",(SELECT name FROM `StorageRoom` WHERE id = 2),86),("checked_in","1603364155",1,"A4",(SELECT name FROM `StorageRoom` WHERE id = 5),71),("processed","1591404018",1,"B1",(SELECT name FROM `StorageRoom` WHERE id = 5),32),("processed","1576610492",1,"B7",(SELECT name FROM `StorageRoom` WHERE id = 3),62),("checked_out","1540456940",1,"B3",(SELECT name FROM `StorageRoom` WHERE id = 5),39),("checked_out","1545193807",1,"A5",(SELECT name FROM `StorageRoom` WHERE id = 5),24),("checked_in","1563108280",1,"A3",(SELECT name FROM `StorageRoom` WHERE id = 5),58),("checked_out","1596204461",1,"A8",(SELECT name FROM `StorageRoom` WHERE id = 2),35),("checked_out","1574410837",1,"B6",(SELECT name FROM `StorageRoom` WHERE id = 5),84),("checked_out","1587635426",1,"Hylla 7",(SELECT name FROM `StorageRoom` WHERE id = 1),22);
INSERT INTO `StorageEvent` (`action`,`timestamp`,`user`,`shelf`,`storage_room`,`article`) VALUES ("checked_out","1548761276",1,"A4",(SELECT name FROM `StorageRoom` WHERE id = 6),69),("checked_in","1581607734",1,"B6",(SELECT name FROM `StorageRoom` WHERE id = 6),18),("discarded","1553560365",1,"Hylla 5",(SELECT name FROM `StorageRoom` WHERE id = 5),15),("checked_out","1576868400",1,"A8",(SELECT name FROM `StorageRoom` WHERE id = 1),9),("checked_out","1553749483",1,"A1",(SELECT name FROM `StorageRoom` WHERE id = 1),69),("checked_out","1573123535",1,"B4",(SELECT name FROM `StorageRoom` WHERE id = 2),64),("checked_out","1539261456",1,"B9",(SELECT name FROM `StorageRoom` WHERE id = 3),55),("processed","1584872612",1,"B6",(SELECT name FROM `StorageRoom` WHERE id = 6),32),("checked_out","1562454342",1,"A5",(SELECT name FROM `StorageRoom` WHERE id = 1),3),("checked_in","1582844133",1,"Hylla 6",(SELECT name FROM `StorageRoom` WHERE id = 4),38);
INSERT INTO `StorageEvent` (`action`,`timestamp`,`user`,`shelf`,`storage_room`,`article`) VALUES ("discarded","1567344655",1,"B9",(SELECT name FROM `StorageRoom` WHERE id = 6),37),("checked_in","1591117575",1,"B4",(SELECT name FROM `StorageRoom` WHERE id = 2),36),("processed","1542307714",1,"Hylla 2",(SELECT name FROM `StorageRoom` WHERE id = 6),61),("processed","1557665034",1,"A8",(SELECT name FROM `StorageRoom` WHERE id = 6),52),("checked_out","1549609024",1,"A4",(SELECT name FROM `StorageRoom` WHERE id = 5),3),("checked_in","1566061871",1,"Hylla 3",(SELECT name FROM `StorageRoom` WHERE id = 6),88),("checked_in","1569086540",1,"A3",(SELECT name FROM `StorageRoom` WHERE id = 1),2),("discarded","1563416540",1,"Hylla 4",(SELECT name FROM `StorageRoom` WHERE id = 1),31),("processed","1553748041",1,"B6",(SELECT name FROM `StorageRoom` WHERE id = 2),69),("checked_in","1571609541",1,"Hylla 1",(SELECT name FROM `StorageRoom` WHERE id = 2),78);
INSERT INTO `StorageEvent` (`action`,`timestamp`,`user`,`shelf`,`storage_room`,`article`) VALUES ("discarded","1546980200",1,"A7",(SELECT name FROM `StorageRoom` WHERE id = 2),6),("discarded","1552867484",1,"B5",(SELECT name FROM `StorageRoom` WHERE id = 2),13),("discarded","1558375751",1,"B9",(SELECT name FROM `StorageRoom` WHERE id = 6),36),("checked_out","1570415893",1,"A7",(SELECT name FROM `StorageRoom` WHERE id = 2),66),("processed","1570867080",1,"Hylla 3",(SELECT name FROM `StorageRoom` WHERE id = 5),45),("checked_in","1559434652",1,"A7",(SELECT name FROM `StorageRoom` WHERE id = 6),58),("processed","1547793352",1,"A7",(SELECT name FROM `StorageRoom` WHERE id = 6),40),("processed","1600589476",1,"B2",(SELECT name FROM `StorageRoom` WHERE id = 1),3),("checked_out","1584576651",1,"B10",(SELECT name FROM `StorageRoom` WHERE id = 1),75),("checked_in","1546407555",1,"B7",(SELECT name FROM `StorageRoom` WHERE id = 4),85);
INSERT INTO `StorageEvent` (`action`,`timestamp`,`user`,`shelf`,`storage_room`,`article`) VALUES ("checked_in","1583319177",1,"A9",(SELECT name FROM `StorageRoom` WHERE id = 1),69),("processed","1541610114",1,"A3",(SELECT name FROM `StorageRoom` WHERE id = 6),55),("discarded","1588287937",1,"B1",(SELECT name FROM `StorageRoom` WHERE id = 6),25),("checked_out","1564863080",1,"Hylla 9",(SELECT name FROM `StorageRoom` WHERE id = 3),18),("discarded","1591399075",1,"A9",(SELECT name FROM `StorageRoom` WHERE id = 6),38),("discarded","1567907632",1,"B1",(SELECT name FROM `StorageRoom` WHERE id = 4),6),("processed","1580507972",1,"A3",(SELECT name FROM `StorageRoom` WHERE id = 4),78),("checked_out","1592354469",1,"A9",(SELECT name FROM `StorageRoom` WHERE id = 1),16),("checked_out","1594871411",1,"Hylla 5",(SELECT name FROM `StorageRoom` WHERE id = 4),63),("processed","1593643776",1,"Hylla 8",(SELECT name FROM `StorageRoom` WHERE id = 2),17);

select 'INSERTING INTO STORAGEMAP' AS '';

INSERT INTO `StorageMap` (`article`,`container`) VALUES (1,61),(2,48),(3,72),(4,83),(5,85),(6,94),(7,73),(8,91),(9,28),(10,13);
INSERT INTO `StorageMap` (`article`,`container`) VALUES (11,40),(12,95),(13,41),(14,56),(15,89),(16,1),(17,84),(18,1),(19,40),(20,89);
INSERT INTO `StorageMap` (`article`,`container`) VALUES (21,51),(22,19),(23,85),(24,73),(25,2),(26,61),(27,23),(28,37),(29,18),(30,24);
INSERT INTO `StorageMap` (`article`,`container`) VALUES (31,99),(32,59),(33,73),(34,59),(35,55),(36,74),(37,43),(38,66),(39,20),(40,13);
INSERT INTO `StorageMap` (`article`,`container`) VALUES (41,30),(42,63),(43,69),(44,100),(45,2),(46,83),(47,59),(48,29),(49,5),(50,98);
INSERT INTO `StorageMap` (`article`,`container`) VALUES (51,20),(52,89),(53,5),(54,10),(55,92),(56,93),(57,3),(58,16),(59,10),(60,20);
INSERT INTO `StorageMap` (`article`,`container`) VALUES (61,94),(62,26),(63,100),(64,7),(65,27),(66,51),(67,87),(68,38),(69,46),(70,67);
INSERT INTO `StorageMap` (`article`,`container`) VALUES (71,92),(72,96),(73,72),(74,30),(75,97),(76,87),(77,86),(78,90),(79,56),(80,48);
INSERT INTO `StorageMap` (`article`,`container`) VALUES (81,14),(82,92),(83,93),(84,3),(85,77),(86,32),(87,8),(88,22),(89,38),(90,19);
INSERT INTO `StorageMap` (`article`,`container`) VALUES (91,44),(92,23),(93,69),(94,46),(95,99),(96,39),(97,90),(98,18),(99,49);