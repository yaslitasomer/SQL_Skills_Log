-- `states` table
CREATE TABLE states (
    country VARCHAR(255) PRIMARY KEY,
    indep_year INTEGER
);

-- `presidents` table
CREATE TABLE presidents (
    president VARCHAR(255) PRIMARY KEY,
    country VARCHAR(255) NOT NULL,
    continent VARCHAR(255),
    FOREIGN KEY (country) REFERENCES states(country)
);

-- `prime_ministers` table
CREATE TABLE prime_ministers (
    prime_minister VARCHAR(255) PRIMARY KEY,
    country VARCHAR(255) NOT NULL,
    continent VARCHAR(255),
    FOREIGN KEY (country) REFERENCES states(country)
);

-- `monarchs` table
CREATE TABLE monarchs (
    monarch VARCHAR(255) PRIMARY KEY,
    country VARCHAR(255) NOT NULL,
    continent VARCHAR(255),
    FOREIGN KEY (country) REFERENCES states(country)
);

-- `prime_minister_terms` table
CREATE TABLE prime_minister_terms (
    prime_minister VARCHAR(255),
    pm_start INTEGER,
    PRIMARY KEY (prime_minister, pm_start),
    FOREIGN KEY (prime_minister) REFERENCES prime_ministers(prime_minister)
);


-- `states`
INSERT INTO states (country, indep_year) VALUES
('USA', 1776),
('UK', 1707),
('Germany', 1949),
('France', 1792),
('Canada', 1867),
('Brazil', 1822),
('India', 1947),
('Japan', 1947),
('Russia', 1991),
('Mexico', 1821),
('South Africa', 1910),
('Australia', 1901),
('Argentina', 1816),
('Egypt', 1953),
('China', 1949),
('Spain', 1931);

-- `presidents` 
INSERT INTO presidents (president, country, continent) VALUES
('Joe Biden', 'USA', 'North America'),
('Emmanuel Macron', 'France', 'Europe'),
('Luiz Inacio Lula da Silva', 'Brazil', 'South America'),
('Andres Manuel Lopez Obrador', 'Mexico', 'North America'),
('Javier Milei', 'Argentina', 'South America'),
('Abdel Fattah el-Sisi', 'Egypt', 'Africa'),
('Vladimir Putin', 'Russia', 'Europe/Asia'),
('Xi Jinping', 'China', 'Asia');

-- `prime_ministers` 
INSERT INTO prime_ministers (prime_minister, country, continent) VALUES
('Rishi Sunak', 'UK', 'Europe'),
('Olaf Scholz', 'Germany', 'Europe'),
('Justin Trudeau', 'Canada', 'North America'),
('Narendra Modi', 'India', 'Asia'),
('Fumio Kishida', 'Japan', 'Asia'),
('Anthony Albanese', 'Australia', 'Australia'),
('Pedro Sanchez', 'Spain', 'Europe');

-- `monarchs` 
INSERT INTO monarchs (monarch, country, continent) VALUES
('King Charles III', 'UK', 'Europe'),
('King Felipe VI', 'Spain', 'Europe');

-- `prime_minister_terms` 
INSERT INTO prime_minister_terms (prime_minister, pm_start) VALUES
('Rishi Sunak', 2022),
('Olaf Scholz', 2021),
('Justin Trudeau', 2015),
('Justin Trudeau', 2019),
('Narendra Modi', 2014),
('Narendra Modi', 2019),
('Fumio Kishida', 2021),
('Anthony Albanese', 2022),
('Rishi Sunak', 2024),
('Olaf Scholz', 2024), 
('Pedro Sanchez', 2018),
('Pedro Sanchez', 2023);

-- 
INSERT INTO presidents (president, country, continent) VALUES
('Frank-Walter Steinmeier', 'Germany', 'Europe');

--
INSERT INTO prime_ministers (prime_minister, country, continent) VALUES
('Gabriel Attal', 'France', 'Europe');