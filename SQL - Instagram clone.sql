                ----- SQL Mandatory Project 2----
                
/*1. Create an ER diagram or draw a schema for the given database.*/

              
/* 2. We want to reward the user who has been around the longest, Find the 5 oldest users.*/

SELECT username, id, created_at 
FROM users 
ORDER BY created_at  
LIMIT 5;

/* 3. To target inactive users in an email ad campaign, find the users who have never posted a photo.*/

SELECT id, username, created_at 
FROM users 
WHERE id NOT IN 
(SELECT DISTINCT user_id FROM photos);

/* 4. Suppose you are running a contest to find out who got the most likes on a photo. Find out who won? */
 
SELECT username, u.id, COUNT(l.photo_id) as Num_of_Likes
FROM users u
JOIN photos p ON u.id = p.user_id
JOIN likes l ON p.id = l.photo_id
GROUP BY photo_id
ORDER BY Num_of_Likes DESC limit 1;
 
  /* 5. The investors want to know how many times does the average user post.*/
  
 SELECT round(AVG(Num_of_Posts))AS Avg_Posts 
 FROM (
 SELECT user_id, count(*) AS Num_of_Posts
 FROM photos 
 GROUP BY user_id
 ) AS Post_counts;
  
 /* 6.A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags*/

 SELECT tag_name, COUNT(*) AS Most_Used_Hashtags 
 FROM photo_tags pt 
 JOIN tags t ON t.id=pt.tag_id 
 GROUP BY tag_name 
 ORDER BY Most_Used_Hashtags 
 DESC LIMIT 5 ;
 
  /*7. To find out if there are bots, find users who have liked every single photo on the site.*/
 
SELECT l.user_id FROM likes l
LEFT JOIN photos p ON l.photo_id = p.id
GROUP BY l.user_id
HAVING COUNT(DISTINCT l.photo_id) = (SELECT COUNT(*) FROM photos);

/* 8. Find the users who have created instagramid in may and select top 5 newest joinees from it?*/

 SELECT username, created_at 
FROM Users 
WHERE MONTH(created_at) = 5
ORDER BY created_at DESC 
LIMIT 5;
 
 /* 9. Can you help me find the users whose name starts with c and ends with any number and 
 have posted the photos as well as liked the photos?*/
 
 WITH CUST_NAME AS
 (SELECT username FROM users 
 WHERE username LIKE 'c%' and username REGEXP '[0-9]$' ),

CUST_PHOTOS_LIKES AS 
(SELECT u.username,p.created_at, l.photo_id 
FROM users u 
JOIN photos p ON u.id=p.user_id 
JOIN likes l ON u.id=l.user_id )

SELECT username FROM CUST_NAME WHERE username IN (SELECT username FROM CUST_PHOTOS_LIKES);

/* 10. Demonstrate the top 30 usernames to the company who have posted photos in the range of 3 to 5.*/

SELECT u.username, COUNT(p.id) AS num_photos
FROM users u
JOIN photos p ON u.id = p.user_id
GROUP BY u.id
HAVING num_photos BETWEEN 3 AND 5
ORDER BY num_photos DESC
LIMIT 30;


--




