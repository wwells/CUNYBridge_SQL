CREATE DATABASE IF NOT EXISTS hw4;

DROP TABLE IF EXISTS hw4.orgchart;

CREATE TABLE hw4.orgchart
(
  person_id int PRIMARY KEY,
  person_name varchar(200) NOT NULL UNIQUE,
  job_title varchar(200), 
  supervisor_id int NULL REFERENCES orgchart.person_id
);

INSERT INTO hw4.orgchart (person_id, person_name, job_title, supervisor_id) 
	VALUES ( 1, 'Ms. Bigstuff', 'Grand Poobah', NULL);
INSERT INTO hw4.orgchart (person_id, person_name, job_title, supervisor_id) 
	VALUES ( 2, 'Mr. Brown', 'VP, Important Things', 1);
INSERT INTO hw4.orgchart (person_id, person_name, job_title, supervisor_id) 
	VALUES ( 3, 'Mr. Yellow', 'VP, Marble Counting', 1);
INSERT INTO hw4.orgchart (person_id, person_name, job_title, supervisor_id) 
	VALUES ( 4, 'Ms. Red', 'VP, Truth in Advertising', 1);
INSERT INTO hw4.orgchart (person_id, person_name, job_title, supervisor_id) 
	VALUES ( 5, 'Mr. Pink', 'Scapegoat', 2);
INSERT INTO hw4.orgchart (person_id, person_name, job_title, supervisor_id) 
	VALUES ( 6, 'Mr. Blonde', 'Scapegoat', 2);
INSERT INTO hw4.orgchart (person_id, person_name, job_title, supervisor_id) 
	VALUES ( 7, 'Mr. Orange', 'Scapegoat', 3);
INSERT INTO hw4.orgchart (person_id, person_name, job_title, supervisor_id) 
	VALUES ( 8, 'Ms. Magenta', 'Scapegoat', 3);
INSERT INTO hw4.orgchart (person_id, person_name, job_title, supervisor_id) 
	VALUES ( 9, 'Mr. Purple', 'Scapegoat', 4);
INSERT INTO hw4.orgchart (person_id, person_name, job_title, supervisor_id) 
	VALUES ( 10, 'Mr. Green', 'Poobah Administrator', 1);
    
/* Query that shows who reports to who */
SELECT o.person_name AS 'Name', o.job_title AS 'Title', g.person_name AS 'Boss' 
	FROM hw4.orgchart o
		LEFT JOIN hw4.orgchart g 
        ON o.supervisor_id = g.person_id;
