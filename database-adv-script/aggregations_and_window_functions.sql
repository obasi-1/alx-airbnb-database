-- Query 1: Find the total number of bookings made by each user
-- This query counts the number of bookings for each unique user_id
-- and groups the results by user_id to show the total for each.
SELECT
    user_id,
    COUNT(booking_id) AS total_bookings
FROM
    bookings
GROUP BY
    user_id;

-- Query 2: Rank properties based on the total number of bookings they have received
-- This query first calculates the total number of bookings for each property_id
-- using a subquery (or CTE).
-- Then, it uses the RANK() window function to assign a rank to each property
-- based on their total bookings in descending order.
-- RANK() handles ties by assigning the same rank to properties with the same number of bookings,
-- and then skipping the next rank(s).
WITH PropertyBookings AS (
    SELECT
        property_id,
        COUNT(booking_id) AS total_property_bookings
    FROM
        bookings
    GROUP BY
        property_id
)
SELECT
    property_id,
    total_property_bookings,
    RANK() OVER (ORDER BY total_property_bookings DESC) AS property_rank
FROM
    PropertyBookings
ORDER BY
    property_rank, total_property_bookings DESC;
