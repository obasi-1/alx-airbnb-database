-- performance.sql

-- This file contains SQL queries for demonstrating performance optimization.
-- It includes an initial complex query, instructions for performance analysis,
-- and a refactored version of the query.

-- Assuming the following table schemas (simplified for demonstration):
-- users: user_id (PK), username, email
-- properties: property_id (PK), property_name, address
-- bookings: booking_id (PK), user_id (FK), property_id (FK), start_date, end_date, total_price
-- payments: payment_id (PK), booking_id (FK), amount, payment_date, payment_status

-- -----------------------------------------------------------------------------
-- Initial Complex Query: Retrieve all bookings with user, property, and payment details
-- This query uses multiple INNER JOINs to combine data from four tables.
-- It retrieves all available columns from each joined table.
-- This query might be inefficient if not all columns are needed or if tables are very large
-- and lack proper indexing on join columns.
-----------------------------------------------------------------------------
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price AS booking_total_price,
    u.user_id,
    u.username,
    u.email,
    p.property_id,
    p.property_name,
    p.address,
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_date,
    pay.payment_status
FROM
    bookings AS b
INNER JOIN
    users AS u ON b.user_id = u.user_id
INNER JOIN
    properties AS p ON b.property_id = p.property_id
INNER JOIN
    payments AS pay ON b.booking_id = pay.booking_id
ORDER BY
    b.booking_id;

-- -----------------------------------------------------------------------------
-- Performance Analysis Instructions (using EXPLAIN / ANALYZE)
-- -----------------------------------------------------------------------------
-- To analyze the performance of the initial query (or any SQL query),
-- you can use your database's EXPLAIN or ANALYZE command.
-- This command shows the execution plan of the query, indicating how the
-- database intends to retrieve the data, including join order, index usage,
-- and estimated costs.

-- For PostgreSQL / MySQL:
-- Run the following command before your query:
-- EXPLAIN ANALYZE
-- SELECT
--     b.booking_id,
--     b.start_date,
--     b.end_date,
--     b.total_price AS booking_total_price,
--     u.user_id,
--     u.username,
--     u.email,
--     p.property_id,
--     p.property_name,
--     p.address,
--     pay.payment_id,
--     pay.amount AS payment_amount,
--     pay.payment_date,
--     pay.payment_status
-- FROM
--     bookings AS b
-- INNER JOIN
--     users AS u ON b.user_id = u.user_id
-- INNER JOIN
--     properties AS p ON b.property_id = p.property_id
-- INNER JOIN
--     payments AS pay ON b.booking_id = pay.booking_id
-- ORDER BY
--     b.booking_id;

-- For SQL Server:
-- SET STATISTICS IO ON;
-- SET STATISTICS TIME ON;
-- -- Then run your query
-- SET STATISTICS IO OFF;
-- SET STATISTICS TIME OFF;
-- You can also use the graphical execution plan feature in SQL Server Management Studio.

-- For Oracle:
-- EXPLAIN PLAN FOR
-- SELECT ... (your query here);
-- SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- Key metrics to look for in the EXPLAIN output:
-- - Execution Time: The actual time taken (with ANALYZE).
-- - Cost: An estimated numerical value representing the query's resource consumption.
-- - Rows: Number of rows processed at each step.
-- - Scan Type: Look for 'Seq Scan' / 'Table Scan' (full table scan) vs. 'Index Scan' / 'Index Only Scan'.
--   Index scans are generally faster for filtered or joined data.
-- - Join Method: Hash Join, Merge Join, Nested Loop Join – different methods have different performance characteristics.

-- -----------------------------------------------------------------------------
-- Refactored Query: Optimized for specific data needs and performance
-- This refactored version aims to improve performance by:
-- 1. Selecting only necessary columns: Reduces data transfer and processing.
-- 2. Assuming proper indexing: Relies on indexes created (e.g., in database_index.sql)
--    on foreign key columns (user_id, property_id, booking_id) and other frequently
--    accessed columns to speed up joins and filtering.
-- 3. Filtering early (if applicable): If you only need a subset of data (e.g., bookings
--    from a specific date range or by a specific user), add WHERE clauses.
--    (Not explicitly added here, but a common optimization strategy).
-----------------------------------------------------------------------------
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    u.username,         -- Only retrieve username, not all user details
    p.property_name,    -- Only retrieve property name, not all property details
    pay.amount,         -- Only retrieve payment amount and status
    pay.payment_status
FROM
    bookings AS b
INNER JOIN
    users AS u ON b.user_id = u.user_id
INNER JOIN
    properties AS p ON b.property_id = p.property_id
INNER JOIN
    payments AS pay ON b.booking_id = pay.booking_id
WHERE
    b.start_date >= '2023-01-01' -- Example: Add a filter to reduce result set size
ORDER BY
    b.start_date DESC, b.booking_id; -- Order by a relevant indexed column
