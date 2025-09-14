/* JOINING DATA */
SELECT * from presidents;
SELECT * FROM prime_ministers;

-- Inner Join

-- Countries with both prime ministers and presidents
SELECT prime_ministers.country, prime_ministers.continent, president, prime_minister
FROM presidents
INNER JOIN prime_ministers
ON presidents.country = prime_ministers.country;

-- Aliasing
SELECT p2.country, p2.continent, president, prime_minister
FROM presidents AS p1
INNER JOIN prime_ministers AS p2
ON p1.country = p2.country;

-- Using()
SELECT p2.country, p2.continent, president, prime_minister
FROM presidents AS p1
INNER JOIN prime_ministers AS p2
USING(country);
