-- monitoring_and_refinement.sql

-- This file contains SQL commands for monitoring query performance,
-- identifying bottlenecks, and demonstrating potential refinements.

-- Note: The specific commands for monitoring (e.g., SHOW PROFILE)
-- vary by database system. EXPLAIN ANALYZE is widely supported.

-- -----------------------------------------------------------------------------
-- Section 1: Frequently Used Queries for Monitoring
-- These are examples of queries you might frequently use in an Airbnb-like application.
-- We will use these to demonstrate performance monitoring.
-----------------------------------------------------------------------------

-- Query A: Get all active bookings for a specific user, ordered by start date.
-- This query might be used on a user's dashboard.
SELECT
    b.booking_id,
    b.property_id,
    p.property_name,
    b.start_date,
    b.end_date,
    b.total_price
FROM
    bookings AS b
INNER JOIN
    properties AS p ON b.property_id = p.property_id
WHERE
    b.user_id = 'your_example_user_id_here' -- Replace with an actual user_id
    AND b.end_date >= CURRENT_DATE
ORDER BY
    b.start_date DESC;

-- Query B: Find properties with an average rating above a certain threshold in a specific city.
-- This query might be used for property search and discovery.
SELECT
    p.property_id,
    p.property_name,
    p.address,
    AVG(r.rating) AS average_rating,
    COUNT(r.review_id) AS total_reviews
FROM
    properties AS p
INNER JOIN
    reviews AS r ON p.property_id = r.property_id
WHERE
    p.city = 'New York' -- Replace with an actual city
GROUP BY
    p.property_id, p.property_name, p.address
HAVING
    AVG(r.rating) >= 4.5
ORDER BY
    average_rating DESC, total_reviews DESC;

-- Query C: Count the number of bookings per property per month.
-- This query might be used for analytical reporting.
SELECT
    p.property_name,
    TO_CHAR(b.start_date, 'YYYY-MM') AS booking_month, -- PostgreSQL syntax for month extraction
    -- For MySQL: DATE_FORMAT(b.start_date, '%Y-%m')
    -- For SQL Server: FORMAT(b.start_date, 'yyyy-MM')
    COUNT(b.booking_id) AS monthly_bookings
FROM
    bookings AS b
INNER JOIN
    properties AS p ON b.property_id = p.property_id
GROUP BY
    p.property_name, booking_month
ORDER BY
    p.property_name, booking_month;


-- -----------------------------------------------------------------------------
-- Section 2: Monitoring Performance using EXPLAIN ANALYZE (PostgreSQL/MySQL Example)
-- Run these commands before and after making any schema adjustments (e.g., adding indexes).
-----------------------------------------------------------------------------

-- To monitor Query A:
-- EXPLAIN ANALYZE
-- SELECT
--     b.booking_id,
--     b.property_id,
--     p.property_name,
--     b.start_date,
--     b.end_date,
--     b.total_price
-- FROM
--     bookings AS b
-- INNER JOIN
--     properties AS p ON b.property_id = p.property_id
-- WHERE
--     b.user_id = 'your_example_user_id_here' -- Replace with an actual user_id
--     AND b.end_date >= CURRENT_DATE
-- ORDER BY
--     b.start_date DESC;

-- To monitor Query B:
-- EXPLAIN ANALYZE
-- SELECT
--     p.property_id,
--     p.property_name,
--     p.address,
--     AVG(r.rating) AS average_rating,
--     COUNT(r.review_id) AS total_reviews
-- FROM
--     properties AS p
-- INNER JOIN
--     reviews AS r ON p.property_id = r.property_id
-- WHERE
--     p.city = 'New York' -- Replace with an actual city
-- GROUP BY
--     p.property_id, p.property_name, p.address
-- HAVING
--     AVG(r.rating) >= 4.5
-- ORDER BY
--     average_rating DESC, total_reviews DESC;

-- To monitor Query C:
-- EXPLAIN ANALYZE
-- SELECT
--     p.property_name,
--     TO_CHAR(b.start_date, 'YYYY-MM') AS booking_month,
--     COUNT(b.booking_id) AS monthly_bookings
-- FROM
--     bookings AS b
-- INNER JOIN
--     properties AS p ON b.property_id = p.property_id
-- GROUP BY
--     p.property_name, booking_month
-- ORDER BY
--     p.property_name, booking_month;


-- -----------------------------------------------------------------------------
-- Section 3: Suggested Schema Adjustments (Examples)
-- Based on EXPLAIN ANALYZE output, you might suggest new indexes.
-----------------------------------------------------------------------------

-- Example 1: If Query A is slow due to 'user_id' filtering and 'end_date' ordering.
-- CREATE INDEX idx_bookings_user_end_date ON bookings (user_id, end_date DESC);
-- CREATE INDEX idx_bookings_user_start_date ON bookings (user_id, start_date DESC);
-- (Consider composite index if both are frequently used together in WHERE/ORDER BY)

-- Example 2: If Query B is slow due to 'city' filtering or 'property_id' join.
-- CREATE INDEX idx_properties_city ON properties (city);
-- CREATE INDEX idx_reviews_property_id ON reviews (property_id); -- (If not already indexed)

-- Example 3: If Query C is slow due to joins or grouping.
-- Ensure indexes on foreign keys (b.property_id, b.user_id).
-- Consider an index on b.start_date if not already present, especially for date functions.
-- CREATE INDEX idx_bookings_start_date ON bookings (start_date);

-- -----------------------------------------------------------------------------
-- Section 4: Implement Changes and Re-Measure Performance
-- After adding indexes or making other schema changes, re-run the EXPLAIN ANALYZE
-- commands from Section 2 to observe the improvements.
-----------------------------------------------------------------------------
