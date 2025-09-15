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

-- Chaining Joins
SELECT p1.country, p1.continent, president, prime_minister, pm_start
FROM prime_ministers as p1
INNER JOIN presidents as p2
USING(country)
INNER JOIN prime_minister_terms as p3
USING(prime_minister);

-- Left join
SELECT p1.country, prime_minister, president
FROM prime_ministers AS p1
LEFT JOIN presidents AS p2
USING(country);

-- Right join
SELECT p2.country, prime_minister, president
FROM prime_ministers AS p1
RIGHT JOIN presidents AS p2
USING(country);

-- Full join
SELECT country , prime_minister, president
FROM prime_ministers AS p1
FULL JOIN presidents AS p2
USING(country);

-- Cross join
SELECT prime_minister, president
FROM prime_ministers
CROSS JOIN presidents
WHERE presidents.continent IN ('Europe');

-- Self join
SELECT p1.country as country1, p2.country as country2, p1.continent
FROM prime_ministers as p1
INNER JOIN prime_ministers as p2
ON p1.continent = p2.continent AND p1.country <> p2.country;

-- Union
SELECT monarch AS leader, country
FROM monarchs
UNION
SELECT prime_minister, country 
FROM prime_ministers
ORDER BY country, leader;

-- Intersection
SELECT country AS intersect_country
FROM prime_ministers
INTERSECT
SELECT country
from presidents;

-- Except
SELECT country 
FROM presidents
EXCEPT
SELECT country
FROM monarchs;

SELECT country
FROM monarchs
EXCEPT
SELECT country 
FROM presidents;


/* SUBQUERIES */

-- Semi Join
SELECT country, continent, president
FROM presidents;

SELECT country
FROM states
where indep_year < 1800;

SELECT president, country, continent
FROM presidents
WHERE country IN 
    ( SELECT country
      FROM states
      WHERE indep_year < 1800);

-- Anti join
SELECT president, country, continent
FROM presidents
WHERE continent LIKE '%America' 
    AND country NOT IN
      ( SELECT country
        FROM states
        WHERE indep_year < 1800);

-- Subqueries inside SELECT
SELECT DISTINCT continent
FROM presidents;

SELECT DISTINCT continent,
    (SELECT COUNT(*)
     FROM prime_ministers
     WHERE presidents.continent = prime_ministers.continent) AS prime_minister_count
FROM presidents;

-- Subqueries inside FROM
SELECT
  p.continent,
  AVG(subquery_term_counts.term_count) AS average_terms
FROM
  prime_ministers AS p,
  ( SELECT
      prime_minister,
      COUNT(pm_start) AS term_count
    FROM
      prime_minister_terms
    GROUP BY
      prime_minister
  ) AS subquery_term_counts
WHERE
  p.prime_minister = subquery_term_counts.prime_minister
GROUP BY p.continent;

