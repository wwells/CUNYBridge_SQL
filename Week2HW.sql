#RESET
DROP TABLE IF EXISTS videos;
DROP TABLE IF EXISTS reviewers;

# create vid table
CREATE TABLE videos
(
  video_id int PRIMARY KEY,
  title varchar(60) NOT NULL,
  length_min int NOT NULL,
  url varchar(60) NOT NULL
);

# insert records
INSERT INTO videos (video_id, title, length_min, url) 
	VALUES ( 1, 'SQL for Beginners. Learn basics of SQL in 1 Hour', 57, 'https://www.youtube.com/watch?v=7Vtl2WggqOg');
INSERT INTO videos (video_id, title, length_min, url) 
	VALUES ( 2, 'Introduction to SQL - Tutorial for beginners to databases.', 10, 'https://www.youtube.com/watch?v=HgoM1I4yEFo');
INSERT INTO videos (video_id, title, length_min, url) 
	VALUES ( 3, 'Introduction to SQL Databases ', 149, 'https://www.youtube.com/watch?v=k6cgsCqBTj0');

# test
SELECT * FROM videos; 

# create reviewer table
CREATE TABLE reviewers
(
  reviewer_id int PRIMARY KEY,
  username varchar(30) NOT NULL,
  rating int NOT NULL,
  textreview varchar(60) NOT NULL,
  video_id int NULL REFERENCES videos
 );
 
# insert records
INSERT INTO reviewers (reviewer_id, username, rating, textreview, video_id) 
	VALUES (1, 'Jim', 3, 'Content OK, but not the HR advertised', 1); 
INSERT INTO reviewers (reviewer_id, username, rating, textreview, video_id) 
	VALUES (2, 'Jimena', 5, 'Great Tutorial!   Thanks!', 1); 
INSERT INTO reviewers (reviewer_id, username, rating, textreview, video_id) 
	VALUES (3, 'Ji', 4, 'I learned quite a bit.', 1); 
INSERT INTO reviewers (reviewer_id, username, rating, textreview, video_id) 
	VALUES (4, 'Bob', 1, 'Meh', 2); 
INSERT INTO reviewers (reviewer_id, username, rating, textreview, video_id) 
	VALUES (5, 'Bailey', 2, 'Not great', 2); 
INSERT INTO reviewers (reviewer_id, username, rating, textreview, video_id) 
	VALUES (6, 'Begonia', 1, 'Might have learned more with more content', 2); 
INSERT INTO reviewers (reviewer_id, username, rating, textreview, video_id) 
	VALUES (7, 'Chris', 3, 'It was good, till I fell asleep', 3); 
INSERT INTO reviewers (reviewer_id, username, rating, textreview, video_id) 
	VALUES (8, 'Caree', 3, 'Solid, but too long', 3); 
INSERT INTO reviewers (reviewer_id, username, rating, textreview, video_id) 
	VALUES (9, 'Caleb', 4, 'I learned alot!', 3); 

# test
SELECT * FROM reviewers;

## show videos and reviews together
SELECT v.title, v.length_min, r.username, r.rating, r.textreview FROM videos v
   INNER JOIN reviewers r ON v.video_id = r.video_id
ORDER BY v.title;

## show avg rating per video
SELECT ROUND(AVG(rating), 2) AS avg_rating, v.title FROM reviewers r
	INNER JOIN videos v ON r.video_id = v.video_id
GROUP BY v.title;

 
 