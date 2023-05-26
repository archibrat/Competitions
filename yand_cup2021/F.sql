;
WITH Cte AS
(
	SELECT  tg.track_id AS track_id
	       ,g.id        AS genre_id
	       ,t.name      AS track_name
	       ,g.name      AS genre_name
	FROM track_genre tg
	JOIN track t
	ON tg.track_id = t.id
	JOIN genre g
	ON tg.genre_id = g.id
	WHERE g.parent_genre_id is null 
	UNION ALL
	SELECT  tg.track_id AS track_id
	       ,g.id        AS genre_id
	       ,t.name      AS track_name
	       ,g.name      AS genre_name
	FROM track_genre tg
	JOIN genre AS g
	ON tg.genre_id = g.id
	LEFT JOIN genre AS g2
	ON g2.parent_genre_id = g.id
	JOIN track t
	ON tg.track_id = t.id
	UNION ALL
	SELECT  tg.track_id AS track_id
	       ,g2.id       AS genre_id
	       ,t.name      AS track_name
	       ,g2.name     AS genre_name
	FROM track_genre tg
	JOIN genre AS g
	ON tg.genre_id = g.id
	JOIN genre AS g2
	ON g2.id = g.parent_genre_id
	JOIN track t
	ON tg.track_id = t.id
	UNION ALL
	SELECT  tg.track_id AS track_id
	       ,g3.id       AS genre_id
	       ,t.name      AS track_name
	       ,g3.name     AS genre_name
	FROM track_genre tg
	JOIN genre AS g
	ON tg.genre_id = g.id
	JOIN genre AS g2
	ON g2.id = g.parent_genre_id
	JOIN genre AS g3
	ON g2.parent_genre_id = g3.id
	JOIN track t
	ON tg.track_id = t.id
)
SELECT  track_id
       ,genre_id
       ,track_name
       ,genre_name
FROM Cte
GROUP BY  genre_id
         ,genre_name
         ,track_id
         ,track_name
ORDER BY track_id
         ,genre_id
