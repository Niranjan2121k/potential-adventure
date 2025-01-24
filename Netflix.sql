use netflix;
SELECT 
    COUNT(*)
FROM
    netflix_main;

--  Count the Number of Movies vs TV Shows
SELECT 
    type, COUNT(*)
FROM
    netflix_main
GROUP BY type;

-- 2. Find the Most Common Rating for Movies and TV Shows
with cte as (select type,rating,rank() over (partition by type order by count(*) desc) as rk from netflix_main group by 2) select type,rating from cte where rk= 1;

-- 3. List All Movies Released in a Specific Year (e.g., 2020)
SELECT 
    *
FROM
    netflix
WHERE
    release_year = 2020;
    
-- 6. Find Content Added in the Last 5 Years
SELECT 
    *
FROM
    netflix
WHERE
    release_year > (SELECT max(release_year)-1 from netflix);
    
    
-- 7. Find All Movies/TV Shows by Director 'Rajiv Chilaka'
select * from netflix where director like "Rajiv Chilaka";

-- 8. List All TV Shows with More Than 5 Seasons
SELECT 
    *
FROM
    netflix
WHERE
    type = 'TV Show'
        AND SUBSTRING_INDEX(duration, ' ', 1) > 5;
        
-- 10.Find each year and the numbers of content release in India on netflix.
SELECT 
    release_year, COUNT(*)
FROM
    netflix
WHERE
    country = 'India'
GROUP BY release_year
ORDER BY 2 DESC;

-- 11. List All Movies that are Documentaries
SELECT 
    *
FROM
    netflix
WHERE
    listed_in LIKE '%Documentaries%';
    
-- 12. Find All Content Without a Director
SELECT 
    *
FROM
    netflix
WHERE
    director = ' ';

-- 13. Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years
SELECT 
    COUNT(*)
FROM
    netflix
WHERE
    cast LIKE '%Salman Khan%'
        AND release_Year > (SELECT 
            MAX(release_year) - 10
        FROM
            netflix);

-- 5. Categorize Content Based on the Presence of 'Kill' and 'Violence' Keywords
select count(*),case when description like "%kill" or description like "%Violence%" then "Bad" else "Good" end as Category from netflix group by 2;

SELECT 
    COUNT(*)
FROM
    netflix
WHERE
    cast LIKE '%Salman Khan%'
        AND release_Year > (select max(release_year) from netflix);