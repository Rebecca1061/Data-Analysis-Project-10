--1)5 oldest users
select username,created_at from users order by created_at limit 5;

--2)User never posted a pic

select username from users a
left join
photos b
on a.id=b.user_id
where image_url is null order by 1

--3)winner of contest

select b.id as photo_id,
a.username,
count(c.user_id) as total
from users a
join
photos b
on a.id=b.user_id
join likes c
on b.id=c.photo_id
group by b.id,
a.username order by total desc 

--4)5 most used tags
select tag_name,
count(tag_id) as most_used from 
photo_tags a
join
tags b
on b.id=a.tag_id group by tag_name order by most_used desc limit 5

--5)most registerd days on insta
select days,count(username) as cnt
from
(select to_char(created_at,'Day') as days, 
username from users)a
group by days
order by cnt desc

--6)average photos posted by users
with cte as(select a.id,count(b.id)as cnt from
users a
left join
photos b
on a.id=b.user_id group by a.id )
select sum(cnt),count(id),sum(cnt)/count(id)
from cte

--7)Indentifing bots
with cte as(select username,count(photo_id) as likes  from users a
join likes b
on a.id=b.user_id group by username)
select username,likes from cte where likes in(select count(*) from photos)
order by 1

--8)Most commented photos
with cte as(select photo_id, count(user_id) as cnt 
			from comments a group by a.photo_id
            order by cnt desc)
select username,b.photo_id,cnt from photos a
join cte b
on a.id=b.photo_id
join users c
on c.id=a.user_id
order by cnt desc limit 10


--9)total followers
select follower_id,count(followee_id) as followers 
from follows group by follower_id order by 1 


