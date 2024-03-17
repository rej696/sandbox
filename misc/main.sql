
-- Single Table Lab Sheet

CREATE TABLE pet (name VARCHAR(20), owner VARCHAR(20), species VARCHAR(20), sex CHAR(1), checkups SMALLINT UNSIGNED, birth DATE, death DATE);

. schema
. table

INSERT INTO pet (name, owner, species, sex, checkups, birth, death) VALUES 
('Fluffy','Harold','cat','f',5,'2001-02-04',NULL),
('Claws','Gwen','cat','m',2,'2000-03-17',NULL),
('Buffy','Harold','dog','f',7,'1999-05-13',NULL),
('Fang','Benny','dog','m',4,'2000-08-27',NULL),
('Bowser','Diane','dog','m',8,'1998-08-31','2001-07-29'),
('Chirpy','Gwen','bird','f',0,'2002-09-11',NULL),
('Whistler','Gwen','bird','',1,'2001-12-09',NULL),
('Slim','Benny','snake','m',5,'2001-04-29',NULL),
('Oinkall','Rowan','pig','m',2,'2001-04-27',NULL);


-- Q1
SELECT owner, name FROM pet WHERE sex = "f";
SELECT name, birth FROM pet WHERE species = "dog";
SELECT DISTINCT owner from pet where species = "bird";
SELECT DISTINCT species from pet where sex = "f";
SELECT name, birth FROM pet WHERE species = "cat" OR species = "bird";
SELECT name, species FROM pet WHERE sex = "f" AND (species = "cat" OR species = "bird");


-- Q2
SELECT owner, name FROM pet WHERE (name LIKE "%er") OR (name LIKE "%all");
SELECT name FROM pet WHERE name LIKE "%e%";
SELECT name FROM pet WHERE name NOT LIKE "%fy";
SELECT name FROM pet WHERE owner LIKE "____";
SELECT owner FROM pet WHERE owner LIKE ""; -- Q2-5 owners names begin and end with one of the first five letters of the alphabet
--  Q2-6


-- Q3
SELECT owner, AVG(checkups) FROM pet GROUP BY owner;


