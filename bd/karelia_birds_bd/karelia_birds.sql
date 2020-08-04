drop database if exists karelia_birds;
create database karelia_birds;
use karelia_birds;

-- отряды 
DROP TABLE IF EXISTS ordo;
CREATE TABLE ordo (
	id serial PRIMARY key,
	name_ordo varchar(100),
	name_ordo_english varchar(100),
	name_ordo_latin varchar(100),
	description_ordo varchar(10000)
)COMMENT = 'отряды';


-- IUCN Red List of Threatened Animals
DROP TABLE IF EXISTS red_book_IUCN;
CREATE TABLE red_book_IUCN (
	id serial PRIMARY key,
	security_statuses TINYTEXT NOT NULL,
	description_class TINYTEXT,
	description_class_english TINYTEXT
)COMMENT = 'IUCN Red List of Threatened Animals';


-- классы по Красной книге РФ
DROP TABLE IF EXISTS red_book_rf;
CREATE TABLE red_book_rf (
	id serial PRIMARY key,
	security_statuses int NOT NULL,
	description_class TINYTEXT
)COMMENT = 'классы по Красной книге РФ';


-- суммирование данных по красным книгам
DROP TABLE IF EXISTS red_book;
CREATE TABLE red_book (
	id serial PRIMARY key,
	class_karelia varchar(50),
	class_rf BIGINT UNSIGNED DEFAULT NULL,
	class_all_world BIGINT UNSIGNED DEFAULT NULL,
	note varchar(1000),
	
	FOREIGN KEY (class_rf) REFERENCES red_book_rf(id),
	FOREIGN KEY (class_all_world) REFERENCES red_book_IUCN(id)
)COMMENT = 'суммирование данных по красным книгам';



-- виды  пищи
DROP TABLE IF EXISTS food_name;
CREATE TABLE food_name (
	id serial PRIMARY KEY,
	name varchar(100),
	description_species varchar(10000)
)COMMENT = 'виды  пищи';



-- суммирует виды пищи для вида птицы в один сезон
DROP TABLE IF EXISTS food_sum;
CREATE TABLE food_sum (
	id serial PRIMARY KEY,
	food_1 BIGINT UNSIGNED DEFAULT NULL,
	food_2 BIGINT UNSIGNED DEFAULT NULL,
	food_3 BIGINT UNSIGNED DEFAULT NULL,
	food_4 BIGINT UNSIGNED DEFAULT NULL,
	food_5 BIGINT UNSIGNED DEFAULT NULL,
	food_6 BIGINT UNSIGNED DEFAULT NULL,
	food_7 BIGINT UNSIGNED DEFAULT NULL,
	
	FOREIGN KEY (food_1) REFERENCES food_name(id),
	FOREIGN KEY (food_2) REFERENCES food_name(id),
	FOREIGN KEY (food_3) REFERENCES food_name(id),
	FOREIGN KEY (food_4) REFERENCES food_name(id),
	FOREIGN KEY (food_5) REFERENCES food_name(id),
	FOREIGN KEY (food_6) REFERENCES food_name(id),
	FOREIGN KEY (food_7) REFERENCES food_name(id)
)COMMENT = 'суммирует виды пищи для вида птицы в один сезон';


-- виды пищи по сезонам
DROP TABLE IF EXISTS food;
CREATE TABLE food (
    id serial PRIMARY KEY,
	winter BIGINT UNSIGNED DEFAULT NULL,
	spring BIGINT UNSIGNED DEFAULT NULL,
	summer BIGINT UNSIGNED DEFAULT NULL,
	autumn BIGINT UNSIGNED DEFAULT NULL,
	
	FOREIGN KEY (winter) REFERENCES food_sum(id),
	FOREIGN KEY (spring) REFERENCES food_sum(id),
	FOREIGN KEY (summer) REFERENCES food_sum(id),
	FOREIGN KEY (autumn) REFERENCES food_sum(id)
)COMMENT = 'виды пищи по сезонам';


-- вид птиц
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
	id serial PRIMARY KEY,
	name varchar(100),
	name_latin varchar(100),
	name_english varchar(100),
	description_species varchar(10000),
	ordo_id BIGINT UNSIGNED DEFAULT NULL,
	food BIGINT UNSIGNED DEFAULT NULL,
	weight_unit float,
	length_unit float,
	red_book BIGINT UNSIGNED DEFAULT NULL,
	
	FOREIGN KEY (ordo_id) REFERENCES ordo(id),
	FOREIGN KEY (red_book) REFERENCES red_book(id),
	FOREIGN KEY (food) REFERENCES food(id)
)COMMENT = 'вид птиц';



-- яйца
DROP TABLE IF EXISTS eggs;
CREATE TABLE eggs (
	id serial PRIMARY KEY,
	id_profiles BIGINT UNSIGNED DEFAULT NULL,
	description_species varchar(10000),
	size_egg_leg int,
	size_egg_width int,
	weight_egg int
)COMMENT = 'яйца';


-- гнезда
DROP TABLE IF EXISTS nest;
CREATE TABLE nest (
	id serial PRIMARY KEY,
	id_profiles BIGINT UNSIGNED DEFAULT NULL,
	description_species varchar(10000),
	size_nest varchar(100)
)COMMENT = 'гнезда';




-- размножение
DROP TABLE IF EXISTS reproduction;
CREATE TABLE reproduction (
	reproduction_id BIGINT UNSIGNED DEFAULT NULL,
	data_start_nest varchar(50),
	len_incubation_eggs TINYINT,
	count_eggs TINYINT,
	egg_id BIGINT UNSIGNED DEFAULT NULL,
	nest_id BIGINT UNSIGNED DEFAULT NULL,
	date_start_fly_nestling varchar(50),
	age float,
	
	FOREIGN KEY (reproduction_id) REFERENCES profiles(id),
	FOREIGN KEY (egg_id) REFERENCES eggs(id),
	FOREIGN KEY (nest_id) REFERENCES nest(id)
)COMMENT = 'размножение';



 DROP TABLE IF EXISTS type_medio;
CREATE TABLE type_medio (
	id SERIAL PRIMARY KEY,
    name varchar(10)
);

-- фото и видео
DROP TABLE IF EXISTS medio;
CREATE TABLE medio(
	id serial PRIMARY KEY,
	id_profile BIGINT UNSIGNED DEFAULT NULL,
	name varchar(100),
	description varchar(1000),
	avtor varchar(100),
	data_creat_foto date,
	data_download DATETIME DEFAULT NOW(),
	gender bit DEFAULT 0 ,
	geo varchar(100),
	nest bit DEFAULT 0 ,
	eggs bit DEFAULT 0 ,
	nestling bit DEFAULT 0 ,
	season enum('winter', 'spring', 'summer', 'autumn') NOT NULL,
	link_to_file varchar(1000),
	type_medio BIGINT UNSIGNED DEFAULT NULL,
	
	FOREIGN KEY (type_medio) REFERENCES type_medio(id),
	FOREIGN KEY (id_profile) REFERENCES profiles(id)
	)COMMENT = 'фото и видео';


-- аудио
DROP TABLE IF EXISTS audeo;
CREATE TABLE audeo(
	id serial PRIMARY KEY,
	id_profile BIGINT UNSIGNED DEFAULT NULL,
	name varchar(100),
	description varchar(1000),
	avtor varchar(100),
	data_creat_audeo date,
	data_download DATETIME DEFAULT NOW(),
	gender bit DEFAULT 0 ,
	link_to_file varchar(1000),
	
	FOREIGN KEY (id_profile) REFERENCES profiles(id)
	)COMMENT = 'аудио';
	
