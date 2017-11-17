CREATE TABLE students(id SERIAL, name TEXT);
CREATE TABLE classes(id SERIAL, name TEXT, teacher_id INT);
CREATE TABLE teachers(id SERIAL, name TEXT, room_number INT);
CREATE TABLE enrollments(id SERIAL, student_id INT, class_id INT, grade INT);

INSERT INTO students (name)
VALUES ('Penelope'),
       ('Peter'),
       ('Pepe'),
       ('Parth'),
       ('Priscilla'),
       ('Pablo'),
       ('Puja'),
       ('Patricia'),
       ('Piper'),
       ('Paula'),
       ('Pamela'),
       ('Paige'),
       ('Peggy'),
       ('Pedro'),
       ('Phoebe'),
       ('Pajak'),
       ('Parker'),
       ('Priyal'),
       ('Paxton'),
       ('Patrick');


INSERT INTO teachers (name, room_number)
VALUES ('Phillips', 456),
       ('Vandergrift', 120),
       ('Mauch', 101),
       ('Patel', 320),
       ('Marquez', 560),
       ('Boykin', 200),
       ('Phlop', 333),
       ('Pendergrass', 222),
       ('Palomo', 323),
       ('Altshuler', 543),
       ('Aleman', 187),
       ('Ashley', 432),
       ('Bonacci', 399),
       ('Brazukas', 287),
       ('Brockington', 299),
       ('Brizuela', 376),
       ('Burkhart', 199),
       ('Choi', 463),
       ('Shah', 354),
       ('Dimaggio', 251);

INSERT INTO classes (name, teacher_id)
VALUES ('Cooking Pasta', 1),
       ('Yoga', 1),
       ('How to Guitar', 2),
       ('Gym', 3),
       ('Football', 4),
       ('Calculus', 5),
       ('Fruit', 6),
       ('Social Studies', 7),
       ('English', 8),
       ('Programming', 9),
       ('Singing', 10),
       ('Fashion', 11);

INSERT INTO enrollments (student_id, class_id, grade)
VALUES (1, 1, 60),
       (2, 2, 70),
       (2, 4, 100),
       (3, 2, 74),
       (4, 3, 82),
       (5, 3, 45),
       (5, 4, 50),
       (7, 11, 62),
       (7, 10, 76),
       (7, 9, 81),
       (7, 8, 91),
       (8, 8, 84),
       (9, 8, 88),
       (9, 7, 83),
       (10, 7, 93),
       (10, 5, 95),
       (11, 5, 95),
       (11, 11, 80),
       (11, 6, 95),
       (11, 1, 94),
       (11, 2, 60),
       (12, 6, 55),
       (13, 7, 97),
       (14, 10, 86),
       (15, 9, 77),
       (15, 4, 93),
       (15, 1, 73),
       (16, 2, 79),
       (16, 6, 73),
       (17, 7, 86),
       (17, 8, 91),
       (17, 9, 93),
       (18, 10, 94),
       (19, 4, 84),
       (20, 1, 85),
       (20, 11, 89),
       (20, 3, 98);

-- List all the students and their classes

SELECT students.name student_name, classes.name class_name
FROM enrollments
INNER JOIN students ON enrollments.student_id = students.id
INNER JOIN classes  ON enrollments.class_id   = classes.id;

--  student_name |   class_name
-- --------------+----------------
--  Penelope     | Cooking Pasta
--  Peter        | Yoga
--  Peter        | Gym
--  Pepe         | Yoga
--  Parth        | How to Guitar
--  Priscilla    | How to Guitar
--  Priscilla    | Gym
--  Puja         | Singing
--  Puja         | Programming
--  Puja         | English
--  Puja         | Social Studies
--  Patricia     | Social Studies
--  Piper        | Social Studies
--  Piper        | Fruit
--  Paula        | Fruit
--  Paula        | Football
--  Pamela       | Cooking Pasta
--  Pamela       | Yoga
--  Pamela       | Football
--  Pamela       | Calculus
--  Pamela       | Singing
--  Paige        | Calculus
--  Peggy        | Fruit
--  Pedro        | Programming
--  Phoebe       | English
--  Phoebe       | Gym
--  Phoebe       | Cooking Pasta
--  Pajak        | Yoga
--  Pajak        | Calculus
--  Parker       | Social Studies
--  Parker       | English
--  Parker       | Fruit
--  Priyal       | Programming
--  Paxton       | Gym
--  Patrick      | Cooking Pasta
--  Patrick      | Singing
--  Patrick      | How to Guitar

-- List all the students and their classes and rename the columns to "student" and "class"
SELECT students.name AS student, classes.name AS class FROM enrollments
INNER JOIN students  ON enrollments.student_id = students.id
INNER JOIN classes   ON enrollments.class_id   = classes.id;

-- List all the students and their average grade
SELECT students.name student, avg(grade) average FROM enrollments
INNER JOIN students ON enrollments.student_id = students.id
GROUP BY students.name;

--   student  |       average
-- -----------+---------------------
--  Piper     | 85.5000000000000000
--  Paige     | 55.0000000000000000
--  Pedro     | 86.0000000000000000
--  Peter     | 85.0000000000000000
--  Peggy     | 97.0000000000000000
--  Patricia  | 84.0000000000000000
--  Paula     | 94.0000000000000000
--  Phoebe    | 81.0000000000000000
--  Pamela    | 84.8000000000000000
--  Parker    | 90.0000000000000000
--  Priscilla | 47.5000000000000000
--  Priyal    | 94.0000000000000000
--  Patrick   | 90.6666666666666667
--  Puja      | 77.5000000000000000
--  Paxton    | 84.0000000000000000
--  Pepe      | 74.0000000000000000
--  Penelope  | 60.0000000000000000
--  Pajak     | 76.0000000000000000
--  Parth     | 82.0000000000000000

-- List all the students and a count of how many classes they are currently enrolled in
SELECT students.name student, count(classes) classes FROM enrollments
INNER JOIN students ON enrollments.student_id = students.id
INNER JOIN classes  ON enrollments.class_id   = classes.id
GROUP BY students.name;

--   student  | classes
-- -----------+---------
--  Piper     |       2
--  Paige     |       1
--  Pedro     |       1
--  Peter     |       2
--  Peggy     |       1
--  Patricia  |       1
--  Paula     |       2
--  Phoebe    |       3
--  Pamela    |       5
--  Parker    |       3
--  Priscilla |       2
--  Priyal    |       1
--  Patrick   |       3
--  Puja      |       4
--  Paxton    |       1
--  Pepe      |       1
--  Penelope  |       1
--  Pajak     |       2
--  Parth     |       1

-- List all the students and their class count IF they are in more than 2 classes
SELECT students.name student, count(classes) classes FROM enrollments
INNER JOIN students ON enrollments.student_id = students.id
INNER JOIN classes  ON enrollments.class_id   = classes.id
GROUP BY students.name
HAVING count(classes) > 2;

--  student | classes
-- ---------+---------
--  Phoebe  |       3
--  Pamela  |       5
--  Parker  |       3
--  Patrick |       3
--  Puja    |       4

-- List all the teachers for each student
SELECT students.name AS student, teachers.name AS teacher FROM enrollments
INNER JOIN students  ON enrollments.student_id = students.id
INNER JOIN classes   ON enrollments.class_id   = classes.id
INNER JOIN teachers  ON classes.teacher_id     = teachers.id;

--   student  |   teacher
-- -----------+-------------
--  Pamela    | Phillips
--  Penelope  | Phillips
--  Patrick   | Phillips
--  Phoebe    | Phillips
--  Pajak     | Phillips
--  Pamela    | Phillips
--  Pepe      | Phillips
--  Peter     | Phillips
--  Patrick   | Vandergrift
--  Parth     | Vandergrift
--  Priscilla | Vandergrift
--  Paxton    | Mauch
--  Phoebe    | Mauch
--  Peter     | Mauch
--  Priscilla | Mauch
--  Paula     | Patel
--  Pamela    | Patel
--  Pamela    | Marquez
--  Paige     | Marquez
--  Pajak     | Marquez
--  Paula     | Boykin
--  Peggy     | Boykin
--  Piper     | Boykin
--  Parker    | Boykin
--  Patricia  | Phlop
--  Piper     | Phlop
--  Puja      | Phlop
--  Parker    | Phlop
--  Parker    | Pendergrass
--  Phoebe    | Pendergrass
--  Puja      | Pendergrass
--  Puja      | Palomo
--  Priyal    | Palomo
--  Pedro     | Palomo
--  Pamela    | Altshuler
--  Patrick   | Altshuler
--  Puja      | Altshuler

-- List all the teachers for each student grouped by each student
SELECT students.name AS student, teachers.name AS teacher FROM enrollments
INNER JOIN students  ON enrollments.student_id = students.id
INNER JOIN classes   ON enrollments.class_id   = classes.id
INNER JOIN teachers  ON classes.teacher_id     = teachers.id
GROUP BY students.name, teachers.name;

--   student  |   teacher
-- -----------+-------------
--  Paige     | Marquez
--  Pajak     | Marquez
--  Pajak     | Phillips
--  Pamela    | Altshuler
--  Pamela    | Marquez
--  Pamela    | Patel
--  Pamela    | Phillips
--  Parker    | Boykin
--  Parker    | Pendergrass
--  Parker    | Phlop
--  Parth     | Vandergrift
--  Patricia  | Phlop
--  Patrick   | Altshuler
--  Patrick   | Phillips
--  Patrick   | Vandergrift
--  Paula     | Boykin
--  Paula     | Patel
--  Paxton    | Mauch
--  Pedro     | Palomo
--  Peggy     | Boykin
--  Penelope  | Phillips
--  Pepe      | Phillips
--  Peter     | Mauch
--  Peter     | Phillips
--  Phoebe    | Mauch
--  Phoebe    | Pendergrass
--  Phoebe    | Phillips
--  Piper     | Boykin
--  Piper     | Phlop
--  Priscilla | Mauch
--  Priscilla | Vandergrift
--  Priyal    | Palomo
--  Puja      | Altshuler
--  Puja      | Palomo
--  Puja      | Pendergrass
--  Puja      | Phlop

-- Find the average grade for a each class
SELECT classes.name AS class, avg(grade) AS average FROM enrollments
INNER JOIN classes  ON enrollments.class_id = classes.id
GROUP BY class;

--      class      |       average
-- ----------------+---------------------
--  Yoga           | 70.7500000000000000
--  Social Studies | 88.5000000000000000
--  Fruit          | 89.7500000000000000
--  Singing        | 77.0000000000000000
--  Football       | 95.0000000000000000
--  Cooking Pasta  | 78.0000000000000000
--  How to Guitar  | 75.0000000000000000
--  Calculus       | 74.3333333333333333
--  Gym            | 81.7500000000000000
--  Programming    | 85.3333333333333333
--  English        | 83.6666666666666667

-- List students' name and their grade IF their grade is lower than the average.
SELECT min(students.name) AS name, avg(enrollments.grade) AS average FROM students
LEFT JOIN enrollments ON students.id = enrollments.student_id
GROUP BY students.id
HAVING avg(enrollments.grade) < 81;

--    name    |       average
-- -----------+---------------------
--  Penelope  | 60.0000000000000000
--  Pepe      | 74.0000000000000000
--  Priscilla | 47.5000000000000000
--  Puja      | 77.5000000000000000
--  Paige     | 55.0000000000000000
--  Pajak     | 76.0000000000000000