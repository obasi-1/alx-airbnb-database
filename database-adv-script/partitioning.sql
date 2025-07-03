-- partitioning.sql

-- This file demonstrates how to implement table partitioning on a large 'bookings' table
-- based on the 'start_date' column. Partitioning can significantly improve query performance
-- for large datasets, especially when queries frequently filter by date ranges.

-- Note: The syntax for table partitioning varies significantly between database systems.
-- This example uses a syntax similar to PostgreSQL's declarative partitioning.
-- For other databases (MySQL, SQL Server, Oracle), the syntax and capabilities will differ.

-- -----------------------------------------------------------------------------
-- Step 1: Create the Master Partitioned Table (PostgreSQL-like syntax)
-- This table acts as the parent table for all partitions.
-- It is crucial that the partitioning key (start_date) is part of the primary key
-- if you define a primary key on the partitioned table.
-----------------------------------------------------------------------------
CREATE TABLE bookings_partitioned (
    booking_id UUID PRIMARY KEY, -- Or INT, BIGINT depending on your ID type
    user_id UUID NOT NULL,
    property_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    -- Add foreign key constraints (these typically need to be on the parent table
    -- and then implicitly apply to partitions, or explicitly on each partition depending on DB)
    -- CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(user_id),
    -- CONSTRAINT fk_property FOREIGN KEY (property_id) REFERENCES properties(property_id)
) PARTITION BY RANGE (start_date);

-- -----------------------------------------------------------------------------
-- Step 2: Create Individual Partitions
-- Each partition is a separate table that stores a specific range of data.
-- Data inserted into 'bookings_partitioned' will automatically be routed to the
-- correct child partition based on its 'start_date'.
-----------------------------------------------------------------------------

-- Example Partitions (by year)
CREATE TABLE bookings_2022 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

CREATE TABLE bookings_2023 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE bookings_2024 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

-- You can also partition by smaller ranges, e.g., quarterly or monthly, for very large tables.
-- Example: Quarterly partitions for 2024
/*
CREATE TABLE bookings_2024_q1 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2024-04-01');
CREATE TABLE bookings_2024_q2 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2024-04-01') TO ('2024-07-01');
CREATE TABLE bookings_2024_q3 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2024-07-01') TO ('2024-10-01');
CREATE TABLE bookings_2024_q4 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2024-10-01') TO ('2025-01-01');
*/

-- -----------------------------------------------------------------------------
-- Step 3: (Optional) Migrate Existing Data
-- If you have an existing 'bookings' table, you would need to move its data
-- into the new partitioned table.
-- This is a simplified example; for production, consider batching and locking.
-----------------------------------------------------------------------------
-- INSERT INTO bookings_partitioned SELECT * FROM old_bookings_table;
-- Then, you might rename old_bookings_table and bookings_partitioned.

-- -----------------------------------------------------------------------------
-- Step 4: Example Queries to Test Performance
-- When querying the 'bookings_partitioned' table, the database's query planner
-- will automatically prune (exclude) partitions that do not contain relevant data
-- based on the WHERE clause conditions on the partitioning key (start_date).
-----------------------------------------------------------------------------

-- Query 1: Fetch bookings for a specific date range (e.g., all of 2023)
-- This query should only scan the 'bookings_2023' partition.
SELECT *
FROM bookings_partitioned
WHERE start_date >= '2023-01-01' AND start_date < '2024-01-01';

-- Query 2: Fetch bookings for a specific month (e.g., January 2024)
-- This query should only scan the 'bookings_2024' partition (or 'bookings_2024_q1' if quarterly).
SELECT booking_id, user_id, property_id, start_date, end_date
FROM bookings_partitioned
WHERE start_date >= '2024-01-01' AND start_date < '2024-02-01'
ORDER BY start_date;

-- Query 3: Fetch bookings for a specific user within a date range
-- This query benefits from both partitioning (pruning irrelevant date partitions)
-- and potentially an index on user_id within the relevant partition.
SELECT booking_id, start_date, end_date, total_price
FROM bookings_partitioned
WHERE user_id = 'a1b2c3d4-e5f6-7890-1234-567890abcdef' -- Example user_id (replace with actual)
  AND start_date >= '2023-07-01' AND start_date < '2023-08-01';
