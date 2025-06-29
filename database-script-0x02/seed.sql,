-- This script populates the hbnb_dev_db database with sample data.
-- It should be run after the schema.sql script has been executed.

-- Use the target database
-- USE hbnb_dev_db;

-- Insert States
INSERT INTO states (name) VALUES
('Lagos'),
('Abuja'),
('Rivers');

-- Insert Cities
-- Assuming Lagos state ID is 1, Abuja is 2, Rivers is 3
INSERT INTO cities (state_id, name) VALUES
(1, 'Ikeja'),
(1, 'Lekki'),
(1, 'Victoria Island'),
(2, 'Asokoro'),
(2, 'Maitama'),
(3, 'Port Harcourt');

-- Insert Users
INSERT INTO users (email, password, first_name, last_name) VALUES
('tunde@example.com', 'password123', 'Tunde', 'Adeyemi'),
('chioma@example.com', 'password456', 'Chioma', 'Okoro'),
('aminu@example.com', 'password789', 'Aminu', 'Bello');

-- Insert Amenities
INSERT INTO amenities (name) VALUES
('WiFi'),
('Air conditioning'),
('Pool'),
('Kitchen'),
('Free parking'),
('Gym');

-- Insert Places
-- Assuming user Tunde is ID 1, Chioma is 2, Aminu is 3
-- Assuming city Lekki is ID 2, Victoria Island is 3, Maitama is 5, Port Harcourt is 6
INSERT INTO places (user_id, city_id, name, description, number_rooms, number_bathrooms, max_guest, price_by_night, latitude, longitude) VALUES
(1, 2, 'Cozy 2-Bedroom Flat in Lekki', 'A beautiful and serene apartment perfect for a weekend getaway. Close to the beach and popular restaurants.', 2, 2, 4, 25000, 6.4589, 3.6064),
(2, 3, 'Luxury Penthouse with Ocean View', 'Experience luxury in the heart of Victoria Island. This penthouse offers stunning views of the Atlantic.', 4, 5, 8, 80000, 6.4297, 3.4239),
(3, 5, 'Modern Studio in Maitama', 'A stylish and compact studio apartment in a high-brow area of Abuja. Ideal for business travelers.', 1, 1, 2, 35000, 9.0722, 7.4913),
(1, 6, 'Family Home in Port Harcourt', 'A spacious home suitable for families, located in a secure estate in Port Harcourt.', 3, 3, 6, 45000, 4.8156, 7.0498),
(2, 2, 'Chic Apartment near Lekki Conservation Centre', 'A modern apartment with all the essential amenities. A great spot for nature lovers.', 1, 2, 3, 28000, 6.4212, 3.5222);

-- Insert Reviews
-- Assuming place 'Cozy 2-Bedroom Flat' is ID 1, 'Luxury Penthouse' is ID 2, 'Modern Studio' is ID 3
-- Assuming user Chioma is ID 2, Tunde is ID 1
INSERT INTO reviews (user_id, place_id, text) VALUES
(2, 1, 'Had a wonderful stay! The place was clean, and the host Tunde was very responsive. Highly recommend.'),
(1, 2, 'Absolutely breathtaking views and top-notch facilities. Chioma is a fantastic host. Worth every penny.'),
(3, 1, 'Great location and very comfortable. I enjoyed my short stay.'),
(1, 3, 'Perfect for my business trip. The apartment was clean, quiet, and had fast WiFi. Aminu was very helpful.');

-- Link Places to Amenities (Many-to-Many)
-- Assuming place IDs are 1, 2, 3, 4, 5 and amenity IDs are 1-6
-- Place 1: Cozy Flat in Lekki
INSERT INTO place_amenity (place_id, amenity_id) VALUES (1, 1), (1, 2), (1, 4); -- WiFi, AC, Kitchen
-- Place 2: Luxury Penthouse
INSERT INTO place_amenity (place_id, amenity_id) VALUES (2, 1), (2, 2), (2, 3), (2, 5), (2, 6); -- WiFi, AC, Pool, Parking, Gym
-- Place 3: Modern Studio in Maitama
INSERT INTO place_amenity (place_id, amenity_id) VALUES (3, 1), (3, 2), (3, 4), (3, 5); -- WiFi, AC, Kitchen, Parking
-- Place 4: Family Home in Port Harcourt
INSERT INTO place_amenity (place_id, amenity_id) VALUES (4, 1), (4, 2), (4, 4), (4, 5); -- WiFi, AC, Kitchen, Parking
-- Place 5: Chic Apartment near Lekki Conservation
INSERT INTO place_amenity (place_id, amenity_id) VALUES (5, 1), (5, 2); -- WiFi, AC

