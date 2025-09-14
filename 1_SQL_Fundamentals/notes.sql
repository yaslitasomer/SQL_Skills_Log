/* CH1: Introduction to SQL

*/

-- Create table
CREATE TABLE students (
    student_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    age INTEGER
);

-- Add records
INSERT INTO students (name, age) VALUES ('Alice', 25);
INSERT INTO students (name, age) VALUES ('Bob', 22);
INSERT INTO students (name, age) VALUES ('Joe', 25);
INSERT INTO students (name, age) VALUES ('Kat', 20);
INSERT INTO students (name, age) VALUES ('Billie', 23);
INSERT INTO students (name, age) VALUES ('John', 24);
INSERT INTO students (name, age) VALUES ('Rick', 25);
INSERT INTO students (name, age) VALUES ('Boris', 22);
INSERT INTO students (name, age) VALUES ('Joe', 22);

-- View
SELECT * FROM students;

-- Select distinct age values
SELECT DISTINCT age as unique_age FROM students;

-- View to refer later
CREATE VIEW ages AS SELECT DISTINCT age FROM students;

SELECT * FROM ages;

DROP VIEW ages;
DROP table students;

-- Limit result
SELECT age FROM students LIMIT 5;


/* Intermediate SQL 
*/

-- Count()
SELECT COUNT(birthdate) AS count_birthdates FROM people;

SELECT COUNT(name) AS count_names, COUNT(birthdate) AS count_birthdates FROM people;

SELECT COUNT(*) AS total_records FROM people;

-- Distinct
SELECT language FROM films;

SELECT DISTINCT language FROM films;

-- Count() with Distinct
SELECT COUNT(DISTINCT language) as count_distinct_languages from films;

-- Filtering Records

-- Where
SELECT title 
FROM films
WHERE release_year < 2000;

-- Filtering text
SELECT *
FROM films
WHERE title LIKE 'The%';

SELECT *
FROM roles
WHERE role LIKE 'Joke_';

SELECT *
FROM films
WHERE title NOT LIKE 'The%';

SELECT title, language
FROM films
WHERE language IN ('Spanish', 'Korean');

-- Null Values
SELECT name 
FROM people
WHERE deathdate is NULL;

SELECT name 
FROM people
WHERE deathdate is NOT NULL;

SELECT COUNT(*) as no_deathdate
FROM people
WHERE deathdate is NULL;


/* AGGREGATE FUNCTIONS */

SELECT AVG(budget) FROM films;
SELECT SUM(budget) FROM films;
SELECT MIN(budget) FROM films;
SELECT MAX(budget) FROM films;

-- Round()
SELECT AVG(budget) as avg_budget
FROM films
WHERE release_year < 2000;

SELECT ROUND(AVG(budget), 2) as avg_budget
FROM films
WHERE release_year < 2000;

SELECT ROUND(AVG(budget)) as avg_budget
FROM films
WHERE release_year < 2000;


-- Aliasing and arithmetic
SELECT (gross - budget) AS profit FROM films;


/* ORDERING AND GROUPING */

-- Sorting results
SELECT title, budget
FROM films
ORDER BY budget;

SELECT title, budget
FROM films
ORDER BY budget DESC;

SELECT title, release_year, budget
FROM films
ORDER BY release_year, budget;

-- Grouping data
SELECT certification, COUNT(title) AS title_count
FROM films
GROUP BY certification;

SELECT certification, language, COUNT(title) AS title_count
FROM films
GROUP BY certification, language;

SELECT certification, COUNT(title) AS title_count
FROM films
GROUP BY certification
ORDER BY title_count DESC;

-- Filtering grouped data
SELECT release_year, COUNT(title) AS title_count
FROM films
GROUP BY release_year
HAVING COUNT(title) > 2; 

