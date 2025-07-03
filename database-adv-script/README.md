**ALX Airbnb Database - Advanced SQL Scripts**

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
