/* Walt Wells, CUNY Bridge, SQL Final Project:  08.2016*/

/* 1) Create DB */
CREATE DATABASE IF NOT EXISTS BuildingEnergy;

/* 2) Create & populate initial tables */ 
SET foreign_key_checks = 0;
DROP TABLE IF EXISTS BuildingEnergy.EnergyCategories;
DROP TABLE IF EXISTS BuildingEnergy.EnergyTypes;
DROP TABLE IF EXISTS BuildingEnergy.Buildings;
DROP TABLE IF EXISTS BuildingEnergy.BuildingEType;
SET foreign_key_checks = 1;

CREATE TABLE BuildingEnergy.EnergyCategories
(
  cat_id int PRIMARY KEY,
  cat_name varchar(200) NOT NULL UNIQUE
);

CREATE TABLE BuildingEnergy.EnergyTypes
(
  type_id int PRIMARY KEY,
  type_name varchar(200) NOT NULL UNIQUE,
  cat_id int NULL, 
	FOREIGN KEY (cat_id) REFERENCES BuildingEnergy.EnergyCategories(cat_id)
    ON DELETE SET NULL
);

INSERT INTO BuildingEnergy.EnergyCategories (cat_id, cat_name) 
	VALUES ( 1, 'Fossil');
INSERT INTO BuildingEnergy.EnergyCategories (cat_id, cat_name) 
	VALUES ( 2, 'Renewable');

INSERT INTO BuildingEnergy.EnergyTypes (type_id, type_name, cat_id) 
	VALUES ( 1, 'Electricity', 1);
INSERT INTO BuildingEnergy.EnergyTypes (type_id, type_name, cat_id) 
    VALUES ( 2, 'Gas', 1);
INSERT INTO BuildingEnergy.EnergyTypes (type_id, type_name, cat_id) 
	VALUES ( 3, 'Steam', 1);
INSERT INTO BuildingEnergy.EnergyTypes (type_id, type_name, cat_id) 
	VALUES ( 4, 'Fuel Oil', 1);
INSERT INTO BuildingEnergy.EnergyTypes (type_id, type_name, cat_id) 
	VALUES ( 5, 'Solar', 2);
INSERT INTO BuildingEnergy.EnergyTypes (type_id, type_name, cat_id) 
	VALUES ( 6, 'Wind', 2);
    
/* 3) Join categories and energy types - do as a view for greater reuseability */
DROP VIEW IF EXISTS BuildingEnergy.energyjoin;

CREATE VIEW BuildingEnergy.energyjoin AS
SELECT c.cat_name, t.type_name FROM BuildingEnergy.EnergyCategories c
	LEFT JOIN BuildingEnergy.EnergyTypes t
    ON t.cat_id = c.cat_id
    ORDER BY t.type_name;

SELECT * FROM BuildingEnergy.energyjoin;
    
/* 4)  Add Building table and Building/Energy link table */
CREATE TABLE BuildingEnergy.Buildings
(
  build_id int PRIMARY KEY,
  build_name varchar(200) NOT NULL UNIQUE
);

CREATE TABLE BuildingEnergy.BuildingEType
(
  build_id int NOT NULL, 
	FOREIGN KEY (build_id) REFERENCES BuildingEnergy.Buildings(build_id),
  type_id int NOT NULL,
    FOREIGN KEY (type_id) REFERENCES BuildingEnergy.EnergyTypes(type_id),
  CONSTRAINT pk_BuildingEType PRIMARY KEY(build_id, type_id)
 );
 
INSERT INTO BuildingEnergy.Buildings (build_id, build_name)
	VALUES (1, 'Empire State Building');
INSERT INTO BuildingEnergy.Buildings (build_id, build_name)
	VALUES (2, 'Chrysler Building');
INSERT INTO BuildingEnergy.Buildings (build_id, build_name)
	VALUES (3, 'Borough of Manhattan Community College');

INSERT INTO BuildingEnergy.BuildingEType (build_id, type_id)
	VALUES (1, 1);
INSERT INTO BuildingEnergy.BuildingEType (build_id, type_id)
	VALUES (1, 2);
INSERT INTO BuildingEnergy.BuildingEType (build_id, type_id)
	VALUES (1, 3);
INSERT INTO BuildingEnergy.BuildingEType (build_id, type_id)
	VALUES (2, 1);
INSERT INTO BuildingEnergy.BuildingEType (build_id, type_id)
	VALUES (2, 3);
INSERT INTO BuildingEnergy.BuildingEType (build_id, type_id)
	VALUES (3, 1);
INSERT INTO BuildingEnergy.BuildingEType (build_id, type_id)
	VALUES (3, 3);
INSERT INTO BuildingEnergy.BuildingEType (build_id, type_id)
	VALUES (3, 5);

/* 5) show building and associated energy types */
DROP VIEW IF EXISTS BuildingEnergy.buildEjoin; 

CREATE VIEW BuildingEnergy.buildEjoin AS
SELECT b.build_name, e.type_name FROM BuildingEnergy.Buildings b
	LEFT JOIN BuildingEnergy.BuildingEType be
		ON b.build_id = be.build_id
	LEFT JOIN BuildingEnergy.EnergyTypes e
		ON be.type_id = e.type_id;
        
SELECT * FROM BuildingEnergy.buildEjoin;
        
/* 6) add new information */
INSERT INTO BuildingEnergy.EnergyTypes (type_id, type_name, cat_id) 
	VALUES ( 7, 'Geothermal', 2);
    
SELECT * FROM BuildingEnergy.energyjoin;

INSERT INTO BuildingEnergy.Buildings (build_id, build_name)
	VALUES (4, 'Bronx Lion House');
INSERT INTO BuildingEnergy.Buildings (build_id, build_name)
	VALUES (5, 'Brooklyn Childrens Museum');
    
INSERT INTO BuildingEnergy.BuildingEType (build_id, type_id)
	VALUES (4, 7);
INSERT INTO BuildingEnergy.BuildingEType (build_id, type_id)
	VALUES (5, 7);
INSERT INTO BuildingEnergy.BuildingEType (build_id, type_id)
	VALUES (5, 1);
    
SELECT * FROM BuildingEnergy.buildEjoin;

/* 7) Create a query that shows only buildings that use renewable energy */
DROP VIEW IF EXISTS BuildingEnergy.joinall; 

CREATE VIEW BuildingEnergy.joinall AS
SELECT b.build_name, e.type_name, r.cat_name FROM BuildingEnergy.Buildings b
	LEFT JOIN BuildingEnergy.BuildingEType be
		ON b.build_id = be.build_id
	LEFT JOIN BuildingEnergy.EnergyTypes e
		ON be.type_id = e.type_id
	LEFT JOIN BuildingEnergy.EnergyCategories r
		ON e.cat_id = r.cat_id;

SELECT * FROM BuildingEnergy.joinall 
    WHERE cat_name = 'Renewable';
    
/* 8) Create a query that shows the frequency of energy use types */
SELECT type_name, COUNT(type_name) FROM BuildingEnergy.joinall
	GROUP BY type_name ORDER BY COUNT(type_name) DESC;
    
/* 9) a - Foreign Key Restraints created in initial tables
	  b - Entity relationship chart created using workbench reverse engineer EER*/