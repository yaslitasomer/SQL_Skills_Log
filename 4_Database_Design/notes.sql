/* DIMENSIONAL MODEL */

SELECT * FROM runs;

CREATE TABLE route_dim (
    route_id SERIAL PRIMARY KEY,
    park_name VARCHAR(50) NOT NULL,
    city_name VARCHAR(50) NOT NULL,
    distance_km FLOAT NOT NULL,
    route_name VARCHAR(50) NOT NULL
);

CREATE TABLE week_dim (
    week_id SERIAL PRIMARY KEY,
    week INT NOT NULL,
    month VARCHAR(20) NOT NULL,
    year INT NOT NULL
);

CREATE TABLE runs_fact (
    run_id SERIAL PRIMARY KEY,
    route_id INT,
    week_id INT,
    duration_mins FLOAT,
    FOREIGN KEY (route_id) REFERENCES route_dim(route_id),
    FOREIGN KEY (week_id) REFERENCES week_dim(week_id)
);

-- Insert data
INSERT INTO route_dim (park_name, city_name, distance_km, route_name)
SELECT DISTINCT park_name, city_name, distance_km, route_name
FROM runs;

INSERT INTO week_dim (week, month, year)
SELECT DISTINCT week, month, year
FROM runs;

INSERT INTO runs_fact (route_id, week_id, duration_mins)
SELECT
    rd.route_id,
    wd.week_id,
    r.duration_mins
FROM
    runs AS r
JOIN
    route_dim AS rd ON r.park_name = rd.park_name
        AND r.city_name = rd.city_name
        AND r.distance_km = rd.distance_km
        AND r.route_name = rd.route_name
JOIN
    week_dim AS wd ON r.week = wd.week
        AND r.month = wd.month
        AND r.year = wd.year;

DROP TABLE runs;

SELECT SUM(duration_mins) FROM runs_fact;

-- From July 2019
SELECT SUM(duration_mins) as sum_durations_july_2019
FROM runs_fact
INNER JOIN week_dim ON runs_fact.week_id = week_dim.week_id
WHERE week_dim.month = 'July' AND  week_dim.year = 2019;

DROP TABLE runs_fact;
DROP TABLE week_dim;
DROP TABLE route_dim;

/* SNOWFLAKE DIMENSIONAL MODEL APPROACH */

-- Add the book_id foreign key
ALTER TABLE fact_booksales ADD CONSTRAINT sales_book
    FOREIGN KEY (book_id) REFERENCES dim_book_star (book_id);
    
-- Add the time_id foreign key
ALTER TABLE fact_booksales ADD CONSTRAINT sales_time
    FOREIGN KEY (time_id) REFERENCES dim_time_star (time_id);
    
-- Add the store_id foreign key
ALTER TABLE fact_booksales ADD CONSTRAINT sales_store
    FOREIGN KEY (store_id) REFERENCES dim_store_star (store_id);


-- Extending the Book Dimension

-- Create dim_author with an author column
CREATE TABLE dim_author_sf (
    author varchar(256)  NOT NULL
);

-- Insert distinct authors 
INSERT INTO dim_author_sf
SELECT distinct author FROM dim_book_star;

-- Add a primary key 
ALTER TABLE dim_author_sf ADD COLUMN author_id SERIAL PRIMARY KEY;

-- Output the new table
SELECT * FROM dim_author_sf;

-- Check
SELECT COUNT(*) FROM dim_author_sf;
SELECT COUNT(DISTINCT author) FROM dim_book_star;

SELECT
    author,
    COUNT(*) AS record_count
FROM
    dim_author_sf
GROUP BY
    author
HAVING
    COUNT(*) > 1;


-- Create dim_publisher with a publisher column
CREATE TABLE dim_publisher_sf (
    publisher varchar(256)  NOT NULL
);

-- Insert distinct publishers 
INSERT INTO dim_publisher_sf
SELECT distinct publisher FROM dim_book_star;

-- Add a primary key 
ALTER TABLE dim_publisher_sf ADD COLUMN publisher_id SERIAL PRIMARY KEY;

-- Output the new table
SELECT * FROM dim_publisher_sf;

-- Check
SELECT COUNT(*) FROM dim_publisher_sf;
SELECT COUNT(DISTINCT publisher) FROM dim_book_star;

SELECT
    publisher,
    COUNT(*) AS record_count
FROM
    dim_publisher_sf
GROUP BY
    publisher
HAVING
    COUNT(*) > 1;


-- Create dim_genre with a publisher column
CREATE TABLE dim_genre_sf (
    genre varchar(128)  NOT NULL
);

-- Insert distinct publishers 
INSERT INTO dim_genre_sf
SELECT distinct genre FROM dim_book_star;

-- Add a primary key 
ALTER TABLE dim_genre_sf ADD COLUMN genre_id SERIAL PRIMARY KEY;

-- Output the new table
SELECT * FROM dim_genre_sf;

-- Check
SELECT COUNT(*) FROM dim_genre_sf;
SELECT COUNT(DISTINCT genre) FROM dim_book_star;

SELECT
    genre,
    COUNT(*) AS record_count
FROM
    dim_genre_sf
GROUP BY
    genre
HAVING
    COUNT(*) > 1;


-- Step 1: Create the new dim_book_sf table
CREATE TABLE dim_book_sf (
    book_id INT PRIMARY KEY,
    title VARCHAR(256),
    author_id INT,
    publisher_id INT,
    genre_id INT
);

-- Step 2: Populate the new table by joining the dimension tables
INSERT INTO dim_book_sf (book_id, title, author_id, publisher_id, genre_id)
SELECT
    b.book_id,
    b.title,
    a.author_id,
    p.publisher_id,
    g.genre_id
FROM
    dim_book_star AS b
JOIN
    dim_author_sf AS a ON b.author = a.author
JOIN
    dim_publisher_sf AS p ON b.publisher = p.publisher
JOIN
    dim_genre_sf AS g ON b.genre = g.genre;

-- Step 3: Add foreign key constraints to the new table
ALTER TABLE dim_book_sf
ADD CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES dim_author_sf (author_id);

ALTER TABLE dim_book_sf
ADD CONSTRAINT fk_publisher FOREIGN KEY (publisher_id) REFERENCES dim_publisher_sf (publisher_id);

ALTER TABLE dim_book_sf
ADD CONSTRAINT fk_genre FOREIGN KEY (genre_id) REFERENCES dim_genre_sf (genre_id);

-- Check the newly created table
SELECT * FROM dim_book_sf;
/* REMAINING DIMENSIONS ARE IMPLEMENTED IN database_setup.sql*/


/* NORMALIZED(SNOWFLAKE) AND DENORMALIZED DATABASES(STAR) */


-- Goal: get quantity of all J.R.R. Tolkien books sold in Washington in Q3 of 2017

-- DENORMALIZED
SELECT SUM(quantity) FROM fact_booksales
-- Join to get city 
INNER JOIN dim_store_star on fact_booksales.store_id = dim_store_star.store_id
-- Join to get author 
INNER JOIN dim_book_star on fact_booksales.book_id = dim_book_star.book_id
-- Join to get year and quarter
INNER JOIN dim_time_star on fact_booksales.time_id = dim_time_star.time_id
WHERE
    dim_store_star.city ='Washington' AND dim_book_star.author ='J.R.R. Tolkien' AND 
    dim_time_star.year = 2017 AND dim_time_star.quarter = 3;

-- NORMALIZED
SELECT SUM(fact_booksales.quantity) FROM  fact_booksales
-- Join to get city
INNER JOIN dim_store_sf ON fact_booksales.store_id = dim_store_sf.store_id
INNER JOIN dim_city_sf ON dim_store_sf.city_id = dim_city_sf.city_id
-- Join to get author
INNER JOIN dim_book_sf ON fact_booksales.book_id = dim_book_sf.book_id
INNER JOIN dim_author_sf ON dim_book_sf.author_id = dim_author_sf.author_id
-- Join to get year and quarter
INNER JOIN dim_time_sf ON fact_booksales.time_id = dim_time_sf.time_id
INNER JOIN dim_month_sf ON dim_time_sf.month_id = dim_month_sf.month_id
INNER JOIN dim_quarter_sf ON dim_month_sf.quarter_id =  dim_quarter_sf.quarter_id
INNER JOIN dim_year_sf ON dim_quarter_sf.year_id = dim_year_sf.year_id
WHERE  dim_city_sf.city = 'Washington' AND dim_author_sf.author = 'J.R.R. Tolkien' AND 
       dim_year_sf.year = 2017 AND dim_quarter_sf.quarter = 3; 



-- Output each state and their total sales_amount (STAR SCHEMA)
SELECT dim_store_star.state, SUM(sales_amount)
FROM fact_booksales
	-- Join to get book information
    JOIN dim_book_star ON fact_booksales.book_id = dim_book_star.book_id
	-- Join to get store information
    JOIN dim_store_star ON fact_booksales.store_id = dim_store_star.store_id
-- Get all books with in the fantasy genre
WHERE  
    dim_book_star.genre LIKE 'Fantasy'
-- Group results by state
GROUP BY
    dim_store_star.state;


-- Output each state and their total sales_amount (SNOWFLAKE SCHEMA)
SELECT dim_state_sf.state, SUM(sales_amount)
FROM fact_booksales
    -- Joins for genre
    JOIN dim_book_sf on fact_booksales.book_id = dim_book_sf.book_id
    JOIN dim_genre_sf on dim_book_sf.genre_id = dim_genre_sf.genre_id
    -- Joins for state 
    JOIN dim_store_sf on fact_booksales.store_id = dim_store_sf.store_id 
    JOIN dim_city_sf on dim_store_sf.city_id = dim_city_sf.city_id
	JOIN dim_state_sf on  dim_city_sf.state_id = dim_state_sf.state_id
-- Get all books with in the fantasy genre and group the results by state
WHERE  
    dim_genre_sf.genre = 'Fantasy'
GROUP BY
    dim_state_sf.state;


-- Output records that need to be updated in the star schema
SELECT * FROM dim_store_star
WHERE country != 'USA' AND country !='CA';



-- Extending the SNOWFLAKE schema

CREATE TABLE dim_continent_sf (
    continent_id SERIAL PRIMARY KEY,
    continent varchar(128)  NOT NULL
);

INSERT INTO dim_continent_sf (continent_id, continent) VALUES (1, 'North America');

-- Add a continent_id column with default value of 1
ALTER TABLE dim_country_sf
ADD continent_id int NOT NULL DEFAULT(1);

-- Add the foreign key constraint
ALTER TABLE dim_country_sf ADD CONSTRAINT country_continent
   FOREIGN KEY (continent_id) REFERENCES dim_continent_sf(continent_id);
   
-- Output updated table
SELECT * FROM dim_country_sf;



/* DATABASE VIEWS */

-- Create a view
CREATE VIEW scifi_books AS
SELECT title, author, genre
FROM dim_book_sf
JOIN dim_genre_sf ON dim_genre_sf.genre_id = dim_book_sf.genre_id
JOIN dim_author_sf ON dim_author_sf.author_id = dim_book_sf.author_id
WHERE dim_genre_sf.genre = 'Science Fiction';

-- Querying a view
SELECT * FROM scifi_books;

-- Viewing views
SELECT * FROM INFORMATION_SCHEMA.views; -- Includes system views

SELECT * FROM INFORMATION_SCHEMA.views -- EXcludes system views
WHERE table_schema = 'public';


-- Managing Views

-- Grant and revoke access
GRANT UPDATE ON fact_booksales TO PUBLIC;

REVOKE INSERT ON fact_booksales FROM PUBLIC;


SELECT CURRENT_USER;

-- New User
CREATE USER testuser WITH PASSWORD 'testt';
SET ROLE testuser;

INSERT INTO fact_booksales (sales_id, book_id, store_id, time_id, sales_amount, quantity)
VALUES (1000001, 5582, 829, 3951, 5405.4, 2340);

RESET ROLE;
