drop database if exists world_of_karelia;
create database world_of_karelia;
use world_of_karelia;


-- блок пользователей

	-- пользователи
	DROP TABLE IF EXISTS users;
	CREATE TABLE users (
		id serial PRIMARY key,
		name_user varchar(100)
	)COMMENT = 'пользователи';


-- блок животные

DROP TABLE IF EXISTS animal_kingdom;
	CREATE TABLE animal_kingdom (
		id serial PRIMARY key,
		name_clade_animal varchar(100)
	)COMMENT = 'царство животные\Подцарство Эуметазои\Bilateria\Nephrozoa';


	-- первичноротые(Protostomia Grobben, 1908)
		-- Линяющие (Ecdysozoa)
		 	-- клада Nematoida
		 	-- клада Scalidophora
		 	-- клада Panarthropoda
		-- Спиральные (Spiralia)
			-- надтип Gnathifera
			-- клада Lophotrochozoa
	-- вторичноротые(Deuterostomia Grobben[en], 1908)
		-- хордовые(Chordata Bateson, 1885)
			-- черепные(Craniata Linnaeus, 1758)
				-- позвоночных животных (Vertebrata Cuvier, 1812)
DROP TABLE IF EXISTS vertebrates;
CREATE TABLE vertebrates (
	id serial PRIMARY key,
	name_type_vertebrates varchar(100)
)COMMENT = 'Тип Хордовые Подтип Позвоночные';
					-- надкласс рыбы(Pisces Linnaeus, 1758)
						-- Actinopterygii (Костистые рыбы)
					-- Надкласс Четвероногие(Tetrapoda Broili, 1913)
						-- Земноводные (Amphibia)
						-- Птицы (Aves Linnaeus, 1758)
							-- Подкласс Neognathae — Новонёбные
						-- Млекопитающие (Mammalia)
				



-- блок грибы



-- блок растения



-- блок мультимедия



-- блок контент