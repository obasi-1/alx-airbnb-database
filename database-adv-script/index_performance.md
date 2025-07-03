-- database_index.sql

-- USER
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_user_created_at ON User(created_at);

-- PROPERTY
CREATE INDEX idx_property_user_id ON Property(user_id);
CREATE INDEX idx_property_location ON Property(location);
CREATE INDEX idx_property_created_at ON Property(created_at);
CREATE INDEX idx_property_price ON Property(price);

-- BOOKING
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);
CREATE INDEX idx_booking_status ON Booking(status);
