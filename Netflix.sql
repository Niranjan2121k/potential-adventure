Portfolio Project: Netflix Content Analysis

Project Objective:
The objective of this project is to analyze Netflix’s dataset using SQL to extract meaningful insights into content distribution, audience preferences, 
and production trends. By understanding various aspects such as ratings, genres, release patterns, and regional content, this project aims to identify 
strategies for content enrichment and improved audience engagement. These insights can help Netflix optimize its content library and cater effectively 
to diverse audience interests.

Dataset Overview:
The Netflix dataset includes the following key attributes:
Title Information: Title, type (movie/TV show), duration (seasons or runtime), and description.
Release Details: Release year, addition year, and region of production.
Cast and Crew: Director and cast information.
Genre: Categories and themes associated with the content.
Metadata: Ratings and content classifications.

Analysis Breakdown:
1. Content Volume Analysis
Objective: Count the total number of titles available on Netflix.
Insight: Provides an overview of the platform’s content scale.

2. Content Distribution
Objective: Analyze the split between movies and TV shows.
Key Steps: Grouped data by content type and calculated percentages.
Insight: Highlights the focus areas of Netflix.

3. Common Ratings
Objective: Identify the most frequent ratings for movies and TV shows.
Key Steps: Used window functions to rank ratings by frequency within each content type.
Insight: Helps identify audience segments and content regulation patterns.

4. Yearly Trends
Objective: Examine content release patterns over time.
Specific Year Analysis: Analyzed titles released in 2020.
Recent Additions: Filtered content added in the last five years to track recent trends.
Insight: Highlights shifts in Netflix’s production and acquisition strategies.

5. Specific Focus Areas
Director Contributions: Examined titles directed by Rajiv Chilaka.
Actor Contributions: Analyzed Salman Khan’s roles in the last decade.
Genre-Based Insights: Identified documentaries and content with themes like "Kill" or "Violence."
Insight: Highlights contributions of prominent creators and thematic preferences.

6. Content Gaps
Objective: Identify content without listed directors for data enrichment opportunities.
Insight: Enhances metadata completeness and searchability.

7. Regional Analysis
Objective: Analyze the number of titles released annually in India.
Key Steps: Filtered data for Indian titles and grouped by release year.
Insight: Tracks regional production trends and audience engagement.

USE netflix;

-- 1. Count the total number of titles in Netflix's main table
SELECT 
    COUNT(*)
FROM
    netflix_main;

-- 2. Count the number of Movies vs TV Shows
SELECT 
    type, COUNT(*)
FROM
    netflix_main
GROUP BY type;

-- 3. Find the most common rating for Movies and TV Shows
WITH cte AS (
    SELECT 
        type, 
        rating, 
        RANK() OVER (PARTITION BY type ORDER BY COUNT(*) DESC) AS rk 
    FROM 
        netflix_main 
    GROUP BY type, rating
)
SELECT 
    type, 
    rating 
FROM 
    cte 
WHERE 
    rk = 1;

-- 4. List all Movies released in a specific year (e.g., 2020)
SELECT 
    *
FROM
    netflix
WHERE
    release_year = 2020;

-- 5. Find content added in the last 5 years
SELECT 
    *
FROM
    netflix
WHERE
    release_year > (SELECT MAX(release_year) - 5 FROM netflix);

-- 6. Find all Movies/TV Shows by the director 'Rajiv Chilaka'
SELECT 
    *
FROM
    netflix
WHERE
    director LIKE 'Rajiv Chilaka';

-- 7. List all TV Shows with more than 5 seasons
SELECT 
    *
FROM
    netflix
WHERE
    type = 'TV Show'
    AND SUBSTRING_INDEX(duration, ' ', 1) > 5;

-- 8. Find each year and the number of content releases in India on Netflix
SELECT 
    release_year, 
    COUNT(*)
FROM
    netflix
WHERE
    country = 'India'
GROUP BY 
    release_year
ORDER BY 
    COUNT(*) DESC;

-- 9. List all Movies that are Documentaries
SELECT 
    *
FROM
    netflix
WHERE
    listed_in LIKE '%Documentaries%';

-- 10. Find all content without a director
SELECT 
    *
FROM
    netflix
WHERE
    director = ' ';

-- 11. Find how many Movies actor 'Salman Khan' appeared in over the last 10 years
SELECT 
    COUNT(*)
FROM
    netflix
WHERE
    cast LIKE '%Salman Khan%'
    AND release_year > (SELECT MAX(release_year) - 10 FROM netflix);

-- 12. Categorize content based on the presence of 'Kill' and 'Violence' keywords
SELECT 
    COUNT(*), 
    CASE 
        WHEN description LIKE '%kill%' OR description LIKE '%Violence%' THEN 'Bad' 
        ELSE 'Good' 
    END AS Category 
FROM 
    netflix 
GROUP BY 
    Category;

-- 13. Find the count of content for actor 'Salman Khan' appearing after the latest release year
SELECT 
    COUNT(*)
FROM
    netflix
WHERE
    cast LIKE '%Salman Khan%'
    AND release_year > (SELECT MAX(release_year) FROM netflix);


Key Insights and Findings:
Content Type Distribution: Movies dominate Netflix’s catalog, with TV shows contributing a significant share.
Popular Ratings: Ratings like TV-MA and PG-13 are the most common, reflecting audience preferences.
Recent Additions: The past five years have seen an increase in diverse content offerings, emphasizing Netflix’s global reach.
Regional Focus: Indian titles show consistent growth, catering to a significant regional audience.
Director and Actor Contributions: Specific directors and actors play a pivotal role in shaping Netflix’s content library.
Content Gaps: Missing metadata, such as director information, presents opportunities for data enrichment.

Deliverables:
SQL Scripts: A comprehensive set of queries used for the analysis.
Insights Report: A detailed summary of findings and actionable recommendations.
Recommendations:
Increase focus on emerging genres and regional content to attract diverse audiences.
Enhance metadata completeness for improved searchability and discovery.
Reward creators who consistently deliver popular titles.

Potential Extensions:
Interactive Dashboards: Develop dashboards to visualize trends and performance metrics in real-time.
Predictive Analytics: Use machine learning models to forecast audience preferences and content success.
Personalized Recommendations: Build systems to suggest content based on individual viewing patterns.

Conclusion

This project showcases the depth and diversity of Netflix’s content library, providing actionable insights into audience preferences, content trends, 
and areas for improvement. By leveraging SQL to analyze the dataset, the project highlights Netflix’s strengths and opportunities for strategic growth. 
The findings can support data-driven decisions to enhance audience satisfaction and maintain Netflix’s competitive edge in the streaming industry.






