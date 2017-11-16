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
SELECT * FROM items WHERE course = 'main';

-- Return only the names of the main courses.
SELECT NAME FROM items WHERE course = 'main';

-- Return the min and max value for the main courses.
SELECT max(revenue) FROM items WHERE course = 'main';
SELECT max(revenue), min(revenue) from items WHERE course = 'main';
SELECT min(revenue) FROM items WHERE course = 'main';
SELECT avg(revenue) FROM items WHERE course = 'main';

-- What's the total revenue for all main courses?
SELECT sum(revenue) FROM items WHERE course = 'main';

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

-- Outer Joins

INSERT INTO items (name, revenue, season_id)
VALUES ('italian beef', 600, NULL),
       ('cole slaw', 150, NULL),
       ('ice cream sandwich', 700, NULL);

SELECT i.name items, s.name seasons
FROM items i
INNER JOIN seasons s
ON i.season_id = s.id;

-- items                | seasons
-- ---------------------+---------
-- hot dog              | summer
-- veggie lasagna       | summer
-- striped bass         | summer
-- burger               | summer
-- arugula salad        | autumn
-- lobster mac n cheese | winter
-- grilled cheese       | spring

SELECT *
FROM items i
LEFT OUTER JOIN seasons s
ON i.season_id = s.id;

--  id |         name         | revenue | season_id | id |  name
-- ----+----------------------+---------+-----------+----+--------
--   4 | striped bass         |     500 |         1 |  1 | summer
--   2 | bish lasagna         |    1000 |         1 |  1 | summer
--   3 | veggie lasagna       |    1000 |         1 |  1 | summer
--   5 | burger               |    2000 |         1 |  1 | summer
--   7 | hot dog              |    1000 |         1 |  1 | summer
--   8 | arugula salad        |    1100 |         2 |  2 | autumn
--   1 | lobster mac n cheese |    1200 |         3 |  3 | winter
--   6 | grilled cheese       |     800 |         4 |  4 | spring
--   9 | italian beef         |     600 |           |    |
--  10 | cole slaw            |     150 |           |    |
--  11 | ice cream sandwich   |     700 |           |    |

SELECT * FROM items i RIGHT OUTER JOIN seasons s ON i.season_id = s.id;

--  id |         name         | revenue | season_id | id |  name
-- ----+----------------------+---------+-----------+----+--------
--   4 | striped bass         |     500 |         1 |  1 | summer
--   2 | bish lasagna         |    1000 |         1 |  1 | summer
--   3 | veggie lasagna       |    1000 |         1 |  1 | summer
--   5 | burger               |    2000 |         1 |  1 | summer
--   7 | hot dog              |    1000 |         1 |  1 | summer
--   8 | arugula salad        |    1100 |         2 |  2 | autumn
--   1 | lobster mac n cheese |    1200 |         3 |  3 | winter
--   6 | grilled cheese       |     800 |         4 |  4 | spring


-- Sub queries sup
-- Write a WHERE clause that returns the items that have a revenue greater than that average.

SELECT * FROM items WHERE revenue > (SELECT AVG(revenue) FROM items);

--  id |         name         | revenue | season_id
-- ----+----------------------+---------+-----------
--   1 | lobster mac n cheese |    1200 |         3
--   2 | bish lasagna         |    1000 |         1
--   3 | veggie lasagna       |    1000 |         1
--   5 | burger               |    2000 |         1
--   7 | hot dog              |    1000 |         1
--   8 | arugula salad        |    1100 |         2

-- Write a query that returns the sum of all items that have a category of dinner.
SELECT SUM(i.revenue)
FROM items i
INNER JOIN item_categories ic
ON i.id = ic.item_id
INNER JOIN categories c
ON c.id = ic.category_id
WHERE c.name = 'dinner';

--  sum
-- ------
--  3000


-- Write a query that returns the sum of all items for each category. The end result should look like this:
SELECT c.name, SUM(i.revenue)
FROM categories c
INNER JOIN item_categories ic
ON c.id = ic.category_id
INNER JOIN items i
ON i.id = ic.item_id
GROUP BY c.name;

SELECT categories.name, SUM(items.revenue)
FROM categories
INNER JOIN item_categories ON categories.id = item_categories.category_id
INNER JOIN items ON items.id = item_categories.item_id
GROUP BY categories.name

--     name    | sum
-- ------------+------
--  dinner     | 3000
--  vegetarian | 4000
--  lunch      | 3500
--  side       | 2200

-- Write a query that returns the sum of all items for each category. The end result should look like this:
