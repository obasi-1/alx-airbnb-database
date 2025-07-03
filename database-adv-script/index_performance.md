SQL Indexes for Database Optimization

This directory contains SQL scripts for creating indexes on key columns within the database schema (User, Property, Booking, and Review tables). These indexes are designed to significantly improve query performance by speeding up data retrieval operations.

database_index.sql

This file contains CREATE INDEX commands for columns that are frequently used in:

WHERE clauses (for filtering data)

JOIN conditions (for linking tables efficiently)

ORDER BY clauses (for sorting results quickly)

Identified High-Usage Columns and Corresponding Indexes:

users table:

user_id: Essential for joins with bookings and reviews.

email: Common for user lookups and authentication.

properties table:

property_id: Critical for joins with bookings and reviews.

property_name: Useful if properties are frequently searched by name.

address: Beneficial for location-based filtering or searches.

bookings table:

booking_id: Primary key, often used in direct lookups.

user_id: Foreign key, vital for joining with users.

property_id: Foreign key, vital for joining with properties.

start_date, end_date: Composite index for efficient querying of date ranges.

reviews table (assuming its existence and usage):

review_id: Primary key.

property_id: Foreign key, crucial for joining with properties.

user_id: Foreign key, if reviews are linked to users.

How to Use:

Execute the SQL: Connect to your database and run the commands in database_index.sql. This will create the specified indexes.

Measure Performance:

Before Indexing: Run your high-usage queries (e.g., those from joins_queries.sql or aggregations_and_window_functions.sql) and use your database's query analysis tool to see their execution plan and performance metrics.

PostgreSQL/MySQL: Prefix your query with EXPLAIN ANALYZE (e.g., EXPLAIN ANALYZE SELECT ... FROM ... JOIN ...;).

SQL Server: Use SET STATISTICS IO ON; SET STATISTICS TIME ON; before your query, then SET STATISTICS IO OFF; SET STATISTICS TIME OFF; after. You can also use EXPLAIN PLAN or graphical execution plans.

Oracle: Use EXPLAIN PLAN FOR SELECT ...; followed by SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);.

After Indexing: Re-run the exact same queries and use EXPLAIN ANALYZE (or equivalent) again. Compare the output (e.g., "rows examined," "execution time," "cost") to observe the performance improvement. You should see a reduction in scan types (e.g., from full table scans to index scans) and overall execution time for queries that benefit from the indexes.

Important Considerations:

Index Overhead: While indexes speed up reads, they add overhead to write operations (INSERT, UPDATE, DELETE) as the index also needs to be updated. Create indexes judiciously on columns that genuinely benefit from them.

Cardinality: Indexes are most effective on columns with high cardinality (many unique values).

Composite Indexes: For queries that filter or sort on multiple columns, a composite index (e.g., (start_date, end_date)) can be more efficient than separate single-column indexes.
