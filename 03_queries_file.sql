--количество исполнителей в каждом жанре
select genre_name, count(*) from genre g 
join genreartist gar on g.id = gar.genre_id 
group by genre_name;


--количество треков, вошедших в альбомы 2019-2020 годов
select count(track_name) from track t
join album a on t.id_album = a.id
where year_of_issue between '2019-01-01' and '2021-12-31';


-- средняя продолжительность треков по каждому альбому 
select album_name, AVG(duration) from track t
join album a on t.id_album = a.id
group by album_name;


--все исполнители, которые не выпустили альбомы в 2020 году
select nickname from album_artist aa join album a on aa.id_album = a.id
join artist a2 on a2.id = aa.id_artist
where nickname not in (select nickname from album_artist aa join album a on aa.id_album = a.id
join artist a2 on a2.id = aa.id_artist
where extract(year from year_of_issue) = 2020);



--названия сборников, в которых присутствует конкретный исполнитель (выберите сами)
select collection_name, a2.nickname from track_collection tc join collection c ON tc.id_collection = c.id 
join track t on t.id = tc.id_track
join album a on t.id_album = a.id
join album_artist aa on a.id = aa.id_album
join artist a2 on aa.id_artist = a2.id
where a2.nickname like '%%Магомаев%%';

--название альбомов, в которых присутствуют исполнители более 1 жанра
select album_name, count(*) from album_artist aa join album a on aa.id_album = a.id
join artist a2 on a2.id = aa.id_artist
join genreartist ga on ga.artist_id = a2.id
group by a.album_name 
having count(*) > 1;

--наименование треков, которые не входят в сборники
select track_name from track t 
left join track_collection tc on t.id = tc.id_track
where tc.id_collection is null;


--исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько)
select nickname from album_artist aa join artist a on aa.id_artist = a.id 
join album a2 on a2.id = aa.id_album 
join track t on t.id_album = a2.id 
where t.duration = (select min(duration) from track);


--название альбомов, содержащих наименьшее количество треков
select c.collection_name, count(track_name) from track_collection tc join track t on tc.id_track = t.id 
join collection c on c.id = tc.id_collection
group by c.collection_name 
order by count(t.track_name)
limit 1;





