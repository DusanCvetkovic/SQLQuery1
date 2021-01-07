DROP DATABASE acme;
CREATE DATABASE acme;

USE acme;

CREATE TABLE users1(
id INT IDENTITY,
   first_name VARCHAR(100),
   last_name VARCHAR(100),
   email VARCHAR(50),
   password VARCHAR(20),
   location VARCHAR(100),
   dept VARCHAR(100),
   is_admin INT,
   register_date DATETIME,
   PRIMARY KEY(id)
);

INSERT INTO users1 (first_name, last_name, email, password, location, dept, is_admin, register_date) values ('Brad', 'Traversy', 'brad@gmail.com', '123456','Massachusetts', 'development', 1, GETDATE());
INSERT INTO users1 (first_name, last_name, email, password, location, dept,  is_admin, register_date) values ('Fred', 'Smith', 'fred@gmail.com', '123456', 'New York', 'design', 0, GETDATE()), ('Sara', 'Watson', 'sara@gmail.com', '123456', 'New York', 'design', 0, GETDATE()),('Will', 'Jackson', 'will@yahoo.com', '123456', 'Rhode Island', 'development', 1, GETDATE()),('Paula', 'Johnson', 'paula@yahoo.com', '123456', 'Massachusetts', 'sales', 0, GETDATE()),('Tom', 'Spears', 'tom@yahoo.com', '123456', 'Massachusetts', 'sales', 0, GETDATE());

SELECT * FROM users1;
SELECT first_name, last_name FROM users;

SELECT * FROM users1 WHERE location='Massachusetts';
SELECT * FROM users1 WHERE location='Massachusetts' AND dept='sales';
SELECT * FROM users1 WHERE is_admin = 1;
SELECT * FROM users1 WHERE is_admin > 0;

DELETE FROM users1 WHERE id = 6;

UPDATE users1 SET email = 'freddy@gmail.com' WHERE id = 2;

ALTER TABLE users1 ADD age VARCHAR(3);

UPDATE users1 SET age = 20  WHERE id= 1;
UPDATE users1 SET age = 23  WHERE id= 2;
UPDATE users1 SET age = 34  WHERE id= 3;
UPDATE users1 SET age = 29  WHERE id= 4;
UPDATE users1 SET age = 40  WHERE id= 5;

SELECT * FROM users1 ORDER BY last_name ASC;
SELECT * FROM users1 ORDER BY last_name DESC;

SELECT CONCAT(first_name, ' ', last_name) AS 'Name', dept FROM users1;

SELECT DISTINCT location FROM users1;

SELECT * FROM users1 WHERE age BETWEEN 20 AND 25;

SELECT * FROM users1 WHERE dept LIKE 'd%';
SELECT * FROM users1 WHERE dept LIKE 'dev%';
SELECT * FROM users1 WHERE dept LIKE '%t';
SELECT * FROM users WHERE dept LIKE '%e%';

SELECT * FROM users1 WHERE dept NOT LIKE 'd%';

SELECT * FROM users1 WHERE dept IN ('design', 'sales');

CREATE INDEX LIndex On users1(location);
DROP INDEX LIndex ON users1;

CREATE TABLE posts(
id INT IDENTITY,
   user_id INT,
   title VARCHAR(100),
   body TEXT,
   publish_date DATETIME DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY(id),
   FOREIGN KEY (user_id) REFERENCES users1(id)
);

INSERT INTO posts(user_id, title, body) VALUES (1, 'Post One', 'This is post one'),(3, 'Post Two', 'This is post two'),(1, 'Post Three', 'This is post three'),(2, 'Post Four', 'This is post four'),(5, 'Post Five', 'This is post five'),(4, 'Post Six', 'This is post six'),(2, 'Post Seven', 'This is post seven'),(1, 'Post Eight', 'This is post eight'),(3, 'Post Nine', 'This is post none'),(4, 'Post Ten', 'This is post ten');

SELECT
  users1.first_name,
  users1.last_name,
  posts.title,
  posts.publish_date
FROM users1
INNER JOIN posts
ON users1.id = posts.user_id
ORDER BY posts.title;

CREATE TABLE comments(
	id INT IDENTITY,
    post_id INT,
    user_id INT,
    body TEXT,
    publish_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id),
    FOREIGN KEY(user_id) references users1(id),
    FOREIGN KEY(post_id) references posts(id)
);

INSERT INTO comments(post_id, user_id, body) VALUES (1, 3, 'This is comment one'),(2, 1, 'This is comment two'),(5, 3, 'This is comment three'),(2, 4, 'This is comment four'),(1, 2, 'This is comment five'),(3, 1, 'This is comment six'),(3, 2, 'This is comment six'),(5, 4, 'This is comment seven'),(2, 3, 'This is comment seven');

SELECT
comments.body,
posts.title
FROM comments
LEFT JOIN posts ON posts.id = comments.post_id
ORDER BY posts.title;

SELECT
comments.body,
posts.title,
users1.first_name,
users1.last_name
FROM comments
INNER JOIN posts on posts.id = comments.post_id
INNER JOIN users1 on users1.id = comments.user_id
ORDER BY posts.title;

SELECT COUNT(id) FROM users1;
SELECT MAX(age) FROM users1;
SELECT MIN(age) FROM users1;

SELECT age, COUNT(age) FROM users1 GROUP BY age;
SELECT age, COUNT(age) FROM users1 WHERE age > 20 GROUP BY age;
SELECT age, COUNT(age) FROM users1 GROUP BY age HAVING count(age) >=2;