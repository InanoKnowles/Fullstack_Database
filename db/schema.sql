-- Thu 15 DEC 5:33PM -----> My terminal stopped working and wouldn't let me push to git hub

CREATE DATABASE command_board_db;
\c command_board_db

-- Tables needed:

--> For the tasks being made and assigned
CREATE TABLE tasks(
  id SERIAL PRIMARY KEY,
  task_name TEXT,
  task_instructions TEXT,
  assign_task_to TEXT
);

-- In case of emergencies:
DROP TABLE tasks;

-- Add items to the tasks table
INSERT INTO tasks(task_name, task_instructions, assign_task_to)
VALUES
('Laundry', 'Take all the dirty laundry and put through a wash cycle in the the washing machine. Hang up to dry and then bring back inside once all cleaned and dry.', 'Mario'),
('Dishes', 'Collect all the dirty dishes around the house, wash, dry and put away into designated spots.', 'Luigi');

--> That looks like this on psql:
--  id | task_name |                                                                    task_instructions                                                                    | assign_task_to 
-- ----+-----------+---------------------------------------------------------------------------------------------------------------------------------------------------------+----------------
--   1 | Laundry   | Take all the dirty laundry and put through a wash cycle in the the washing machine. Hang up to dry and then bring back inside once all cleaned and dry. | Mario
--   2 | Dishes    | Collect all the dirty dishes around the house, wash, dry and put away into designated spots.                                                            | Luigi
-- (2 rows)
-- ----+-----------+---------------------------------------------------------------------------------------------------------------------------------------------------------+----------------

--> For the users of the application
CREATE TABLE users(
  id SERIAL PRIMARY KEY,
  first_name TEXT,
  last_name TEXT,
  email TEXT
);
--Don't need these values to start off with I just wanted to play with this
INSERT INTO users(first_name, last_name, email)
VALUES
  ('Daisy', 'Doo', 'dd@me.com'),
  ('Mario', 'OldBro', 'smash.com'),
  ('Luigi', 'LilBro', 'squish.com');

ALTER TABLE users ADD COLUMN password_digest TEXT;

SELECT * FROM users;

CREATE TABLE done(
  id SERIAL PRIMARY KEY,
  user_id INTEGER,
  task_id INTEGER
);

ALTER TABLE done
ADD CONSTRAINT unique_done
UNIQUE(user_id, task_id);