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
CREATE TABLE dim_author (
    author varchar(256)  NOT NULL
);

-- Insert distinct authors 
INSERT INTO dim_author
SELECT distinct author FROM dim_book_star;

-- Add a primary key 
ALTER TABLE dim_author ADD COLUMN author_id SERIAL PRIMARY KEY;

-- Output the new table
SELECT * FROM dim_author;



