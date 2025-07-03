-- This database schema is assumed for the queries below.
--
-- Users Table:
--   user_id (PK)
--   user_name
--   email
--
-- Properties Table:
--   property_id (PK)
--   property_name
--   location
--
-- Bookings Table:
--   booking_id (PK)
--   user_id (FK to Users)
--   property_id (FK to Properties)
--   booking_date
--
-- Reviews Table:
--   review_id (PK)
--   property_id (FK to Properties)
--   user_id (FK to Users)
--   rating
--   comment

-- Query 1: INNER JOIN
-- Objective: Retrieve all bookings and the respective users who made them.
-- An INNER JOIN returns only the rows where the join condition is met in both tables.
-- In this case, it will only return bookings that have an associated user.

SELECT
    b.booking_id,
    b.booking_date,
    u.user_id,
    u.user_name,
    u.email
FROM
    Bookings AS b
INNER JOIN
    Users AS u ON b.user_id = u.user_id;

-- Query 2: LEFT JOIN
-- Objective: Retrieve all properties and their reviews, including properties that have no reviews.
-- A LEFT JOIN returns all rows from the left table (Properties) and the matched rows from the right table (Reviews).
-- If there is no match, the columns from the right table will have NULL values.

SELECT
    p.property_id,
    p.property_name,
    p.location,
    r.review_id,
    r.rating,
    r.comment
FROM
    Properties AS p
LEFT JOIN
    Reviews AS r ON p.property_id = r.property_id;

-- Query 3: FULL OUTER JOIN
-- Objective: Retrieve all users and all bookings, including users without bookings and bookings without an assigned user.
-- A FULL OUTER JOIN returns all rows when there is a match in either the left (Users) or the right (Bookings) table.
-- It's useful for seeing all data from two tables, with NULLs in place where matches don't exist on either side.
-- Note: MySQL does not support FULL OUTER JOIN directly. You can emulate it using a UNION of a LEFT JOIN and a RIGHT JOIN.
-- The query below is standard SQL and works in databases like PostgreSQL and SQL Server.

SELECT
    u.user_id,
    u.user_name,
    b.booking_id,
    b.booking_date
FROM
    Users AS u
FULL OUTER JOIN
    Bookings AS b ON u.user_id = b.user_id;

-- Emulation of FULL OUTER JOIN for MySQL:
/*
SELECT
    u.user_id,
    u.user_name,
    b.booking_id,
    b.booking_date
FROM
    Users u
LEFT JOIN
    Bookings b ON u.user_id = b.user_id
UNION
SELECT
    u.user_id,
    u.user_name,
    b.booking_id,
    b.booking_date
FROM
    Users u
RIGHT JOIN
    Bookings b ON u.user_id = b.user_id
WHERE
    u.user_id IS NULL;
*/
