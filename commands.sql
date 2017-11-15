-- COMMANDS FROM THAT YUNG INTERMEDIATE SQL TUT;
CREATE DATABASE intermediate_sql;
-- Close the current connection and connect to the DB we just created.
\c intermediate_sql;

CREATE TABLE items(id SERIAL, name TEXT, revenue INT, course TEXT);

INSERT INTO items (name, revenue, course)

VALUES ('lobster mac n cheese', 1200, 'side'),
       ('veggie lasagna',       1000, 'main'),
       ('striped bass',         500,  'main'),
       ('arugula salad',        1100, 'salad');

-- Aggregate Functions

SELECT sum(column_name)   FROM table_name;
SELECT avg(column_name)   FROM table_name;
SELECT max(column_name)   FROM table_name;
SELECT min(column_name)   FROM table_name;
SELECT count(column_name) FROM table_name;

-- Write queries for the following:

-- Return all main courses. Hint: What ActiveRecord method would you use to get this?
SELECT * from items where course = 'main';

-- Return only the names of the main courses.
SELECT name from items where course = 'main';

-- Return the min and max value for the main courses.
SELECT max(revenue) from items where course = 'main';
SELECT min(revenue) from items where course = 'main';

-- What's the total revenue for all main courses?
SELECT sum(revenue) from items where course = 'main';

-- INNER JOINS
CREATE TABLE seasons(id SERIAL, name TEXT);
CREATE TABLE items(id SERIAL, name TEXT, revenue INT, season_id INT);
CREATE TABLE categories(id SERIAL, name TEXT);
CREATE TABLE item_categories(item_id INT, category_id INT);

INSERT INTO seasons (name)
VALUES ('summer'),
       ('autumn'),
       ('winter'),
       ('spring');

INSERT INTO items (name, revenue, season_id)
VALUES ('lobster mac n cheese', 1200, 3),
       ('veggie lasagna', 1000, 1),
       ('striped bass', 500, 1),
       ('burger', 2000, 1),
       ('grilled cheese', 800, 4),
       ('hot dog', 1000, 1),
       ('arugula salad', 1100, 2);

INSERT INTO categories (name)
VALUES ('side'),
       ('dinner'),
       ('lunch'),
       ('vegetarian');

INSERT INTO item_categories (item_id, category_id)
VALUES (1, 1),
       (2, 2),
       (2, 4),
       (3, 2),
       (4, 3),
       (5, 3),
       (5, 4),
       (7, 1),
       (7, 2),
       (7, 3),
       (7, 4);


-- For our first query, we are going to grab each item and its season using an INNER JOIN.
SELECT * FROM items
INNER JOIN seasons
ON items.season_id = seasons.id;

-- Can you get it to display only the name for the item and the name for the season?

-- by id
SELECT items.name AS item_name, items.season_id AS season_name FROM items, seasons WHERE items.season_id = seasons.id;

-- By name
SELECT items.name AS item_name, seasons.name AS season_name FROM items, seasons WHERE items.season_id = seasons.id;

-- RETURNS :

--       item_name       | season_name
-- ----------------------+-------------
--  hot dog              | summer
--  bish lasagna         | summer
--  veggie lasagna       | summer
--  striped bass         | summer
--  burger               | summer
--  arugula salad        | autumn
--  lobster mac n cheese | winter
--  grilled cheese       | spring

-- Now let's combine multiple INNER JOINs to pull data from three tables items, categories and item_categories.

-- Write a query that pulls all the category names for arugula salad. Hint: Use multiple INNER JOINs and a WHERE clause.

-- not quite there...
SELECT items.name AS item_name, categories.name AS categories_name
FROM items, categories, item_categories
WHERE item_categories.category_id = item_categories.item_id;

-- closer
SELECT items.name AS item_name, categories.name AS categories_name
FROM items, categories, item_categories
WHERE item_categories.category_id = item_categories.item_id AND items.name = 'arugula salad';

--    item_name   | categories_name
-- ---------------+-----------------
--  arugula salad | side
--  arugula salad | side
--  arugula salad | dinner
--  arugula salad | dinner
--  arugula salad | lunch
--  arugula salad | lunch
--  arugula salad | vegetarian
--  arugula salad | vegetarian

-- yep
SELECT DISTINCT items.name AS item_name, categories.name AS categories_name
FROM items, categories, item_categories
WHERE item_categories.category_id = item_categories.item_id AND items.name = 'arugula salad';

--    item_name   | categories_name
-- ---------------+-----------------
--  arugula salad | dinner
--  arugula salad | vegetarian
--  arugula salad | lunch
--  arugula salad | side