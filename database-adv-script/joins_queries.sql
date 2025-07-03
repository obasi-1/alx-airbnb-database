-- Query 1: Retrieve all bookings and the respective users who made those bookings using INNER JOIN
-- This query combines rows from the 'bookings' table with rows from the 'users' table
-- where there is a match in the 'user_id' column in both tables.
-- It will only return bookings that have a corresponding user, and users who have made bookings.
-- Results are ordered by booking_id for clarity.
SELECT
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    u.user_id,
    u.username,
    u.email
FROM
    bookings AS b
INNER JOIN
    users AS u ON b.user_id = u.user_id
ORDER BY
    b.booking_id;

-- Query 2: Retrieve all properties and their reviews, including properties that have no reviews, using LEFT JOIN
-- This query returns all rows from the 'properties' table (the "left" table)
-- and the matching rows from the 'reviews' table (the "right" table).
-- If there is no matching review for a property, the columns from the 'reviews' table will be NULL.
-- Results are ordered by property_id and then review_id (if present) for clarity.
SELECT
    p.property_id,
    p.property_name,
    p.address,
    r.review_id,
    r.rating,
    r.comment,
    r.user_id AS reviewer_user_id
FROM
    properties AS p
LEFT JOIN
    reviews AS r ON p.property_id = r.property_id
ORDER BY
    p.property_id, r.review_id;

-- Query 3: Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user, using FULL OUTER JOIN
-- Note: FULL OUTER JOIN is not supported in all SQL databases (e.g., MySQL).
-- If your database supports FULL OUTER JOIN (like PostgreSQL, SQL Server, Oracle), you can use the syntax below.
-- This query returns all rows when there is a match in either the left (users) or right (bookings) table.
-- Rows for which there is no match in the other table will have NULLs for the columns of the non-matching table.
-- Results are ordered by user_id and then booking_id for clarity.
/*
SELECT
    u.user_id,
    u.username,
    u.email,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date
FROM
    users AS u
FULL OUTER JOIN
    bookings AS b ON u.user_id = b.user_id
ORDER BY
    u.user_id, b.booking_id;
*/

-- Alternative for databases that do not support FULL OUTER JOIN directly (e.g., MySQL):
-- This simulates a FULL OUTER JOIN by combining a LEFT JOIN and a RIGHT JOIN using UNION ALL.
-- The LEFT JOIN gets all users and their bookings (or NULLs if no booking).
-- The RIGHT JOIN gets all bookings and their users (or NULLs if no user),
-- and then filters out rows that were already included by the LEFT JOIN to avoid duplicates.
-- Results are ordered by user_id and then booking_id for clarity.
SELECT
    u.user_id,
    u.username,
    u.email,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date
FROM
    users AS u
LEFT JOIN
    bookings AS b ON u.user_id = b.user_id
UNION ALL
SELECT
    u.user_id,
    u.username,
    u.email,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date
FROM
    users AS u
RIGHT JOIN
    bookings AS b ON u.user_id = b.user_id
WHERE
    u.user_id IS NULL -- This condition ensures we only pick up bookings not linked to any user from the RIGHT JOIN part
ORDER BY
    user_id, booking_id;
