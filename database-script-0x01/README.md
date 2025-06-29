**AirBnB Clone - Database Schema**

This repository contains the complete database schema for the ALX AirBnB Clone project. The schema is designed to be robust, scalable, and normalized to the Third Normal Form (3NF).Project OverviewThe purpose of this database is to store all necessary information for a simplified AirBnB-style application. This includes data for users, properties (places), locations (states and cities), amenities, and reviews.Schema Diagram (ERD)The following Entity-Relationship Diagram illustrates the tables and their relationships within the database.erDiagram
 
    users {
        int id PK
        varchar(255) email
        varchar(255) password
        varchar(255) first_name
        varchar(255) last_name
    }
    states {
        int id PK
        varchar(255) name
    }
    cities {
        int id PK
        int state_id FK
        varchar(255) name
    }
    amenities {
        int id PK
        varchar(255) name
    }
    places {
        int id PK
        int user_id FK
        int city_id FK
        varchar(255) name
        varchar(1024) description
        int number_rooms
        int number_bathrooms
        int max_guest
        int price_by_night
        float latitude
        float longitude
    }
    reviews {
        int id PK
        int user_id FK
        int place_id FK
        text text
    }
    place_amenity {
        int place_id FK
        int amenity_id FK
    }
    users ||--o{ places : "owns"
    users ||--o{ reviews : "writes"
    states ||--o{ cities : "contains"
    cities ||--o{ places : "located_in"
    places }o--|| amenities : "has"
    places ||--o{ reviews : "receives"
    place_amenity }o--|| places : "links"
    place_amenity }o--|| amenities : "links"

How to UseTo create the database and all its tables, you can execute the schema.sql script provided in this directory.Navigate to the database-script-0x01 directory.Connect to your MySQL server.Run the following command:mysql -u your_username -p < schema.sql

This command will execute the script, creating the database hbnb_dev_db (if it doesn't exist) and all the necessary tables, constraints, and indexes.NormalizationThe database schema is designed to be in Third Normal Form (3NF).1NF: All column values are atomic, and each table has a primary key.2NF: All non-key attributes are fully dependent on the primary key. This is met as most tables have a single-column primary key, and the place_amenity junction table has no non-key attributes.3NF: There are no transitive dependencies. For example, a place's state is determined by its city, not stored directly in the places table, thus avoiding a transitive dependency.This normalized design reduces data redundancy and improves data integrity.
