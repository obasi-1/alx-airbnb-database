**ALX Airbnb Database - Advanced SQL: join_queries**

This repository contains advanced SQL scripts for the ALX Airbnb database project. The focus of this directory is to demonstrate complex querying techniques, particularly using different types of SQL JOINs.

**Directory:** database-adv-script

This directory holds scripts that go beyond basic CRUD operations and explore more advanced database functionalities.

**File:** joins_queries.sql

This SQL script provides a set of queries to illustrate the use of INNER JOIN, LEFT JOIN, and FULL OUTER JOIN on the Airbnb database schema.

**Database Schema**

The queries in joins_queries.sql are based on the following table structure:

**Users Table:**

user_id (Primary Key)

user_name

email

**Properties Table:**

property_id (Primary Key)

property_name

location

**Bookings Table:**

booking_id (Primary Key)

user_id (Foreign Key to Users)

property_id (Foreign Key to Properties)

booking_date

**Reviews Table:**

review_id (Primary Key)

property_id (Foreign Key to Properties)

user_id (Foreign Key to Users)

rating

comment

**SQL Joins Explained**

This script demonstrates the practical application of different SQL JOIN clauses.

1. **INNER JOIN**
  
. Objective: To retrieve all bookings and the respective users who made those bookings.
  
. Explanation: The INNER JOIN query fetches records that have matching values in both the Bookings and Users tables based on user_id. This is useful for creating reports that combine information from two related tables.

2. **LEFT JOIN**
  
. Objective: To retrieve all properties and their reviews, including properties that have no reviews.

. Explanation: The LEFT JOIN query returns all records from the Properties table, and the matched records from the Reviews table. If a property has no reviews, the review columns will appear as NULL. This is ideal for finding items in one table that do not have a corresponding entry in another.

3. **FULL OUTER JOIN**
  
. Objective: To retrieve all users and all bookings, showing all users (even those with no bookings) and all bookings (even those not linked to a user).

. Explanation: The FULL OUTER JOIN combines the results of both LEFT JOIN and RIGHT JOIN. The result set will contain all records from both tables and fill in NULL for missing matches on either side.

Note on MySQL: Since MySQL does not natively support FULL OUTER JOIN, the script includes a commented-out example of how to achieve the same result using a UNION of a LEFT JOIN and a RIGHT JOIN.

**How to Use**

Ensure you have a database with the schema described above.

Populate the tables with some sample data.

Execute the queries in joins_queries.sql using a SQL client (like MySQL Workbench, DBeaver, or the command line) connected to your database.

Analyze the results to understand how each type of JOIN works.


**ALX Airbnb Database - Advanced SQL: Subqueries**

This document outlines the contents of the subqueries.sql script within the alx-airbnb-database repository. This script is dedicated to demonstrating the use of both non-correlated and correlated subqueries in SQL.

**Directory:** database-adv-script

This directory contains scripts that showcase advanced SQL techniques for querying the ALX Airbnb database.

**File:** subqueries.sql

This SQL script provides examples of subqueries, which are queries nested inside a larger query. It covers two main types: non-correlated and correlated subqueries.

**Database Schema Assumed**

The queries in this script are written based on the following table structure:

**Users Table:**

user_id (Primary Key)

user_name

email

**Properties Table:**

property_id (Primary Key)

property_name

location

**Bookings Table:**

booking_id (Primary Key)

user_id (Foreign Key to Users)

**Reviews Table:**

review_id (Primary Key)

property_id (Foreign Key to Properties)

rating

**SQL Subqueries Explained**

This script provides practical examples for two types of subqueries.

1. **Non-Correlated Subquery**

Objective: To find all properties that have an average rating greater than 4.0.

Explanation: A non-correlated (or simple) subquery is executed once and is independent of the outer query. The inner query runs first and returns a list of property_ids that meet the criteria (average rating > 4.0). The outer query then uses this list to retrieve the full details of those properties.

2. **Correlated Subquery**

Objective: To find all users who have made more than 3 bookings.

Explanation: A correlated subquery is dependent on the outer query and is executed once for each row processed by the outer query. In this example, for each user selected by the outer query, the inner query counts the number of bookings associated with that user's user_id. The outer query's WHERE clause then uses this count to filter for users with more than 3 bookings.

**How to Use**

Set up a database with the schema described above.

Ensure the tables are populated with relevant data.

Run the queries from the subqueries.sql file in a SQL client connected to your database.

Examine the output of each query to understand the difference in how non-correlated and correlated subqueries are processed and the results they produce.
