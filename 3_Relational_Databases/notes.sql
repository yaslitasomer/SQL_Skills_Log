SELECT table_schema, table_name
FROM information_schema.tables;

SELECT table_schema, column_name, data_type
FROM information_schema.columns
WHERE table_name = 'pg_config';

SELECT * FROM university_professors LIMIT 3;  -- redundancy

/* Creating Tables to Achieve New Entity-Relationship Schema */

-- Create a table for the professors entity type
CREATE TABLE professors (
 firstname TEXT,
 lastname TEXT
);
-- Print the contents of this table
SELECT * 
FROM professors;

-- Create a table for the universities entity type
CREATE TABLE universities(
    university_shortname TEXT,
    university TEXT,
    university_city TEXT
);
-- Print the contents of this table
SELECT * 
FROM universities;

-- Add the university_shortname column
ALTER TABLE professors
ADD COLUMN university_shortname TEXT;

-- Print the contents of this table
SELECT * 
FROM professors;


-- Create a table for the organizations entity type
CREATE TABLE organizations(
    organization_sector TEXT,
    organization TEXT
);
-- Print the contents of this table
SELECT * 
FROM organizations;

-- Create a table for the affiliations entity type
CREATE TABLE affiliations(
    firstname TEXT,
    lastname TEXT,
    university_shortname TEXT,
    function TEXT,
    organization TEXT
);
-- Print the contents of this table
SELECT * 
FROM affiliations;


/* MIGRATE DATA */

-- Only store distinct data in new tables
SELECT COUNT(*) FROM university_professors;
SELECT COUNT(DISTINCT organization) FROM university_professors;

-- Insert into new tables
INSERT INTO organizations
SELECT DISTINCT organization_sector, organization
FROM university_professors;

-- Check insertion
SELECT * FROM organizations;


SELECT DISTINCT firstname, lastname, university_shortname FROM university_professors;
SELECT DISTINCT firstname, lastname FROM university_professors;
-- RESULT: We don't need university_shortname in affiliations table, since firstname and lastname uniquely identifies a professor

-- Drop a column
ALTER TABLE affiliations
DROP COLUMN university_shortname;

-- Insert unique professors into the new table
INSERT INTO professors 
SELECT DISTINCT firstname, lastname, university_shortname 
FROM university_professors;

-- Doublecheck the contents of professors
SELECT * 
FROM professors;

-- Insert unique affiliations into the new table
INSERT INTO affiliations 
SELECT DISTINCT firstname, lastname, function, organization 
FROM university_professors;

-- Doublecheck the contents of affiliations
SELECT * 
FROM affiliations;

-- Insert unique universities into the new table
INSERT INTO universities 
SELECT DISTINCT university_shortname, university, university_city 
FROM university_professors;

-- Doublecheck the contents of affiliations
SELECT * 
FROM universities;


-- Delete the university_professors table
DROP TABLE university_professors;



/* ATTRIBUTE CONSTRAINTS */

SELECT DISTINCT university_shortname FROM universities;

-- Specify the correct fixed-length character type
ALTER TABLE professors
ALTER COLUMN university_shortname
TYPE char(3);

-- Check
SELECT
  column_name,
  data_type,
  character_maximum_length,
  is_nullable
FROM
  information_schema.columns
WHERE
  table_name = 'professors';

-- Change the type of firstname
ALTER TABLE professors
ALTER COLUMN firstname
TYPE varchar(64);

-- Convert the values in firstname to a max. of 16 characters
ALTER TABLE professors 
ALTER COLUMN firstname 
TYPE varchar(16)
USING SUBSTRING(firstname FROM 1 FOR 16);

--Check
SELECT * FROM professors;


-- not-null and unique constraints

-- Disallow NULL values in firstname
ALTER TABLE professors 
ALTER COLUMN firstname SET NOT NULL;

-- Disallow NULL values in lastname
ALTER TABLE professors 
ALTER COLUMN lastname SET NOT NULL;

-- Make universities.university_shortname unique
ALTER TABLE universities
ADD CONSTRAINT university_shortname_unq UNIQUE(university_shortname);

-- Make organizations.organization unique
ALTER TABLE organizations
ADD CONSTRAINT organization_unq UNIQUE(organization);

-- Check
SELECT
    constraint_name,
    table_name
FROM
    information_schema.table_constraints
WHERE
    constraint_type = 'UNIQUE' AND table_name = 'organizations';


/* KEYS AND SUPERKEYS */

-- Count the number of rows in universities
SELECT COUNT(*) 
FROM universities;

-- Count the number of distinct values in the university_city column
SELECT COUNT(DISTINCT(university_city)) 
FROM universities;

-- Try out different combinations
SELECT COUNT(DISTINCT(firstname, lastname)) 
FROM professors;


-- Rename the organization column to id
ALTER TABLE organizations
RENAME COLUMN organization TO id;

-- Make id a primary key
ALTER TABLE organizations
ADD CONSTRAINT organization_pk PRIMARY KEY (id);

-- Check
SELECT
    constraint_name,
    table_name
FROM
    information_schema.table_constraints
WHERE
    constraint_type = 'PRIMARY KEY' AND table_name = 'organizations';


-- Rename the university_shortname column to id
ALTER TABLE universities
RENAME COLUMN university_shortname TO id;

-- Make id a primary key
ALTER TABLE universities
ADD CONSTRAINT university_pk PRIMARY KEY (id);


-- Surrogate Keys
-- Add the new column to the table
ALTER TABLE professors
ADD COLUMN id serial;

-- Make id a primary key
ALTER TABLE professors 
ADD CONSTRAINT professors_pkey PRIMARY KEY (id);

-- Check 
SELECT * FROM professors;


/* FOREIGN KEYS */
