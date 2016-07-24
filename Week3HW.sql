/* hw3 walt wells 7.23-7.31.2016 */

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS groups;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS groups_rooms;

/* create tables 
 one to many between users and groups
 many to many between groups and rooms */
 
CREATE TABLE users
(
  user_id int PRIMARY KEY,
  user_name varchar(100) NOT NULL UNIQUE,
  group_id int NULL REFERENCES groups
);

CREATE TABLE groups
(
  group_id int PRIMARY KEY,
  group_name varchar(100) NOT NULL UNIQUE
);

CREATE TABLE rooms
(
  room_id int PRIMARY KEY,
  room_name varchar(100) NOT NULL UNIQUE
);

CREATE TABLE groups_rooms
(
  group_id int NOT NULL REFERENCES groups(group_id),
  room_id int NOT NULL REFERENCES rooms(room_id),
  CONSTRAINT pk_groups_rooms PRIMARY KEY(group_id, room_id)
 );

/* insert data */
INSERT INTO users (user_id, user_name, group_id) VALUES ( 1, 'Modesto', 1);
INSERT INTO users (user_id, user_name, group_id) VALUES ( 2, 'Ayine', 1);
INSERT INTO users (user_id, user_name, group_id) VALUES ( 3, 'Christopher', 2);
INSERT INTO users (user_id, user_name, group_id) VALUES ( 4, 'Cheong woo', 2);
INSERT INTO users (user_id, user_name, group_id) VALUES ( 5, 'Saulat', 3);
INSERT INTO users (user_id, user_name, group_id) VALUES ( 6, 'Heidy', NULL);

INSERT INTO groups (group_id, group_name) VALUES (1, 'I.T');
INSERT INTO groups (group_id, group_name) VALUES (2, 'Sales');
INSERT INTO groups (group_id, group_name) VALUES (3, 'Administration');
INSERT INTO groups (group_id, group_name) VALUES (4, 'Operations');

INSERT INTO rooms (room_id, room_name) VALUES (1, '101');
INSERT INTO rooms (room_id, room_name) VALUES (2, '102');
INSERT INTO rooms (room_id, room_name) VALUES (3, 'Auditorium A');
INSERT INTO rooms (room_id, room_name) VALUES (4, 'Auditorium B');

INSERT INTO groups_rooms (group_id, room_id) VALUES (1, 1);
INSERT INTO groups_rooms (group_id, room_id) VALUES (1, 2);
INSERT INTO groups_rooms (group_id, room_id) VALUES (2, 2);
INSERT INTO groups_rooms (group_id, room_id) VALUES (2, 3);

/* initial test review */
SELECT * FROM users;
SELECT * FROM groups;
SELECT * FROM rooms;
SELECT * FROM groups_rooms;

/* All groups, and the users in each group.  A group should appear 
even if there are no users assigned to the group. */

SELECT g.group_name, u.user_name FROM groups g
  LEFT JOIN users  u ON u.group_id = g.group_id
ORDER BY g.group_name, u.user_name;

/* All rooms, and the groups assigned to each room.  The rooms should 
appear even if no groups have been assigned to them. */

SELECT r.room_name, g.group_name FROM rooms r
	LEFT JOIN groups_rooms gr ON r.room_id = gr.room_id
    LEFT JOIN groups g ON g.group_id = gr.group_id
ORDER BY r.room_name, g.group_name;

/* A list of users, the groups that they belong to, and the rooms to 
which they are assigned.  This should be sorted alphabetically by user, 
then by group, then by room. */ 
SELECT u.user_name AS 'User', g.group_name AS 'Group', r.room_name AS 'Room' FROM users u
	LEFT JOIN groups g ON g.group_id = u.group_id
    LEFT JOIN groups_rooms gr ON gr.group_id = g.group_id
    LEFT JOIN rooms r ON r.room_id = gr.room_id
ORDER BY u.user_name, g.group_name, r.room_name;
