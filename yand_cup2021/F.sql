 ;with Cte As 
(
SELECT tg.track_id as track_id 
, g.id as genre_id
, t.name as track_name
, 
g.name as genre_name 
FROM track_genre tg 
join track t on tg.track_id = t.id 
join genre g on tg.genre_id = g.id 
where g.parent_genre_id is null 
UNION all 
SELECT tg.track_id as track_id 
, g.id as genre_id
, t.name as track_name
, 
g.name as genre_name 
from track_genre tg 
join genre as g on tg.genre_id = g.id 
left join genre as g2 on g2.parent_genre_id = g.id 
join track t on tg.track_id = t.id 
UNION all 
SELECT tg.track_id as track_id 
, g2.id as genre_id
, t.name as track_name
, 
g2.name as genre_name 
from track_genre tg 
join genre as g on tg.genre_id = g.id 
join genre as g2 on g2.id = g.parent_genre_id 
join track t on tg.track_id = t.id 
UNION all 
SELECT tg.track_id as track_id 
, g3.id as genre_id
, t.name as track_name
, 
g3.name as genre_name 
from track_genre tg 
join genre as g on tg.genre_id = g.id 
join genre as g2 on g2.id = g.parent_genre_id 
join genre as g3 on g2.parent_genre_id = g3.id 
join track t on tg.track_id = t.id 
) 
select track_id
,genre_id
,track_name
,genre_name FROM Cte 
group by genre_id
,genre_name
,track_id
,track_name 
order by track_id, genre_id