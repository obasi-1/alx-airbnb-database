-- This database schema is assumed for the queries below, consistent with the previous examples.
--
-- Users Table:
--   user_id (PK)
--   user_name
--
-- Properties Table:
--   property_id (PK)
--   property_name
--
-- Bookings Table:
--   booking_id (PK)
--   user_id (FK to Users)
--
-- Reviews Table:
--   review_id (PK)
--   property_id (FK to Properties)
--   rating

-- Query 1: Non-Correlated Subquery
-- Objective: Find all properties where the average rating is greater than 4.0.
-- Explanation: A non-correlated subquery is an independent query whose output is used by the outer query.
-- Here, the inner query first calculates the 'property_id' for all properties that have an average rating above 4.0.
-- The outer query then selects all information for those specific properties.

SELECT
    property_id,
    property_name,
    location
FROM
    Properties
WHERE
    property_id IN (
        SELECT
            property_id
        FROM
            Reviews
        GROUP BY
            property_id
        HAVING
            AVG(rating) > 4.0
    );

-- Query 2: Correlated Subquery
-- Objective: Find users who have made more than 3 bookings.
-- Explanation: A correlated subquery depends on the outer query for its values. It is evaluated once for each row processed by the outer query.
-- The outer query iterates through each user. For each user, the inner query counts how many bookings they have made.
-- The WHERE clause in the outer query then checks if this count is greater than 3.

SELECT
    user_id,
    user_name,
    email
FROM
    Users AS u
WHERE
    (
        SELECT
            COUNT(*)
        FROM
            Bookings AS b
        WHERE
            b.user_id = u.user_id
    ) > 3;
