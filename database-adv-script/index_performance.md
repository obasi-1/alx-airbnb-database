# Create the content for database_index.sql and save it as a file
index_sql = """
-- USER Table Indexes
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_user_created_at ON User(created_at);

-- PROPERTY Table Indexes
CREATE INDEX idx_property_user_id ON Property(user_id);
CREATE INDEX idx_property_location ON Property(location);
CREATE INDEX idx_property_created_at ON Property(created_at);
CREATE INDEX idx_property_price ON Property(price);

-- BOOKING Table Indexes
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);
CREATE INDEX idx_booking_status ON Booking(status);
"""

file_path = "/mnt/data/database_index.sql"
with open(file_path, "w") as file:
    file.write(index_sql)

file_path

