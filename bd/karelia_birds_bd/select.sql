-- поиск всех медио файлов для определенного вида
CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `karelia_birds`.`all_medio_for_person` AS
SELECT
    `pr`.`id` AS `id`,
    `pr`.`name` AS `name`,
    `pr`.`name_latin` AS `name_latin`,
    `m`.`link_to_file` AS `link_to_file`
FROM
    (`karelia_birds`.`profiles` `pr`
JOIN `karelia_birds`.`medio` `m` ON
    ((`m`.`id_profile` = `pr`.`id`)))


USE karelia_birds;
SELECT *
FROM all_medio_for_person
WHERE id = 8;




-- поиск всех аудио файлов для определенного отряда
CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `karelia_birds`.`audeo_for_person` AS
SELECT
     `o`.`id` AS id,
    `o`.`name_ordo` AS `name_ordo`,
    `pr`.`name` AS `name`,
    `au`.`name` AS `name_file`,
    `au`.`link_to_file` AS `file`
FROM
    ((`karelia_birds`.`ordo` `o`
JOIN `karelia_birds`.`profiles` `pr` ON
    ((`o`.`id` = `pr`.`ordo_id` )))
JOIN `karelia_birds`.`audeo` `au` ON
    ((`pr`.`id` = `au`.`id_profile`)))


USE karelia_birds;
SELECT *
FROM audeo_for_person
WHERE id = 5;



-- поиск всех видов входящих в определенный отряд
CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `karelia_birds`.`all_in_the_ordo` AS
SELECT
    `o`.`id` AS `id`,
    `o`.`name_ordo` AS `name_ordo`,
    `o`.`name_ordo_latin` AS `name_ordo_latin`,
    `pr`.`name` AS `name`,
    `pr`.`name_latin` AS `name_latin`
FROM
    (`karelia_birds`.`ordo` `o`
JOIN `karelia_birds`.`profiles` `pr` ON
    ((`o`.`id` = `pr`.`ordo_id`)))


USE karelia_birds;
SELECT *
FROM all_in_the_ordo
WHERE id = 5;


-- данный тригер выполнен в учебных целях
DROP TRIGGER IF EXISTS correct_input;
DELIMITER $$
$$
CREATE DEFINER=`root`@`localhost` TRIGGER `correct_input` BEFORE INSERT ON `medio` FOR EACH ROW BEGIN 
	IF (NEW.nest = 1 AND NEW.eggs = 1) OR (NEW.nest = 1 AND NEW.nestling = 1) OR (NEW.eggs = 1 AND NEW.nestling = 1) THEN 
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'error input. there can only be one value';
	END IF;
END $$
DELIMITER ;

USE karelia_birds;
INSERT INTO karelia_birds.medio
(id_profile, name, description, avtor, data_creat_foto, gender, geo, nest, eggs, nestling, season, link_to_file, type_medio)
VALUES
(10,'temporibus','Dolor quas ea suscipit ut.','avtor_1','1995-02-27', 0, 0, 1, 0, 1,'autumn','http://willmskuhic.com/', 1);


-- список представлений в бд 
SHOW FULL TABLES IN karelia_birds WHERE TABLE_TYPE LIKE 'VIEW';


-- выбор случайной фотографии и названия вида
DROP PROCEDURE IF EXISTS `random_foto`;
DELIMITER $$
$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `karelia_birds`.`random_foto`()
BEGIN
	SELECT 
		pr.name,
		m.name AS name_foto,
		m.link_to_file
	FROM profiles pr
	JOIN medio m ON pr.id = m.id_profile
	WHERE m.type_medio = 1
	ORDER BY RAND()
	LIMIT 1;
END $$
DELIMITER ;

CALL random_foto();
