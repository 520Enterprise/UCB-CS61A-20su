.read data.sql


CREATE TABLE bluedog AS
  SELECT color, pet FROM students WHERE pet = 'dog' AND color = 'blue';

CREATE TABLE bluedog_songs AS
  SELECT color, pet, song FROM students WHERE pet = 'dog' AND color = 'blue';


CREATE TABLE matchmaker AS
  SELECT a.pet, a.song, a.color, b.color FROM students AS a, students AS b WHERE a.song = b.song AND a.pet = b.pet AND a.time < b.time;


CREATE TABLE sevens AS
SELECT a.seven FROM students AS a, numbers AS b WHERE a.number = 7 AND b.'7' = 'True' AND a.time = b.time;


CREATE TABLE favpets AS
  SELECT pet, COUNT(*) AS count FROM students GROUP BY pet ORDER BY count DESC LIMIT 10;


CREATE TABLE dog AS
  SELECT * FROM favpets WHERE pet = 'dog';


CREATE TABLE bluedog_agg AS
  SELECT song, COUNT(*) AS count FROM bluedog_songs GROUP BY song ORDER BY count DESC LIMIT 10;


CREATE TABLE instructor_obedience AS
  SELECT seven, instructor, COUNT(*) AS count FROM students WHERE seven = '7' GROUP BY instructor ORDER BY count DESC LIMIT 10;

