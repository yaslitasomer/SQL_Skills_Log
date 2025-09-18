CREATE TABLE runs (
    duration_mins FLOAT,
    week INT,
    month VARCHAR(20),
    year INT,
    park_name VARCHAR(50),
    city_name VARCHAR(50),
    distance_km FLOAT,
    route_name VARCHAR(50)
);

INSERT INTO runs (duration_mins, week, month, year, park_name, city_name, distance_km, route_name)
VALUES
(24.5, 3, 'May', 2019, 'Prospect Park', 'Brooklyn', 5, 'Simple Loop'),
(61, 3, 'May', 2019, 'Central Park', 'New York City', 8, 'Resevoir Loop'),
(24.5, 3, 'May', 2019, 'Central Park', 'New York City', 5, 'Lake Loop'),
(24.5, 4, 'May', 2019, 'Central Park', 'New York City', 5, 'Lake Loop'),
(48, 4, 'May', 2019, 'Prospect Park', 'Brooklyn', 10, 'Grove Run'),
(23, 4, 'May', 2019, 'Prospect Park', 'Brooklyn', 5, 'Simple Loop'),
(24.5, 1, 'June', 2019, 'Central Park', 'New York City', 5, 'Lake Loop'),
(54.9, 6, 'June', 2019, 'Pennypack Park', 'Philadelphia', 12, 'Penny Trail Extended'),
(38.4, 1, 'June', 2019, 'Central Park', 'New York City', 8, 'Resevoir Loop'),
(23.7, 5, 'June', 2019, 'Central Park', 'New York City', 5, 'Lake Loop'),
(57.6, 2, 'June', 2019, 'Pennypack Park', 'Philadelphia', 12, 'Penny Trail Extended'),
(31.8, 2, 'June', 2019, 'Pennypack Park', 'Philadelphia', 6, 'Penny Trail'),
(49, 2, 'June', 2019, 'Liberty State Park', 'Jersey City', 10, 'Water Front Run'),
(23.3, 5, 'June', 2019, 'Prospect Park', 'Brooklyn', 5, 'Simple Loop'),
(39.2, 3, 'June', 2019, 'Central Park', 'New York City', 8, 'Resevoir Loop'),
(27.4, 8, 'June', 2019, 'Pennypack Park', 'Philadelphia', 6, 'Penny Trail'),
(28.8, 3, 'June', 2019, 'Pennypack Park', 'Philadelphia', 6, 'Penny Trail'),
(47.5, 3, 'June', 2019, 'Liberty State Park', 'Jersey City', 10, 'Water Front Run'),
(24, 4, 'June', 2019, 'Central Park', 'New York City', 5, 'Lake Loop'),
(53, 4, 'June', 2019, 'Prospect Park', 'Brooklyn', 10, 'Grove Run'),
(24.5, 4, 'June', 2019, 'Prospect Park', 'Brooklyn', 5, 'Simple Loop'),
(37.3, 6, 'June', 2019, 'Central Park', 'New York City', 8, 'Resevoir Loop'),
(28.8, 1, 'July', 2019, 'Pennypack Park', 'Philadelphia', 6, 'Penny Trail'),
(23, 1, 'July', 2019, 'Prospect Park', 'Brooklyn', 5, 'Simple Loop'),
(49, 1, 'July', 2019, 'Liberty State Park', 'Jersey City', 10, 'Water Front Run'),
(45.8, 1, 'July', 2019, 'Liberty State Park', 'Jersey City', 10, 'Water Front Run'),
(24, 2, 'July', 2019, 'Prospect Park', 'Brooklyn', 5, 'Simple Loop'),
(47.5, 2, 'July', 2019, 'Prospect Park', 'Brooklyn', 10, 'Grove Run'),
(24, 2, 'July', 2019, 'Central Park', 'New York City', 5, 'Lake Loop'),
(53, 2, 'July', 2019, 'Liberty State Park', 'Jersey City', 10, 'Water Front Run'),
(24.5, 3, 'July', 2019, 'Central Park', 'New York City', 5, 'Lake Loop'),
(37.3, 6, 'July', 2019, 'Central Park', 'New York City', 8, 'Resevoir Loop'),
(24.5, 3, 'July', 2019, 'Prospect Park', 'Brooklyn', 5, 'Simple Loop');


/* SNOWFLAKE MODEL */
CREATE TABLE dim_book_star (
    book_id INT PRIMARY KEY,
    title VARCHAR(256),
    author VARCHAR(256),
    publisher VARCHAR(256),
    genre VARCHAR(128)
);

CREATE TABLE dim_store_star (
    store_id INT PRIMARY KEY,
    store_address VARCHAR(256),
    city VARCHAR(128),
    state VARCHAR(128),
    country VARCHAR(128)
);

CREATE TABLE dim_time_star (
    time_id INT PRIMARY KEY,
    day INT,
    month INT,
    quarter INT,
    year INT
);

CREATE TABLE fact_booksales (
    sales_id INT PRIMARY KEY,
    book_id INT,
    store_id INT,
    time_id INT,
    sales_amount FLOAT,
    quantity INT
);

-- Insert Data
INSERT INTO fact_booksales (sales_id, book_id, store_id, time_id, sales_amount, quantity)
VALUES
(88, 5582, 829, 3951, 5405.4, 2340),
(89, 5611, 804, 2445, 6177.6, 2080),
(90, 5622, 820, 2083, 2059.2, 780),
(91, 5588, 827, 2462, 2587.2, 980),
(92, 5609, 821, 2232, 5808.0, 2200),
(93, 5577, 805, 3342, 5346.0, 1800),
(94, 5584, 812, 3235, 3003.0, 1820),
(95, 5587, 816, 3677, 4118.4, 2080),
(96, 5562, 826, 2900, 198.0, 120),
(97, 5610, 827, 2295, 897.6, 340),
(98, 5575, 829, 3214, 1900.8, 960),
(99, 5571, 818, 2300, 686.4, 260),
(100, 5556, 807, 2844, 4633.2, 2340),
(101, 5593, 823, 3730, 3801.6, 1920),
(102, 5556, 798, 2775, 1709.4, 740),
(103, 5618, 801, 3838, 4158.0, 1800),
(104, 5567, 830, 3465, 3372.6, 1460),
(105, 5551, 819, 2356, 924.0, 560),
(106, 5595, 823, 2858, 3036.0, 1840),
(107, 5573, 802, 2451, 422.4, 160),
(108, 5580, 808, 3545, 3603.6, 1560),
(109, 5582, 811, 3016, 5174.4, 1960),
(110, 5606, 811, 3511, 2112.0, 800),
(111, 5550, 814, 3647, 3742.2, 1260),
(113, 5569, 829, 3914, 4296.6, 1860),
(114, 5550, 817, 3769, 2376.0, 1200),
(115, 5577, 808, 2905, 5266.8, 2280),
(116, 5626, 801, 3838, 1353.0, 820),
(117, 5610, 828, 2334, 4111.8, 1780),
(118, 5622, 815, 3545, 5280.0, 2000),
(119, 5602, 808, 3787, 3445.2, 1740),
(120, 5600, 816, 2909, 2970.0, 1800),
(121, 5593, 816, 3067, 4276.8, 1620),
(122, 5612, 823, 2913, 475.2, 160),
(123, 5568, 799, 3125, 5913.6, 2240),
(124, 5593, 810, 3457, 3379.2, 1280),
(125, 5555, 824, 2610, 554.4, 280),
(126, 5629, 806, 3523, 3729.0, 2260),
(127, 5595, 826, 3086, 6237.0, 2100),
(128, 5576, 820, 2674, 2910.6, 980);


INSERT INTO dim_book_star (book_id, title, author, publisher, genre)
VALUES
(5582, 'A Tale of Two Cities', 'Charles Dickens', 'Penguin Classics', 'Historical Fiction'),
(5611, 'The Catcher in the Rye', 'J.D. Salinger', 'Little, Brown and Company', 'Coming-of-age Fiction'),
(5622, '1984', 'George Orwell', 'Signet Classics', 'Dystopian Fiction'),
(5588, 'Moby Dick', 'Herman Melville', 'Bantam Classics', 'Adventure'),
(5609, 'Pride and Prejudice', 'Jane Austen', 'Dover Publications', 'Romance'),
(5577, 'The Hobbit', 'J.R.R. Tolkien', 'Houghton Mifflin Harcourt', 'Fantasy'),
(5584, 'Brave New World', 'Aldous Huxley', 'Harper Perennial', 'Dystopian Fiction'),
(5587, 'The Lord of the Rings', 'J.R.R. Tolkien', 'Mariner Books', 'Fantasy'),
(5562, 'Frankenstein', 'Mary Shelley', 'Penguin Classics', 'Gothic Fiction'),
(5610, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Scribner', 'Classic'),
(5575, 'To Kill a Mockingbird', 'Harper Lee', 'Grand Central Publishing', 'Southern Gothic'),
(5571, 'The Da Vinci Code', 'Dan Brown', 'Anchor', 'Mystery'),
(5556, 'Gone Girl', 'Gillian Flynn', 'Broadway Books', 'Thriller'),
(5593, 'The Hunger Games', 'Suzanne Collins', 'Scholastic Press', 'Young Adult'),
(5618, 'The Giver', 'Lois Lowry', 'Houghton Mifflin Harcourt', 'Dystopian Fiction'),
(5567, 'The Alchemist', 'Paulo Coelho', 'HarperOne', 'Fantasy'),
(5551, 'The Stand', 'Stephen King', 'Anchor', 'Horror'),
(5595, 'Dune', 'Frank Herbert', 'Ace', 'Science Fiction'),
(5573, 'The Hitchhikers Guide to the Galaxy', 'Douglas Adams', 'Del Rey', 'Science Fiction'),
(5580, 'Catch-22', 'Joseph Heller', 'Scribner', 'Satire'),
(5606, 'The Road', 'Cormac McCarthy', 'Vintage', 'Post-Apocalyptic Fiction'),
(5550, 'The Shining', 'Stephen King', 'Anchor', 'Horror'),
(5569, 'Fahrenheit 451', 'Ray Bradbury', 'Simon and Schuster', 'Dystopian Fiction'),
(5626, 'The Name of the Wind', 'Patrick Rothfuss', 'DAW Books', 'Fantasy'),
(5612, 'The Silent Patient', 'Alex Michaelides', 'Celadon Books', 'Mystery'),
(5568, 'The Secret History', 'Donna Tartt', 'Vintage', 'Dark Academia'),
(5555, 'A Game of Thrones', 'George R.R. Martin', 'Bantam Books', 'Fantasy'),
(5629, 'Sapiens', 'Yuval Noah Harari', 'Harper', 'Non-fiction'),
(5576, 'Becoming', 'Michelle Obama', 'Crown', 'Memoir'),
(5632, 'Educated', 'Tara Westover', 'Random House', 'Memoir'),
(5619, 'The Tattooist of Auschwitz', 'Heather Morris', 'St. Martins Press', 'Historical Fiction'),
(5583, 'Where the Crawdads Sing', 'Delia Owens', 'G.P. Putnams Sons', 'Mystery'),
(5557, 'Circe', 'Madeline Miller', 'Little, Brown and Company', 'Mythological Fiction'),
(5615, 'American Gods', 'Neil Gaiman', 'William Morrow', 'Fantasy'),
(5604, 'The Bell Jar', 'Sylvia Plath', 'Harper Perennial', 'Fiction'),
(5565, 'The Nightingale', 'Kristin Hannah', 'St. Martins Press', 'Historical Fiction'),
(5558, 'The Midnight Library', 'Matt Haig', 'Viking', 'Fiction'),
(5564, 'The Song of Achilles', 'Madeline Miller', 'Little, Brown and Company', 'Mythological Fiction'),
(5613, 'Eleanor Oliphant Is Completely Fine', 'Gail Honeyman', 'Penguin Books', 'Fiction'),
(5605, 'The Sun Also Rises', 'Ernest Hemingway', 'Scribner', 'Modernist Fiction'),
(5585, 'IT', 'Stephen King', 'Scribner', 'Horror'),
(5572, 'The Martian', 'Andy Weir', 'Crown', 'Science Fiction'),
(5559, 'The Goldfinch', 'Donna Tartt', 'Little, Brown and Company', 'Literary Fiction'),
(5621, 'The Glass Castle', 'Jeannette Walls', 'Scribner', 'Memoir'),
(5592, 'The Shadow of the Wind', 'Carlos Ruiz Zafón', 'Penguin Books', 'Gothic Fiction'),
(5552, 'The Color Purple', 'Alice Walker', 'Harcourt Brace Jovanovich', 'Literary Fiction'),
(5586, 'A Man Called Ove', 'Fredrik Backman', 'Washington Square Press', 'Fiction'),
(5623, 'The Vanishing Half', 'Brit Bennett', 'Riverhead Books', 'Contemporary Fiction'),
(5563, 'The Dutch House', 'Ann Patchett', 'Harper Perennial', 'Fiction');

INSERT INTO dim_book_star (book_id, title, author, publisher, genre)
VALUES
(5602, 'The Handmaid''s Tale', 'Margaret Atwood', 'Vintage Classics', 'Dystopian Fiction'),
(5600, 'The Fellowship of the Ring', 'J.R.R. Tolkien', 'Mariner Books', 'Fantasy');


-- CHECK
SELECT
    DISTINCT T1.book_id
FROM
    fact_booksales AS T1
LEFT JOIN
    dim_book_star AS T2 ON T1.book_id = T2.book_id
WHERE
    T2.book_id IS NULL;

SELECT
    title,
    author,
    COUNT(*) AS record_count
FROM
    dim_book_star
GROUP BY
    title, author
HAVING
    COUNT(*) > 1;

INSERT INTO dim_store_star (store_id, store_address, city, state, country)
VALUES
(829, '721 South Main Street', 'Los Angeles', 'CA', 'USA'),
(804, '150 West 34th Street', 'New York', 'NY', 'USA'),
(820, '401 North Michigan Avenue', 'Chicago', 'IL', 'USA'),
(827, '6000 E. State Street', 'Rockford', 'IL', 'USA'),
(821, '120 S. Main Street', 'San Francisco', 'CA', 'USA'),
(805, '901 Pennsylvania Avenue NW', 'Washington', 'DC', 'USA'),
(812, '1910 E. Colonial Dr', 'Orlando', 'FL', 'USA'),
(816, '5300 N. Main Street', 'Akron', 'OH', 'USA'),
(826, '1800 Park Place', 'Atlanta', 'GA', 'USA'),
(807, '450 North Rush Street', 'Chicago', 'IL', 'USA'),
(823, '9500 West Grand Avenue', 'Franklin Park', 'IL', 'USA'),
(798, '23 Jeanne Ave', 'Montreal', 'Quebec', 'Canada'),
(801, '580 King Street', 'Toronto', 'Ontario', 'Canada'),
(830, '1590 Mountain View Road', 'Calgary', 'Alberta', 'Canada'),
(819, '125 Rue Saint-Amable', 'Quebec City', 'Quebec', 'Canada'),
(802, '900 Broadway', 'New York', 'NY', 'USA'),
(808, '500 W. Madison Street', 'Chicago', 'IL', 'USA'),
(811, '3430 North Clark Street', 'Chicago', 'IL', 'USA'),
(814, '2800 N. Federal Hwy', 'Fort Lauderdale', 'FL', 'USA'),
(817, '3000 East 1st Avenue', 'Denver', 'CO', 'USA'),
(828, '4550 La Jolla Village Dr', 'San Diego', 'CA', 'USA'),
(815, '1000 Main Street', 'Dallas', 'TX', 'USA'),
(799, '25 West Main Street', 'Rochester', 'NY', 'USA'),
(810, '1235 East 82nd Avenue', 'Portland', 'OR', 'USA'),
(824, '400 North Congress Avenue', 'West Palm Beach', 'FL', 'USA'),
(806, '1401 Broadway', 'New York', 'NY', 'USA'),
(822, '101 North Tryon Street', 'Charlotte', 'NC', 'USA'),
(825, '3101 North Miami Avenue', 'Miami', 'FL', 'USA'),
(813, '1130 Fifth Avenue', 'Pittsburgh', 'PA', 'USA');

INSERT INTO dim_store_star (store_id, store_address, city, state, country)
VALUES
(818, '456 Elm Street', 'Boston', 'MA', 'USA');

-- CHECK
SELECT
    DISTINCT T1.store_id
FROM
    fact_booksales AS T1
LEFT JOIN
    dim_store_star AS T2 ON T1.store_id = T2.store_id
WHERE
    T2.store_id IS NULL;

SELECT
    city,
    store_address,
    COUNT(*) AS record_count
FROM
    dim_store_star
GROUP BY
    city, store_address
HAVING
    COUNT(*) > 1;


INSERT INTO dim_time_star (time_id, day, month, quarter, year)
VALUES
(3951, 10, 5, 2, 2017),
(2445, 23, 11, 4, 2017),
(2083, 5, 2, 1, 2017),
(2462, 18, 7, 3, 2017),
(2232, 2, 3, 1, 2017),
(3342, 14, 9, 3, 2017),
(3235, 28, 4, 2, 2017),
(3677, 12, 12, 4, 2017),
(2900, 15, 8, 3, 2017),
(2295, 2, 6, 2, 2017),
(3214, 21, 1, 1, 2017),
(2300, 7, 3, 1, 2017),
(2844, 22, 10, 4, 2017),
(3730, 9, 11, 4, 2017),
(2775, 1, 1, 1, 2017),
(3838, 17, 7, 3, 2017),
(3465, 30, 8, 3, 2017),
(2356, 11, 5, 2, 2017),
(2858, 26, 4, 2, 2017),
(2451, 15, 10, 4, 2017),
(3545, 3, 1, 1, 2017),
(3016, 19, 6, 2, 2017),
(3511, 4, 9, 3, 2017),
(3647, 2, 12, 4, 2017),
(3742, 16, 11, 4, 2017),
(3914, 20, 12, 4, 2017),
(3769, 1, 8, 3, 2017),
(2905, 25, 7, 3, 2017),
(2334, 18, 2, 1, 2017),
(2909, 3, 4, 2, 2017),
(3067, 11, 6, 2, 2017),
(2913, 29, 9, 3, 2017),
(3125, 14, 1, 1, 2017),
(3457, 13, 1, 1, 2017),
(2610, 10, 3, 1, 2017),
(3523, 1, 12, 4, 2017),
(3086, 24, 2, 1, 2017),
(2674, 18, 5, 2, 2017),
(2377, 27, 8, 3, 2017),
(2494, 25, 9, 3, 2017),
(2697, 10, 6, 2, 2017),
(3297, 19, 10, 4, 2017),
(2973, 15, 7, 3, 2017),
(2131, 2, 5, 2, 2017),
(2575, 6, 11, 4, 2017),
(3434, 12, 10, 4, 2017),
(2337, 29, 1, 1, 2017),
(3695, 20, 3, 1, 2017),
(2376, 2, 1, 1, 2017),
(3243, 24, 7, 3, 2017),
(2732, 11, 4, 2, 2017),
(2041, 16, 5, 2, 2017),
(2517, 2, 6, 2, 2017),
(2774, 11, 3, 1, 2017),
(3164, 27, 11, 4, 2017),
(2399, 21, 6, 2, 2017),
(3319, 10, 9, 3, 2017),
(2081, 14, 1, 1, 2017),
(2627, 19, 7, 3, 2017),
(3353, 28, 8, 3, 2017),
(3762, 18, 12, 4, 2017),
(2696, 23, 4, 2, 2017),
(2092, 1, 2, 1, 2017),
(2663, 14, 3, 1, 2017),
(3598, 2, 1, 1, 2017),
(2750, 10, 10, 4, 2017),
(2087, 8, 5, 2, 2017),
(3482, 16, 7, 3, 2017),
(3496, 25, 9, 3, 2017),
(3775, 4, 8, 3, 2017),
(3897, 12, 10, 4, 2017),
(3428, 2, 3, 1, 2017),
(3916, 28, 11, 4, 2017),
(3616, 21, 2, 1, 2017),
(3130, 5, 6, 2, 2017),
(2908, 11, 1, 1, 2017),
(2353, 28, 5, 2, 2017),
(3372, 19, 8, 3, 2017),
(3568, 6, 11, 4, 2017),
(2326, 25, 5, 2, 2017),
(2204, 27, 2, 1, 2017),
(2969, 10, 4, 2, 2017),
(2786, 22, 1, 1, 2017),
(3149, 14, 11, 4, 2017),
(3004, 17, 3, 1, 2017),
(3614, 10, 9, 3, 2017),
(2319, 1, 5, 2, 2017),
(2595, 29, 6, 2, 2017),
(3771, 11, 10, 4, 2017),
(3898, 2, 12, 4, 2017),
(3127, 18, 1, 1, 2017),
(3405, 7, 7, 3, 2017),
(2992, 26, 9, 3, 2017),
(3816, 17, 10, 4, 2017),
(3090, 18, 6, 2, 2017),
(3391, 29, 9, 3, 2017),
(3864, 14, 12, 4, 2017);

INSERT INTO dim_time_star (time_id, day, month, quarter, year)
VALUES
(3787, 10, 8, 3, 2017);

-- CHECK
SELECT
    DISTINCT T1.time_id
FROM
    fact_booksales AS T1
LEFT JOIN
    dim_time_star AS T2 ON T1.time_id = T2.time_id
WHERE
    T2.time_id IS NULL;

SELECT
    time_id,
    day,
    month,
    year,
    COUNT(*) OVER (PARTITION BY day, month, year) AS record_count
FROM
    dim_time_star
WHERE
    (day, month, year) IN (
        SELECT day, month, year
        FROM dim_time_star
        GROUP BY day, month, year
        HAVING COUNT(*) > 1
    )
ORDER BY
    year, month, day, time_id;

-- Fix
-- Adım 1: fact_booksales tablosundaki yanlış time_id'leri düzelt
UPDATE fact_booksales SET time_id = 2376 WHERE time_id = 3598;
UPDATE fact_booksales SET time_id = 2081 WHERE time_id = 3125;
UPDATE fact_booksales SET time_id = 2232 WHERE time_id = 3428;
UPDATE fact_booksales SET time_id = 2295 WHERE time_id = 2517;
UPDATE fact_booksales SET time_id = 3319 WHERE time_id = 3614;
UPDATE fact_booksales SET time_id = 2494 WHERE time_id = 3496;
UPDATE fact_booksales SET time_id = 2913 WHERE time_id = 3391;
UPDATE fact_booksales SET time_id = 3434 WHERE time_id = 3897;
UPDATE fact_booksales SET time_id = 2575 WHERE time_id = 3568;
UPDATE fact_booksales SET time_id = 3647 WHERE time_id = 3898;

-- Adım 2: dim_time_star tablosundaki yinelenen kayıtları sil
DELETE FROM dim_time_star WHERE time_id IN (
    3598, 3125, 3428, 2517, 3614, 3496, 3391, 3897, 3568, 3898
);