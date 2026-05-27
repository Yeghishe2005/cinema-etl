-- Problem 1: Top 3 Favorite Genres per Age Group
SELECT age_group, favorite_genre, count
FROM (
    SELECT 
        CASE 
            WHEN age BETWEEN 18 AND 25 THEN '18-25' 
            WHEN age BETWEEN 26 AND 40 THEN '26-40' 
            ELSE '40+' 
        END AS age_group, 
        favorite_genre, 
        COUNT(*) as count,
        ROW_NUMBER() OVER(PARTITION BY (CASE WHEN age BETWEEN 18 AND 25 THEN '18-25' WHEN age BETWEEN 26 AND 40 THEN '26-40' ELSE '40+' END) ORDER BY COUNT(*) DESC) as rank
    FROM netflix_users 
    GROUP BY age_group, favorite_genre
) 
WHERE rank <= 3;

-- Problem 2: Average time spent on Netflix in each country
SELECT 
    country, 
    AVG(avg_watch_time_minutes) as avg_netflix_using_time 
FROM netflix_users 
GROUP BY country;

-- Problem 3: Genre and the list of countries where it is the most popular
SELECT 
    favorite_genre, 
    GROUP_CONCAT(country, ', ') as countries_where_it_is_the_most_popular
FROM (
    SELECT country, favorite_genre, COUNT(*) as count
    FROM netflix_users
    GROUP BY country, favorite_genre
    HAVING count = (
        SELECT MAX(cnt) 
        FROM (SELECT country, favorite_genre, COUNT(*) as cnt FROM netflix_users GROUP BY country, favorite_genre) as sub 
        WHERE sub.country = netflix_users.country
    )
) 
GROUP BY favorite_genre;

-- Problem 4: Genre creating highest binge behavior
SELECT 
    favorite_genre, 
    AVG(binge_watch_sessions) as avg_binge_sessions 
FROM netflix_users 
GROUP BY favorite_genre 
ORDER BY avg_binge_sessions DESC;

-- Problem 5: Subscription type vs Average watch time
SELECT 
    subscription_type, 
    AVG(avg_watch_time_minutes) as avg_watch_time 
FROM netflix_users 
GROUP BY subscription_type;


-- --- ADDITIONAL ANALYTICAL TASKS ---

-- Analysis A: Engagement vs Churn
SELECT 
    churned, 
    AVG(avg_watch_time_minutes) as avg_watch, 
    AVG(binge_watch_sessions) as avg_binge 
FROM netflix_users 
GROUP BY churned;

-- Analysis B: Library Genres (Netflix)
SELECT 
    listed_in, 
    COUNT(*) as title_count 
FROM netflix_titles 
GROUP BY listed_in 
ORDER BY title_count DESC;

-- Analysis C: Device usage efficiency
SELECT 
    primary_device, 
    AVG(completion_rate) as avg_completion 
FROM netflix_users 
GROUP BY primary_device;

-- Recommendation for the first 100 users based on favorite genre
SELECT 
    u.user_id, 
    u.favorite_genre, 
    a.name AS recommended_anime, 
    a.rating
FROM (
    SELECT user_id, favorite_genre 
    FROM netflix_users 
    LIMIT 100
) AS u
JOIN anime a ON a.genre LIKE '%' || u.favorite_genre || '%'
GROUP BY u.user_id
ORDER BY a.rating DESC;
