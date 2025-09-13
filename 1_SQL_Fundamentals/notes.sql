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

-- Limit result
SELECT age FROM students LIMIT 5;

