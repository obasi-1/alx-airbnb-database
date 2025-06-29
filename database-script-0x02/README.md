alx-airbnb-database/database-script-0x02/seed.sql

This directory contains the SQL script seed.sql, designed to populate the alx-airbnb-database with comprehensive sample data.

Objective

The primary objective of seed.sql is to facilitate testing and development by providing a realistic dataset for the database schema. 

This script includes INSERT statements for various tables, ensuring that the database can be quickly brought to a state that reflects typical real-world usage of an Airbnb-like application.

Content

The seed.sql script includes sample data for the following key entities:

Users: Multiple user accounts with diverse profiles.

Properties: A variety of property listings, including different types (e.g., apartments, houses, private rooms), locations, and pricing.

Bookings: Sample bookings demonstrating various scenarios, such as past bookings, upcoming bookings, and bookings by different users for different properties.

Payments: Associated payment records for the bookings.

Reviews: User-generated reviews for properties, providing feedback and ratings.

Usage

To use this script, ensure you have access to your database management system (e.g., MySQL, PostgreSQL) and the alx-airbnb-database schema has already been created.

Navigate to the database-script-0x02 directory.

Execute the seed.sql script against your database. For example, using MySQL client:mysql -u your_username -p your_database_name < seed.sql

(Replace your_username and your_database_name with your actual credentials.)This will populate your database with the sample data, allowing you to test queries, application functionalities, and data relationships effectively.
