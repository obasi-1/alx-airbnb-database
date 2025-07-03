# database_index.sql 

-- This file contains SQL commands to create indexes on frequently queried columns
-- across the User, Booking, Property, and Review tables.
-- Indexes help improve the performance of SELECT queries by allowing the database
-- to locate rows more quickly.

-- Note: Primary keys usually have unique indexes created automatically.
-- These commands are for additional indexes on foreign keys and other frequently
-- filtered/joined/ordered columns.

-- -----------------------------------------------------------------------------
-- Indexes for 'users' table
-- -----------------------------------------------------------------------------
-- Index on user_id: While typically a primary key and automatically indexed,
-- explicitly ensuring an index here is crucial as it's a common join column.
CREATE INDEX idx_users_user_id ON users (user_id);

-- Index on email: Useful if users frequently log in or are searched by email.
CREATE INDEX idx_users_email ON users (email);

-- -----------------------------------------------------------------------------
-- Indexes for 'properties' table
-- -----------------------------------------------------------------------------
-- Index on property_id: Similar to user_id, often a primary key and join column.
CREATE INDEX idx_properties_property_id ON properties (property_id);

-- Index on property_name: If properties are often searched by name.
CREATE INDEX idx_properties_property_name ON properties (property_name);

-- Index on address: If properties are frequently filtered or searched by address.
CREATE INDEX idx_properties_address ON properties (address);

-- -----------------------------------------------------------------------------
-- Indexes for 'bookings' table
-- -----------------------------------------------------------------------------
-- Index on booking_id: Often a primary key.
CREATE INDEX idx_bookings_booking_id ON bookings (booking_id);

-- Index on user_id: Crucial for performance when joining 'bookings' with 'users'.
CREATE INDEX idx_bookings_user_id ON bookings (user_id);

-- Index on property_id: Crucial for performance when joining 'bookings' with 'properties'.
CREATE INDEX idx_bookings_property_id ON bookings (property_id);

-- Index on start_date and end_date: Essential for queries involving date ranges.
-- A composite index can be beneficial for queries filtering by both dates.
CREATE INDEX idx_bookings_dates ON bookings (start_date, end_date);

-- -----------------------------------------------------------------------------
-- Indexes for 'reviews' table (assuming it exists and is used in joins)
-- -----------------------------------------------------------------------------
-- Index on review_id: Often a primary key.
CREATE INDEX idx_reviews_review_id ON reviews (review_id);

-- Index on property_id: Crucial for performance when joining 'reviews' with 'properties'.
CREATE INDEX idx_reviews_property_id ON reviews (property_id);

-- Index on user_id: If reviews are linked back to users and frequently joined.
CREATE INDEX idx_reviews_user_id ON reviews (user_id);
