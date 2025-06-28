Entities and Their Attributes

Here are the identified entities with their attributes:

User

User_ID (Primary Key, Integer)

First_Name (String)

Last_Name (String)

Email (String, Unique)

Password_Hash (String)

Phone_Number (String, Optional)

Registration_Date (Date)

User_Type (String - e.g., 'Guest', 'Host', 'Admin')

Property

Property_ID (Primary Key, Integer)

Host_ID (Foreign Key to User.User_ID, Integer)

Title (String)

Description (Text)

Address (String)

City (String)

State (String)

Zip_Code (String)

Country (String)

Property_Type (String - e.g., 'Apartment', 'House', 'Villa')

Number_of_Bedrooms (Integer)

Number_of_Bathrooms (Integer)

Max_Guests (Integer)

Price_Per_Night (Decimal)

Availability_Status (Boolean - e.g., true for available, false for unavailable)

Date_Added (Date)

Booking

Booking_ID (Primary Key, Integer)

Guest_ID (Foreign Key to User.User_ID, Integer)

Property_ID (Foreign Key to Property.Property_ID, Integer)

Check_In_Date (Date)

Check_Out_Date (Date)

Total_Price (Decimal)

Booking_Status (String - e.g., 'Pending', 'Confirmed', 'Cancelled', 'Completed')

Booking_Date (Date)

Number_of_Guests (Integer)

Payment

Payment_ID (Primary Key, Integer)

Booking_ID (Foreign Key to Booking.Booking_ID, Integer, Unique - assuming one payment per booking)

Payment_Date (Date)

Amount (Decimal)

Payment_Method (String - e.g., 'Credit Card', 'PayPal')

Transaction_Status (String - e.g., 'Successful', 'Failed', 'Refunded')

Review

Review_ID (Primary Key, Integer)

Booking_ID (Foreign Key to Booking.Booking_ID, Integer, Unique - assuming one review per completed booking)

Guest_ID (Foreign Key to User.User_ID, Integer)

Property_ID (Foreign Key to Property.Property_ID, Integer)

Rating (Integer - e.g., 1-5)

Comment (Text, Optional)

Review_Date (Date)

Relationships Between Entities
Here are the relationships, including their cardinality and participation:

User (Host) to Property

Relationship Name: Manages / Hosts

Description: A User can host multiple Properties, but each Property is hosted by exactly one User.

Cardinality: One-to-Many (1:N)

User: 1 (One User can manage many Properties)

Property: N (Many Properties are managed by one User)

Participation:

User (Host): Optional (A User might not host any properties)

Property: Mandatory (Every Property must have a Host User)

Foreign Key: Property.Host_ID references User.User_ID

User (Guest) to Booking

Relationship Name: Makes

Description: A User can make multiple Bookings, but each Booking is made by exactly one User.

Cardinality: One-to-Many (1:N)

User: 1 (One User can make many Bookings)

Booking: N (Many Bookings are made by one User)

Participation:

User (Guest): Optional (A User might not make any bookings)

Booking: Mandatory (Every Booking must be associated with a Guest User)

Foreign Key: Booking.Guest_ID references User.User_ID

Property to Booking

Relationship Name: Is_Booked_For

Description: A Property can have multiple Bookings, and each Booking is for exactly one Property.

Cardinality: One-to-Many (1:N)

Property: 1 (One Property can be booked many times)

Booking: N (Many Bookings are for one Property)

Participation:

Property: Optional (A Property might not have any bookings yet)

Booking: Mandatory (Every Booking must be for a specific Property)

Foreign Key: Booking.Property_ID references Property.Property_ID

Booking to Payment

Relationship Name: Has / Is_Paid_By

Description: Each Booking has exactly one Payment associated with it, and each Payment is for exactly one Booking.

Cardinality: One-to-One (1:1)

Booking: 1 (One Booking has one Payment)

Payment: 1 (One Payment is for one Booking)

Participation:

Booking: Optional (A Booking might be pending payment, so payment is optional initially, but becomes mandatory upon confirmation)

Payment: Mandatory (Every Payment must be for a Booking)

Foreign Key: Payment.Booking_ID references Booking.Booking_ID (and should be unique in Payment table)

Booking to Review

Relationship Name: Generates / Is_Reviewed_Via

Description: A Booking can generate at most one Review, and each Review is for exactly one Booking.

Cardinality: One-to-One (1:1)

Booking: 1 (One Booking can have one Review)

Review: 1 (One Review is for one Booking)

Participation:

Booking: Optional (Not all bookings will result in a review)

Review: Mandatory (Every Review must be associated with a Booking)

Foreign Key: Review.Booking_ID references Booking.Booking_ID (and should be unique in Review table)

User (Guest) to Review

Relationship Name: Writes

Description: A User can write multiple Reviews, but each Review is written by exactly one User.

Cardinality: One-to-Many (1:N)

User: 1 (One User can write many Reviews)

Review: N (Many Reviews are written by one User)

Participation:

User (Guest): Optional (A User might not write any reviews)

Review: Mandatory (Every Review must be associated with a Guest User)

Foreign Key: Review.Guest_ID references User.User_ID

Property to Review

Relationship Name: Receives

Description: A Property can receive multiple Reviews, but each Review is for exactly one Property.

Cardinality: One-to-Many (1:N)

Property: 1 (One Property can receive many Reviews)

Review: N (Many Reviews are for one Property)

Participation:

Property: Optional (A Property might not have any reviews yet)

Review: Mandatory (Every Review must be for a specific Property)

Foreign Key: Review.Property_ID references Property.Property_ID
