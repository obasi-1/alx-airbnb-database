-- This script creates the database schema for the AirBnB clone project.
-- It defines all tables, columns, constraints, and indexes.

-- Create a new database (optional, use if needed)
-- CREATE DATABASE IF NOT EXISTS hbnb_dev_db;
-- USE hbnb_dev_db;

-- Table: users
-- Stores user information.
CREATE TABLE IF NOT EXISTS users (
    id INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    PRIMARY KEY (id)
);

-- Table: states
-- Stores state information.
CREATE TABLE IF NOT EXISTS states (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

-- Table: cities
-- Stores city information, linked to a state.
CREATE TABLE IF NOT EXISTS cities (
    id INT NOT NULL AUTO_INCREMENT,
    state_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (state_id) REFERENCES states(id)
);

-- Index for faster lookups of cities within a state.
CREATE INDEX idx_cities_state_id ON cities(state_id);

-- Table: amenities
-- Stores available amenities.
CREATE TABLE IF NOT EXISTS amenities (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

-- Table: places
-- Stores information about the places/properties available for rent.
CREATE TABLE IF NOT EXISTS places (
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    city_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(1024),
    number_rooms INT NOT NULL DEFAULT 0,
    number_bathrooms INT NOT NULL DEFAULT 0,
    max_guest INT NOT NULL DEFAULT 0,
    price_by_night INT NOT NULL DEFAULT 0,
    latitude FLOAT,
    longitude FLOAT,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (city_id) REFERENCES cities(id)
);

-- Indexes for faster lookups of places by user and city.
CREATE INDEX idx_places_user_id ON places(user_id);
CREATE INDEX idx_places_city_id ON places(city_id);

-- Table: reviews
-- Stores user reviews for places.
CREATE TABLE IF NOT EXISTS reviews (
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    place_id INT NOT NULL,
    text TEXT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (place_id) REFERENCES places(id)
);

-- Indexes for faster lookups of reviews by user and place.
CREATE INDEX idx_reviews_user_id ON reviews(user_id);
CREATE INDEX idx_reviews_place_id ON reviews(place_id);


-- Table: place_amenity (Junction Table)
-- Links places and amenities in a many-to-many relationship.
CREATE TABLE IF NOT EXISTS place_amenity (
    place_id INT NOT NULL,
    amenity_id INT NOT NULL,
    PRIMARY KEY (place_id, amenity_id),
    FOREIGN KEY (place_id) REFERENCES places(id),
    FOREIGN KEY (amenity_id) REFERENCES amenities(id)
);

-- Indexes for the junction table to optimize joins from either direction.
CREATE INDEX idx_place_amenity_place_id ON place_amenity(place_id);
CREATE INDEX idx_place_amenity_amenity_id ON place_amenity(amenity_id);

