-- Create the database for CH2
CREATE TABLE films (
    id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INT,
    country VARCHAR(255),
    duration INT,
    language VARCHAR(255),
    certification VARCHAR(255),
    gross INT,
    budget INT
);

CREATE TABLE people (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    birthdate DATE,
    deathdate DATE
);

CREATE TABLE reviews (
    id INT PRIMARY KEY,
    film_id INT,
    num_user INT,
    num_critic INT,
    imdb_score FLOAT,
    num_votes INT,
    facebook_likes INT,
    FOREIGN KEY (film_id) REFERENCES films(id)
);

CREATE TABLE roles (
    id INT PRIMARY KEY,
    film_id INT,
    person_id INT,
    role VARCHAR(255),
    FOREIGN KEY (film_id) REFERENCES films(id),
    FOREIGN KEY (person_id) REFERENCES people(id)
);

/* Insert data */
-- `films` 
INSERT INTO films (id, title, release_year, country, duration, language, certification, gross, budget) VALUES
(4, 'Fight Club', 1999, 'USA', 139, 'English', 'R', 100853753, 63000000),
(5, 'Forrest Gump', 1994, 'USA', 142, 'English', 'PG-13', 677387161, 55000000),
(6, 'The Matrix', 1999, 'USA', 136, 'English', 'R', 465343360, 63000000),
(7, 'The Shawshank Redemption', 1994, 'USA', 142, 'English', 'R', 28341469, 25000000);

-- `people`
INSERT INTO people (id, name, birthdate, deathdate) VALUES
(6, 'Brad Pitt', '1963-12-18', NULL),
(7, 'Edward Norton', '1969-08-18', NULL),
(8, 'Tom Hanks', '1956-07-09', NULL),
(9, 'Keanu Reeves', '1964-09-02', NULL);

-- `reviews` 
INSERT INTO reviews (id, film_id, num_user, num_critic, imdb_score, num_votes, facebook_likes) VALUES
(4, 4, 1300, 180, 8.8, 2100000, 131000),
(5, 5, 2000, 210, 8.8, 1900000, 150000),
(6, 6, 2200, 230, 8.7, 2200000, 160000),
(7, 7, 2500, 260, 9.3, 2700000, 180000);

-- `roles` 
INSERT INTO roles (id, film_id, person_id, role) VALUES
(5, 4, 6, 'Tyler Durden'),
(6, 4, 7, 'The Narrator'),
(7, 5, 8, 'Forrest Gump'),
(8, 6, 9, 'Neo'),
(9, 7, 7, 'Ellis Boyd Redding'),
(10, 7, 8, 'Paul Edgecomb');

-- `films` 
INSERT INTO films (id, title, release_year, country, duration, language, certification, gross, budget) VALUES
(8, 'The Dark Knight', 2008, 'USA', 152, 'English', 'PG-13', 1005000000, 185000000),
(9, 'Interstellar', 2014, 'USA', 169, 'English', 'PG-13', 677500000, 165000000),
(10, 'Joker', 2019, 'USA', 122, 'English', 'R', 1074000000, 55000000);

-- `people`
INSERT INTO people (id, name, birthdate, deathdate) VALUES
(10, 'Christian Bale', '1974-01-30', NULL),
(11, 'Heath Ledger', '1979-04-04', '2008-01-22'),
(12, 'Matthew McConaughey', '1969-11-04', NULL),
(13, 'Joaquin Phoenix', '1974-10-28', NULL);

-- `reviews` 
INSERT INTO reviews (id, film_id, num_user, num_critic, imdb_score, num_votes, facebook_likes) VALUES
(8, 8, 3000, 350, 9.0, 2600000, 200000),
(9, 9, 2800, 300, 8.6, 1800000, 140000),
(10, 10, 4500, 400, 8.4, 1900000, 250000);

-- `roles` 
INSERT INTO roles (id, film_id, person_id, role) VALUES
(11, 8, 10, 'Batman'),
(12, 8, 11, 'Joker'),
(13, 9, 12, 'Cooper'),
(14, 10, 13, 'Arthur Fleck');

-- Different languages
INSERT INTO films (id, title, release_year, country, duration, language, certification, gross, budget) VALUES
(12, 'Pan''s Labyrinth', 2006, 'Spain', 118, 'Spanish', 'R', 83258226, 19000000),
(13, 'Parasite', 2019, 'South Korea', 132, 'Korean', 'R', 263629471, 11000000),
(14, 'Spirited Away', 2001, 'Japan', 125, 'Japanese', 'PG', 395856424, 15000000),
(15, 'Life Is Beautiful', 1997, 'Italy', 116, 'Italian', 'PG-13', 230098799, 20000000);


-- `films` 
INSERT INTO films (id, title, release_year, country, duration, language, certification, gross, budget) VALUES
(16, 'Gladiator', 2000, 'USA', 155, 'English', 'R', 460583960, 103000000),
(17, 'The Lord of the Rings', 2001, 'New Zealand', 178, 'English', 'PG-13', 871530324, 93000000),
(18, 'The Lion King', 1994, 'USA', 88, 'English', 'G', 968500000, 45000000),
(19, 'The Pianist', 2002, 'Poland', 150, 'English', 'R', 12000000, 35000000),
(20, 'The Notebook', 2004, 'USA', 123, 'English', 'PG-13', 115600000, 29000000),
(21, 'The Matrix Reloaded', 2003, 'USA', 138, 'English', 'R', 739300000, 150000000);

-- `people` 
INSERT INTO people (id, name, birthdate, deathdate) VALUES
(14, 'Russell Crowe', '1964-04-07', NULL),
(15, 'Elijah Wood', '1981-01-28', NULL),
(16, 'Roman Polanski', '1933-08-18', NULL);

-- `reviews` 
INSERT INTO reviews (id, film_id, num_user, num_critic, imdb_score, num_votes, facebook_likes) VALUES
(11, 16, 1800, 250, 8.5, 1200000, 130000),
(12, 17, 2500, 300, 8.8, 1900000, 180000),
(13, 18, 1500, 200, 8.5, 1100000, 150000),
(14, 19, 1200, 150, 8.5, 900000, 80000),
(15, 20, 1100, 140, 7.8, 800000, 90000),
(16, 21, 1900, 220, 7.2, 1600000, 170000);

-- `roles`
INSERT INTO roles (id, film_id, person_id, role) VALUES
(15, 16, 14, 'Maximus Decimus Meridius'),
(16, 17, 15, 'Frodo Baggins'),
(17, 19, 16, 'Director');



