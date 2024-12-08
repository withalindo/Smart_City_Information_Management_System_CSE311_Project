
CREATE DATABASE SCIMS;

USE SCIMS;
-- Citizen Registration Table
CREATE TABLE CitizenRegistration (
     Registration_ID VARCHAR(500) PRIMARY KEY,
    Full_Name VARCHAR(200) NOT NULL,
    Gender VARCHAR(10) CHECK (Gender IN ('Male', 'Female', 'Others')),
    Date_Of_Birth DATE NOT NULL,
    Address VARCHAR(300) NOT NULL,
    Contact_Number VARCHAR(15),
    Email VARCHAR(100) UNIQUE,
    National_ID VARCHAR(30) UNIQUE NOT NULL,
	Approval_Status VARCHAR(20) CHECK (Approval_Status IN ('Pending', 'Approved', 'Rejected')) DEFAULT 'Pending',
    Registration_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger
DELIMITER $$

CREATE TRIGGER After_Approval_Update
AFTER UPDATE ON CitizenRegistration
FOR EACH ROW
BEGIN
    IF NEW.Approval_Status = 'Approved' THEN
        INSERT INTO Citizen_Info (
            Citizen_ID, Name, Address, Contact_Number, Date_Of_Birth, Email, Gender, National_ID, City_Registration_Date
        )
        VALUES (
            NEW.Registration_ID, NEW.Full_Name, NEW.Address, NEW.Contact_Number, 
            NEW.Date_Of_Birth, NEW.Email, NEW.Gender, NEW.National_ID, NEW.Registration_Date
        )
        ON DUPLICATE KEY UPDATE
            Name = VALUES(Name),
            Address = VALUES(Address),
            Contact_Number = VALUES(Contact_Number),
            Email = VALUES(Email),
            Gender = VALUES(Gender),
            National_ID = VALUES(National_ID);
    END IF;
END$$

DELIMITER ;
-- Approval Querry
UPDATE CitizenRegistration
SET Approval_Status = 'Approved'
WHERE Registration_ID LIKE 'CIT%' AND National_ID LIKE '199%';
-- Rejection Querry
UPDATE CitizenRegistration
SET Approval_Status = 'Rejected'
WHERE Registration_ID LIKE 'CIT%' AND National_ID NOT LIKE '199%';

INSERT INTO CitizenRegistration (Registration_ID, Full_Name, Address, Contact_Number, Email, Gender, Date_of_Birth, National_ID, Registration_Date) 
VALUES
('CIT001', 'Professor Dr. Kamruddin Nur ', 'House: 91; Road:04; Block:B, Banani Dhaka-1213', '01777354323', 'kamruddin.nur@gmail.com', 'Male', '1998-10-18', '1997054672345', DEFAULT),
('CIT002', 'Hasnat Karibul Islam Alindo', 'House 526, Road 17, Block J, Bashundhara R/A', '01316619278', 'withalindo@gmail.com', 'Male', '2001-12-28', '1998034530678', DEFAULT), 
('CIT003', 'Md. Minhaujul Islam', 'House 257, Road 5, Block C, Bashundhara R/A', '01756619289', 'minhajulislamrimon28@gmail.com', 'Male', '2001-04-16', '1990027530526', DEFAULT),
('CIT004', 'Nur Ibne Kawsar Zitu', 'House 226, Road 5, Block C, Bashundhara R/A', '01712345670', 'nur.zitu@gmail.com', 'Male', '2000-11-15', '1990045530425', DEFAULT), 
('CIT005', 'Sabbir Hossain', 'House 126, Road 15, Block A, Bashundhara R/A', '01798766832', 'sabbirsts420@gmail.com', 'Male', '2000-04-09', '1990025530223', DEFAULT),
('CIT006', 'Sayed Mahi Ashrafi', 'House 26, Road 2, Block D, Nikunja R/A', '01798765432', 'syed.mahi@gmail.com', 'Male', '2001-09-17', '1990067530124', DEFAULT), 
('CIT007', 'Ivy Khan', 'House 427, Road 8, Block D, Bashundhara R/A', '01745678901', 'ivy.khan@gmail.com', 'Female', '2001-08-06', '1990024498128', DEFAULT),
('CIT008', 'Meher Easha', 'House 126, Road 8, Block C, Bashundhara R/A', '01711223344', 'emeherun@gmail.com', 'Female', '2001-08-15', '1990024530129', DEFAULT),
('CIT009', 'Md. Tanvir Hossain', 'House 15, Road 10, Gulshan 1, Dhaka', '01712345678', 'tanvir.hossain@gmail.com', 'Male', '1999-10-26', '1990024530123', DEFAULT),
('CIT010', 'Nasima Akhter', 'Flat 5C, Lakeview Apartments, Banani, Dhaka', '01812345679', 'nasima.akhter@yahoo.com', 'Female', '1999-05-18', '1990054525678', DEFAULT),
('CIT011', 'Shahriar Kabir', 'House 24, Road 8, Dhanmondi, Dhaka', '01912345670', 'shahriar.kabir@gmail.com', 'Male', '1990-08-26', '1998014530987', DEFAULT),
('CIT012', 'Ayesha Rahman', 'House 32, Sector 7, Uttara, Dhaka', '01798765432', 'ayesha.rahman@gmail.com', 'Female', '1996-01-26', '1995056783456', DEFAULT),
('CIT013', 'Md. Abir Hasan', 'House 18, Road 5, Mohammadpur, Dhaka', '01876543210', 'abir.hasan@outlook.com', 'Male', '1987-10-06', '1996034526789', DEFAULT),
('CIT014', 'Taslima Begum', 'Flat 4A, Green Plaza, Mirpur 12, Dhaka', '01745678901', 'taslima.begum@gmail.com', 'Female', '1975-10-26', '1993034786541', DEFAULT),
('CIT015', 'Khaled Mahmud', 'House 22, Bashundhara R/A, Block F, Dhaka', '01899887766', 'khaled.mahmud@gmail.com', 'Male', '1985-12-16', '1998012567894', DEFAULT),
('CIT016', 'Shivan Sharma', 'Flat No. 102, Block A, Greenwood Apartments, Sector 11, Dwarka, New Delhi- 110075 India', '01559887766', 'shivam.sharma@gmail.com', 'Male', '1985-12-16', '1988012567894', DEFAULT),
('CIT017', 'Raiyan Ahmed', 'House 22, Banasree, Block C, Dhaka', '014589887766', 'raiyan.ahmed@gmail.com', 'Male', '2010-12-16', '1998012567895', DEFAULT);

-- Citizen Table

CREATE TABLE Citizen_Info
(
    Citizen_ID 	VARCHAR(30) PRIMARY KEY,
    Name VARCHAR(200) NOT NULL,
	Address VARCHAR(300) NOT NULL,
    Contact_Number VARCHAR(15) NOT NULL,
    Date_Of_Birth DATE NOT NULL,
    Email VARCHAR(100) UNIQUE,
	Gender VARCHAR(10) CHECK (Gender IN ('Male', 'Female', 'Others')),
    National_ID VARCHAR(30) UNIQUE NOT NULL,
    City_Registration_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);



-- City_Official Table

CREATE TABLE City_Official (
    Official_ID VARCHAR(50) PRIMARY KEY,
    Citizen_ID VARCHAR(50),
    Name VARCHAR(100) NOT NULL,
    Department_ID VARCHAR(10) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    Phone_Number VARCHAR(15),
    Email VARCHAR(100),
    Years_Of_Service INT,
    Qualifications TEXT,
    Address TEXT,
    Supervisor_ID VARCHAR(50),
    FOREIGN KEY (Citizen_ID) REFERENCES Citizen_Info(Citizen_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (Supervisor_ID) REFERENCES City_Official(Official_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Department table
CREATE TABLE Department (
    Department_ID VARCHAR(10) PRIMARY KEY,
    Department_Name VARCHAR(100) NOT NULL,
    Head_Official_ID VARCHAR(50),
    Department_Budget DECIMAL(15, 2),
    Number_Of_Employees INT,
    Main_Responsibilities TEXT,
    Operating_Hours VARCHAR(50),
    FOREIGN KEY (Head_Official_ID) REFERENCES City_Official(Official_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Populating into City_Official

INSERT INTO City_Official (Citizen_ID, Official_ID, Name, Department_ID, Role, Phone_Number, Email, Years_Of_Service, Qualifications, Address, Supervisor_ID)
VALUES
('CIT001', 'CF1', 'Professor Dr. Kamruddin Nur', '1', 'City Mayor', '01777354323', 'kamruddin.nur@citygov.org', 15, 'PhD in Ubiquitous Computing', 'House: 91; Road:04; Block:B, Banani Dhaka-1213', NULL),
('CIT007', 'FIN001', 'Ivy Khan', '109', 'Department Head', '01316619278', 'ivy.khan@citygov.org', 10, 'PhD in Management AND HR', 'House 427, Road 8, Block D, Bashundhara R/A', 'CF1'),
('CIT012', 'FIN002', 'Ayesha Rahman', '109', 'Senior Officer', '01712345678', 'ayesha.rahman@citygov.org', 5, 'Masters in Urban Planning', 'House 32, Sector 7, Uttara, Dhaka', 'FIN001'),
('CIT002', 'DEF001', 'Hasnat Karibul Islam', '101', 'Department Head', '011316619278', 'hasnat.islam@citygov.org', 13, 'PhD in Molecular Engineering', 'House 526, Road 17, Block J, Bashundhara R/A', 'CF1'),
('CIT004', 'DEF002', 'Nur Ibne Kawsar Zitun', '101', 'Officer', '01876543210', 'nur.zitu@citygov.org', 3, 'MSc in Software Engineering', 'House 226, Road 5, Block C, Bashundhara R/A', 'DEF001'),
('CIT003', 'HLT001', 'Md. Minhajul Islam', '107', 'Department Head', '01756619289', 'minhajul.islam@citygov.org', 12, 'PhD in Pharmaceutical Science', 'House 257, Road 5, Block C, Bashundhara R/A', 'CF1'),
('CIT015', 'HLT002', 'Khaled Mahmud', '107', 'Senior Officer', '01899887766', 'khaled.mahmud@citygov.org', 12, 'Bachelor’s in Environmental Engineering', 'House 22, Bashundhara R/A, Block F, Dhaka', 'HLT001'),
('CIT006', 'EDU001', 'Sayed Mahi Ashrafi', '108', 'Department Head', '01711221122', 'mahi.ashrafi@citygov.org', 12, 'PhD in Education Management', 'House 26, Road 2, Block D, Nikunja R/A', 'CF1'),
('CIT008', 'EDU002', 'Meher Easha', '108', 'Officer', '01711223344', 'meher.easha@citygov.org', 6, 'Masters in Public Administration', 'House 126, Road 8, Block C, Bashundhara R/A', 'EDU001');


-- Populating Department table
INSERT INTO Department (Department_ID, Department_Name, Head_Official_ID, Department_Budget, Number_Of_Employees, Main_Responsibilities, Operating_Hours)
VALUES
('1', 'Department of Head of the city', 'CF1', 515000000, 900, 'Head of the City and Policy makers.', '24/7'),
('101', 'Public Safety', 'DEF001', 50000000, 120, 'Manage law enforcement, fire services, and public safety operations.', '24/7'),
('102', 'Infrastructure', 'CF1', 80000000, 150, 'Oversee construction, maintenance of roads, bridges, and public buildings.', '9:00 AM - 5:00 PM'),
('103', 'Transportation', 'CF1', 60000000, 100, 'Manage public transport systems, metro services, and traffic flow.', '6:00 AM - 11:00 PM'),
('104', 'Environment and Sanitation', 'CF1', 30000000, 80, 'Ensure waste management, clean water supply, and environmental health.', '8:00 AM - 6:00 PM'),
('105', 'Urban Planning', 'CF1', 45000000, 60, 'Plan and regulate land use, zoning, and urban development projects.', '9:00 AM - 5:00 PM'),
('106', 'Emergency Services', 'CF1', 70000000, 90, 'Respond to emergencies, manage disaster recovery, and medical aid.', '24/7'),
('107', 'Health and Welfare', 'HLT001', 55000000, 110, 'Provide health services, welfare programs, and public healthcare.', '9:00 AM - 5:00 PM'),
('108', 'Education and Community Services', 'EDU001', 40000000, 75, 'Oversee public schools, libraries, and community programs.', '8:00 AM - 6:00 PM'),
('109', 'Finance and Budget', 'FIN001', 20000000, 50, 'Manage city finances, budgets, and tax collection.', '9:00 AM - 5:00 PM'),
('110', 'Technology and Innovation', 'CF1', 65000000, 40, 'Develop and manage city tech infrastructure and smart city initiatives.', '9:00 AM - 6:00 PM');

ALTER TABLE City_Official
ADD CONSTRAINT FK_Department_ID
FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- Public Services Table

CREATE TABLE Public_Services (
    Service_ID VARCHAR(30) PRIMARY KEY, -- Unique identifier for each public service
    Department_ID VARCHAR(10), -- Links to the Department table
    Service_Type VARCHAR(100) NOT NULL, -- Type of service (e.g., Waste Management, Fire Safety)
    Service_Description TEXT, -- Detailed description of the service
    Availability_Status VARCHAR(20) CHECK (Availability_Status IN ('Available', 'Unavailable')), -- Service availability status
    Average_Response_Time DECIMAL(5, 2), -- Average time taken to respond in hours (e.g., 1.50 for 1 hour 30 minutes)
    Service_Fee DECIMAL(10, 2) DEFAULT 0.00, -- Fee for the service (if applicable)
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- Populating Public_Services Table

INSERT INTO Public_Services (Service_ID, Department_ID, Service_Type, Service_Description, Availability_Status, Average_Response_Time, Service_Fee)
VALUES
('PS001', '101', 'Emergency Rescue', 'Provide immediate rescue operations during natural disasters and accidents.', 'Available', 0.33, 0.00),
('PS002', '102', 'Bridge Inspection', 'Conduct routine inspections and maintenance of city bridges.', 'Available', 72.00, 0.00),
('PS003', '103', 'Traffic Management', 'Monitor and regulate traffic flow across the city.', 'Available', 0.25, 0.00),
('PS004', '104', 'Water Quality Monitoring', 'Test and ensure safe drinking water supply to households.', 'Unavailable', NULL, 200.00),
('PS005', '105', 'Urban Redevelopment', 'Plan and execute redevelopment projects in underutilized areas.', 'Available', 96.00, 10000.00),
('PS006', '106', 'Disaster Recovery', 'Coordinate recovery efforts after major disasters.', 'Available', 2.00, 0.00),
('PS007', '107', 'Vaccination Programs', 'Administer free vaccines for common diseases.', 'Available', 0.50, 0.00),
('PS008', '108', 'Library Membership', 'Provide access to public libraries and online resources.', 'Available', 0.08, 500.00),
('PS009', '109', 'Tax Consultation', 'Assist citizens in calculating and paying city taxes.', 'Available', 0.08, 10000.00),
('PS010', '110', 'Wi-Fi Services', 'Offer free public Wi-Fi in selected urban zones.', 'Available', 0.17, 500.00);

INSERT INTO Feedback (Feedback_ID, Citizen_ID, Service_ID, Assigned_Official_ID, Feedback_Date, Feedback_Type, Description, Rating, Resolved_Status, Resolution_Date)
VALUES
('FB001', 'CIT001', 'PS001', 'DEF002', '2024-12-01', 'Complaint', 'The service was delayed.', 2.0, 0, NULL),
('FB002', 'CIT002', 'PS002', 'CF1', '2024-12-02', 'Praise', 'The officer was very helpful and efficient.', 5.0, 1, '2024-12-02'),
('FB003', 'CIT003', 'PS003', 'CF1', '2024-12-03', 'Suggestion', 'Consider extending service hours to weekends.', 4.0, 0, NULL),
('FB004', 'CIT004', 'PS004', 'CF1', '2024-12-04', 'Complaint', 'Difficulties in reaching support during emergencies.', 3.0, 0, NULL),
('FB005', 'CIT005', 'PS005', 'CF1', '2024-12-05', 'Praise', 'Prompt response and excellent resolution.', 5.0, 1, '2024-12-05'),
('FB006', 'CIT006', 'PS006', 'CF1', '2024-12-06', 'Complaint', 'Response time could be improved.', 3.5, 0, NULL),
('FB007', 'CIT007', 'PS007', 'HLT002', '2024-12-07', 'Praise', 'Vaccination service was very organized.', 5.0, 1, '2024-12-07'),
('FB008', 'CIT008', 'PS008', 'EDU002', '2024-12-08', 'Suggestion', 'Consider reducing the membership fee.', 4.5, 0, NULL),
('FB009', 'CIT009', 'PS009', 'FIN002', '2024-12-09', 'Complaint', 'Tax consultation fee is too high.', 2.0, 0, NULL),
('FB010', 'CIT010', 'PS010', 'CF1', '2024-12-10', 'Praise', 'Wi-Fi service is fast and reliable.', 5.0, 1, '2024-12-10');




INSERT INTO Service_Request (Request_ID, Citizen_ID, Service_ID, Request_Date, Request_Status, Assigned_Official_ID, Request_Description, Completion_Date)
VALUES
('REQ001', 'CIT005', 'PS001', '2024-12-01', 'Pending', 'CF1', 'Need immediate rescue operations after flood damage.', NULL),
('REQ002', 'CIT015', 'PS002', '2024-12-02', 'In Progress', 'DEF002', 'Routine inspection for bridge maintenance.', NULL),
('REQ003', 'CIT014', 'PS003', '2024-12-03', 'Completed', 'CF1', 'Traffic signal repair in downtown area.', '2024-12-05'),
('REQ004', 'CIT012', 'PS004', '2024-12-04', 'Rejected', 'CF1', 'Water quality testing for municipal supply.', NULL),
('REQ005', 'CIT005', 'PS005', '2024-12-05', 'Pending', 'CF1', 'Urban redevelopment planning for old city blocks.', NULL),
('REQ006', 'CIT006', 'PS006', '2024-12-06', 'In Progress', 'CF1', 'Assistance required for disaster recovery.', NULL),
('REQ007', 'CIT007', 'PS007', '2024-12-07', 'Completed', 'HLT002', 'Vaccination program support for school children.', '2024-12-08'),
('REQ008', 'CIT008', 'PS008', '2024-12-08', 'Pending', 'EDU002', 'Library membership application.', NULL),
('REQ009', 'CIT009', 'PS009', '2024-12-09', 'Rejected', 'FIN002', 'Tax consultation regarding new property.', NULL),
('REQ010', 'CIT010', 'PS010', '2024-12-10', 'Completed', 'CF1', 'Wi-Fi service setup in urban zone.', '2024-12-12');


-- Location Table
CREATE TABLE Location (
    Location_ID VARCHAR(50) PRIMARY KEY, -- Unique identifier for the location
    Location_Name VARCHAR(100) NOT NULL, -- Name of the location
    Location_Type VARCHAR(50) CHECK (Location_Type IN ('Residential', 'Commercial', 'Industrial', 'Mixed-Use','Heritage')), -- Type of area
    City VARCHAR(50) NOT NULL, -- City name
    Region VARCHAR(50) NOT NULL, -- Region or division
    Postal_Code VARCHAR(10), -- Postal or ZIP code
    Additional_Info TEXT -- Any additional details about the location  
);

-- Populating Location Table

INSERT INTO Location (Location_ID, Location_Name, Location_Type, City, Region, Postal_Code, Additional_Info)
VALUES
('DHAKA1', 'Gulshan', 'Residential', 'Dhaka', 'Dhaka North', '1212', 'High-end residential area with embassies.'),
('DHAKA2', 'Banani', 'Mixed-Use', 'Dhaka', 'Dhaka North', '1213', 'Popular for both residential and commercial spaces.'),
('DHAKA3', 'Dhanmondi', 'Residential', 'Dhaka', 'Dhaka South', '1209', 'Known for educational institutions and lakes.'),
('DHAKA4', 'Motijheel', 'Commercial', 'Dhaka', 'Dhaka South', '1000', 'Central business district of Dhaka.'),
('DHAKA5', 'Old Dhaka', 'Heritage', 'Dhaka', 'Dhaka South', '1100', 'Historic area with narrow streets and Mughal-era buildings.'),
('DHAKA6', 'Uttara', 'Residential', 'Dhaka', 'Dhaka North', '1230', 'A planned residential area near the airport.'),
('DHAKA7', 'Mirpur', 'Residential', 'Dhaka', 'Dhaka North', '1216', 'Famous for the National Zoo and Sher-e-Bangla Stadium.'),
('DHAKA8', 'Baridhara', 'Residential', 'Dhaka', 'Dhaka North', '1212', 'Diplomatic area housing embassies and high-end residences.'),
('DHAKA9', 'Mohakhali', 'Commercial', 'Dhaka', 'Dhaka North', '1212', 'Hub for hospitals and pharmaceutical companies.'),
('DHAKA0', 'Paltan', 'Commercial', 'Dhaka', 'Dhaka South', '1000', 'Known for political rallies and trade centers.'),
('DHAKA11', 'Bashundhara Residential Area', 'Mixed-Use', 'Dhaka', 'Dhaka North', '1229', 'Developed area with residential and commercial zones.'),
('DHAKA12', 'Tejgaon', 'Industrial', 'Dhaka', 'Dhaka North', '1215', 'Prominent industrial area with TV stations.'),
('DHAKA13', 'Farmgate', 'Mixed-Use', 'Dhaka', 'Dhaka North', '1215', 'Busy commercial hub with schools and offices.'),
('DHAKA14', 'Shyamoli', 'Residential', 'Dhaka', 'Dhaka North', '1207', 'Area with parks and affordable housing.'),
('DHAKA15', 'Keraniganj', 'Industrial', 'Dhaka', 'Dhaka South', '1310', 'Known for the garment industry and factories.'),
('DHAKA16', 'Jatrabari', 'Commercial', 'Dhaka', 'Dhaka South', '1204', 'Busy area known for transportation hubs.'),
('DHAKA17', 'Khilgaon', 'Mixed-Use', 'Dhaka', 'Dhaka South', '1219', 'Residential area with growing commercial zones.'),
('DHAKA18', 'Rampura', 'Residential', 'Dhaka', 'Dhaka South', '1219', 'Area with television studios and middle-class housing.'),
('DHAKA19', 'Savar', 'Industrial', 'Dhaka', 'Dhaka North', '1340', 'Home to EPZ and garment industries.'),
('DHAKA20', 'Aminbazar', 'Mixed-Use', 'Dhaka', 'Dhaka North', '1348', 'Growing urban area near Savar.'),
('DHAKA21', 'Kamalapur', 'Commercial', 'Dhaka', 'Dhaka South', '1223', 'Location of the central railway station of Dhaka.'),
('DHAKA22', 'Green Road', 'Residential', 'Dhaka', 'Dhaka South', '1205', 'Popular area for middle-class residences and medical facilities.'),
('DHAKA23', 'Malibagh', 'Mixed-Use', 'Dhaka', 'Dhaka South', '1217', 'Busy area with shopping malls and apartments.'),
('DHAKA24', 'Lalbagh', 'Heritage', 'Dhaka', 'Dhaka South', '1211', 'Famous for Lalbagh Fort, a Mughal-era monument.'),
('DHAKA25', 'Hatirjheel', 'Mixed-Use', 'Dhaka', 'Dhaka North', '1212', 'Urban development project with recreational spaces.'),
('DHAKA26', 'Khilkhet', 'Residential', 'Dhaka', 'Dhaka North', '1229', 'A growing suburban area near Bashundhara.'),
('DHAKA27', 'Turag', 'Residential', 'Dhaka', 'Dhaka North', '1711', 'Located near the river, with increasing residential projects.'),
('DHAKA28', 'Banasree', 'Residential', 'Dhaka', 'Dhaka South', '1219', 'Planned housing area ideal for families.'),
('DHAKA29', 'Agargaon', 'Mixed-Use', 'Dhaka', 'Dhaka North', '1207', 'Home to government offices and IT parks.'),
('DHAKA30', 'Ashulia', 'Industrial', 'Dhaka', 'Dhaka North', '1341', 'Key industrial hub for garments and manufacturing.');


-- Citizen_Location Table

CREATE TABLE Citizen_Location (
    Citizen_ID VARCHAR(30),
    Location_ID VARCHAR(50),
    PRIMARY KEY (Citizen_ID, Location_ID),
    FOREIGN KEY (Citizen_ID) REFERENCES Citizen_Info(Citizen_ID) ON DELETE CASCADE,
    FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID) ON DELETE CASCADE
);

-- Populating Citizen_Location Table


INSERT INTO Citizen_Location (Citizen_ID, Location_ID)
VALUES
    ('CIT001', 'DHAKA2'), 
    ('CIT002', 'DHAKA11'), 
    ('CIT003', 'DHAKA11'), 
    ('CIT004', 'DHAKA11'),
    ('CIT005', 'DHAKA11'), 
    ('CIT006', 'DHAKA26'), 
    ('CIT007', 'DHAKA11'), 
    ('CIT008', 'DHAKA11'), 
    ('CIT009', 'DHAKA1'), 
    ('CIT010', 'DHAKA12'), 
	('CIT011', 'DHAKA3'),
    ('CIT012','DHAKA6'), 
    ('CIT013', 'DHAKA14'), 
    ('CIT014', 'DHAKA7'),
    ('CIT015', 'DHAKA11'); 

-- Testing and debugging Purpose
SELECT CL.Citizen_ID, CI.Name, CL.Location_ID, L.Location_Name, L.Location_ID
FROM Citizen_Location CL JOIN Citizen_Info CI ON CL.Citizen_ID = CI.Citizen_ID JOIN Location L 
ON CL.Location_ID = L.Location_ID;

-- Weather_Condition_Data Table

CREATE TABLE Weather_Condition_Data (
    Weather_ID VARCHAR(50) PRIMARY KEY ,       -- Unique identifier for each weather record
    Location_ID VARCHAR(50) NOT NULL,                        -- Foreign key linking to the Location table
    Observation_Date DATE NOT NULL,                  -- Date of the weather observation
    Temperature DECIMAL(5, 2) NOT NULL,              -- Temperature in Celsius (or desired unit)
    Humidity INT CHECK (Humidity BETWEEN 0 AND 100), -- Humidity percentage (0-100)
    Weather_Condition VARCHAR(50) CHECK (
	Weather_Condition IN ('Sunny', 'Rainy', 'Cloudy', 'Stormy', 'Windy', 'Foggy')),      -- General weather description
    Wind_Speed DECIMAL(5, 2),                        -- Wind speed in km/h (or desired unit)
    Additional_Info TEXT,                            -- Additional details about the weather
    FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
-- Populating Weather_Condition_Data Table

INSERT INTO Weather_Condition_Data (Weather_ID, Location_ID, Observation_Date, Temperature, Humidity, Weather_Condition, Wind_Speed, Additional_Info)
VALUES
('W001', 'DHAKA1', '2024-12-01', 25.50, 60, 'Sunny', 15.20, 'Clear sky with mild breeze'),
('W002', 'DHAKA2', '2024-12-01', 22.30, 80, 'Rainy', 10.50, 'Light rain in the morning'),
('W003', 'DHAKA3', '2024-12-01', 30.10, 50, 'Cloudy', 12.40, 'Overcast skies throughout the day'),
('W004', 'DHAKA4', '2024-12-01', 18.70, 85, 'Stormy', 45.00, 'Heavy rain and strong winds'),
('W005', 'DHAKA5', '2024-12-01', 15.50, 90, 'Foggy', 5.00, 'Low visibility in the early morning'),
('W006', 'DHAKA6', '2024-12-01', 28.80, 70, 'Windy', 25.80, 'Strong gusts in the afternoon'),
('W007', 'DHAKA7', '2024-12-01', 12.30, 95, 'Foggy', 8.20, 'Light rainfall overnight'),
('W008', 'DHAKA8', '2024-12-01', 29.90, 55, 'Sunny', 18.50, 'Warm day with a clear sky'),
('W009', 'DHAKA9', '2024-12-01', 21.40, 75, 'Rainy', 9.30, 'Drizzle during the evening'),
('W010', 'DHAKA0', '2024-12-01', 26.00, 65, 'Cloudy', 11.00, 'Partly cloudy with no precipitation'),
('W011', 'DHAKA11', '2024-12-02', 24.80, 68, 'Sunny', 14.20, 'Moderate temperatures with clear skies'),
('W012', 'DHAKA12', '2024-12-02', 20.50, 85, 'Rainy', 8.70, 'Rain showers expected in the afternoon'),
('W013', 'DHAKA13', '2024-12-02', 31.00, 45, 'Cloudy', 13.50, 'Hot day with occasional clouds'),
('W014', 'DHAKA14', '2024-12-02', 17.00, 90, 'Foggy', 6.00, 'Dense fog in the early hours'),
('W015', 'DHAKA15', '2024-12-02', 27.50, 60, 'Windy', 22.40, 'Breezy conditions throughout the day'),
('W016', 'DHAKA16', '2024-12-02', 16.50, 95, 'Cloudy', 10.00, 'Rainfall with high humidity'),
('W017', 'DHAKA17', '2024-12-02', 29.20, 58, 'Sunny', 16.80, 'Clear day with moderate wind'),
('W018', 'DHAKA18', '2024-12-02', 22.70, 80, 'Rainy', 7.60, 'Intermittent rain with cool temperatures'),
('W019', 'DHAKA19', '2024-12-02', 25.30, 70, 'Cloudy', 12.00, 'Cloudy skies with mild humidity'),
('W020', 'DHAKA20', '2024-12-02', 30.50, 50, 'Sunny', 20.30, 'Hot and sunny day with clear skies');

-- Infrustructure  Maintainance Table

CREATE TABLE Infrastructure_Maintenance (
    Maintenance_ID VARCHAR(50) PRIMARY KEY, -- Unique identifier for each maintenance record
    Location_ID VARCHAR(50) NOT NULL, -- Foreign key referencing the Location table
    Department_ID VARCHAR(50),
    Maintenance_Type VARCHAR(100) NOT NULL, -- Type of maintenance (e.g., Road Repair, Utility Maintenance)
    Start_Date DATE NOT NULL, -- Start date of the maintenance work
    End_Date DATE, -- End date of the maintenance work (can be NULL if ongoing)
    Status VARCHAR(50) CHECK (Status IN ('Planned', 'Ongoing', 'Completed')) DEFAULT 'Planned', 
    Cost DECIMAL(15,2), -- Cost of maintenance (optional)
    Contractor_Name VARCHAR(100), -- Name of the contractor or company handling the maintenance
    Additional_Info TEXT, -- Any additional details about the maintenance work
    FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID) ON DELETE CASCADE ON UPDATE CASCADE,
       FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)ON DELETE CASCADE ON UPDATE CASCADE
);

-- Populating Infrustructure_Maintenance Table

INSERT INTO Infrastructure_Maintenance (Maintenance_ID, Location_ID, Department_ID, Maintenance_Type, Start_Date, End_Date, Status, Cost, Contractor_Name, Additional_Info
) VALUES
('M001', 'DHAKA1', '103', 'Gulshan Link Road Repair', '2024-01-01', '2024-01-10', 'Completed', 15000.00, 'Abdul Momen Contractors', 'Repair of potholes on Main Street.'),
('M002', 'DHAKA2', '109', 'Bank Building Maintainance', '2024-12-15', NULL, 'Ongoing', 20000.00, '24th Army Brigade ', 'Upgrading and maitainance of the diffected bank building.'),
('M004', 'DHAKA11', '102', 'Bridge Inspection', '2024-03-01', '2024-03-05', 'Completed', 5000.00, 'BridgeCo Inspections', 'Annual safety inspection of the River Bridge.'),
('M005', 'DHAKA9', '109', 'Hospital building repair', '2024-03-10', NULL, 'Planned', 3000.00, 'Abdul Momen Group', 'ICDDRB building repair.'),
('M006', 'DHAKA9', NULL, 'Park Renovation', '2024-01-20', '2024-02-20', 'Completed', 25000.00, 'Green Earth Landscaping', 'Renovation of the central park with new pathways and landscaping.');

-- Bus_Trasportation Table

CREATE TABLE Bus_Transportation  (
    Bus_ID VARCHAR(30) PRIMARY KEY ,
    Route_Name VARCHAR(50) NOT NULL, 
    Start_Location_ID VARCHAR(50),
    End_Location_ID VARCHAR(50),
    Number_Of_Stations INT NOT NULL, 
    Frequency_Per_Hour INT NOT NULL, 
	status ENUM('On Time', 'Delayed', 'Cancelled') DEFAULT 'On Time', 
    FOREIGN KEY (Start_Location_ID) REFERENCES Location(Location_ID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (End_Location_ID) REFERENCES Location(Location_ID)ON DELETE CASCADE ON UPDATE CASCADE
);

-- Populating Bus_Trasportation Table

INSERT INTO Bus_Transportation (Bus_ID, Route_Name, Start_Location_ID, End_Location_ID, Number_Of_Stations, Frequency_Per_Hour, status)
VALUES
('Green Dhaka', 'Route A', 'DHAKA1', 'DHAKA0', 15, 6, 'On Time'),
('Torongo Paribahan', 'Route B', 'DHAKA2', 'DHAKA11', 12, 5, 'Delayed'),
('Sikhor Paribhan', 'Route C', 'DHAKA3', 'DHAKA12', 10, 4, 'On Time'),
('Ashin Paribahan', 'Route D', 'DHAKA4', 'DHAKA13', 18, 7, 'Cancelled'),
('Dhakar Chaka', 'Route E', 'DHAKA5', 'DHAKA14', 20, 8, 'On Time'),
('Victor Classic', 'Route F', 'DHAKA6', 'DHAKA15', 8, 3, 'Delayed'),
('Projapoti Paribahan', 'Route G', 'DHAKA7', 'DHAKA16', 25, 10, 'On Time'),
('Anabil Paribahan', 'Route H', 'DHAKA8', 'DHAKA17', 14, 6, 'On Time'),
('Retro Paribahan', 'Route I', 'DHAKA9', 'DHAKA18', 9, 4, 'Cancelled'),
('Azam Paribahan', 'Route J', 'DHAKA0', 'DHAKA19', 16, 5, 'On Time');

-- IoT_Devices Table    
    CREATE TABLE IoT_Devices (
    Device_ID VARCHAR(30) PRIMARY KEY ,
    Device_Type VARCHAR(100) NOT NULL,
    Department_ID VARCHAR(10) NOT NULL,
    Location_ID VARCHAR(50) NOT NULL,
    Installation_Date DATE NOT NULL,
    Device_Status VARCHAR(50) NOT NULL,
    Last_Communication_Timestamp DATETIME NOT NULL,
    Manufacturer VARCHAR(100),
    Battery_Status VARCHAR(50),
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID),
    FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID)
);

-- Populating IoT_Devices Table
INSERT INTO IoT_Devices (Device_ID, Device_Type, Department_ID, Location_ID, Installation_Date, Device_Status, Last_Communication_Timestamp, Manufacturer, Battery_Status)
VALUES
    ('SENSOR001', 'Temperature Sensor', '104', 'DHAKA1', '2023-01-15', 'Active', '2024-12-07 14:20:00', 'SensTech', '85%'),
    ('SENSOR002', 'Humidity Sensor', '104', 'DHAKA2', '2023-02-20', 'Active', '2024-12-07 14:25:00', 'WeatherPro', '78%'),
    ('SENSOR003', 'Air Quality Monitor', '104', 'DHAKA3', '2023-03-10', 'Inactive', '2024-12-07 13:50:00', 'EnviroCheck', 'Battery Low'),
    ('SENSOR004', 'Water Level Sensor', '104', 'DHAKA4', '2023-04-05', 'Active', '2024-12-07 14:30:00', 'AquaSense', '92%'),
    ('SENSOR005', 'Motion Detector', '110', 'DHAKA5', '2023-05-12','Active', '2024-12-07 14:15:00', 'SecureIt', '80%'),
    ('SENSOR006', 'Pressure Sensor', '110', 'DHAKA6', '2023-06-08','Active', '2024-12-07 14:10:00', 'PressurTech', '75%'),
    ('SENSOR007', 'Proximity Sensor', '110', 'DHAKA7', '2023-07-14', 'Inactive', '2024-12-06 18:45:00', 'ProxiMatic', '60%'),
    ('SENSOR008', 'Light Intensity Sensor', '110', 'DHAKA8', '2023-08-01', 'Active', '2024-12-07 14:00:00', 'BrightSense', '90%'),
    ('SENSOR009', 'Sound Level Sensor', '110', 'DHAKA9', '2023-09-19', 'Active', '2024-12-07 13:55:00', 'AcoustiCare', '82%'),
    ('SENSOR010', 'Gas Leak Detector', '101', 'DHAKA0', '2023-10-25', 'Active', '2024-12-07 14:05:00', 'SafeGasTech', '88%'),
    ('SENSOR011', 'Infrared Sensor', '104', 'DHAKA11', '2023-11-11', 'Active', '2024-12-07 14:40:00', 'IRMax', '95%'),
    ('SENSOR012', 'UV Index Sensor', '110', 'DHAKA12', '2023-12-02', 'Inactive', '2024-12-06 15:20:00', 'UltraSafe', 'Battery Low'),
    ('SENSOR013', 'Vibration Sensor', '110', 'DHAKA13', '2023-01-28', 'Active', '2024-12-07 14:50:00', 'VibraTech', '70%'),
    ('SENSOR014', 'Smoke Detector', '104', 'DHAKA14', '2023-02-16', 'Inactive', '2024-12-06 17:30:00', 'FireSecure', 'Low Battery'),
    ('SENSOR015', 'Flood Sensor', '104', 'DHAKA15', '2023-03-05', 'Active', '2024-12-07 14:35:00', 'FloodGuard', '85%'),
    ('SENSOR016', 'GPS Tracker', '110', 'DHAKA16', '2023-04-20', 'Active', '2024-12-07 14:45:00', 'GeoLocator', '77%'),
    ('SENSOR017', 'Barcode Scanner', '110', 'DHAKA17', '2023-05-30', 'Active', '2024-12-07 13:50:00', 'ScanTech', '90%'),
    ('SENSOR018', 'RFID Sensor', '110', 'DHAKA18', '2023-06-25', 'Active', '2024-12-07 14:55:00', 'IDSecure', 'Battery Full'),
    ('SENSOR019', 'Magnetometer', '110', 'DHAKA19', '2023-07-10', 'Active', '2024-12-07 13:45:00', 'MagSense', '85%'),
    ('SENSOR020', 'Energy Meter', '110', 'DHAKA20', '2023-08-15', 'Active', '2024-12-07 14:10:00', 'EnerTech', '88%'),
    ('SENSOR021','Traffic Sensor', 103, 'DHAKA1', '2023-01-15', 'Active', '2024-11-01 08:00:00', 'SensorTech', '80%'),
    ('SENSOR022','Traffic Sensor', 103, 'DHAKA2', '2023-02-10', 'Active', '2024-11-01 09:00:00', 'SensorTech', '65%'),
    ('SENSOR023','Traffic Sensor', 103, 'DHAKA3', '2023-03-05', 'Active', '2024-11-01 07:45:00', 'SensorTech', '62%'),
    ('SENSOR024','Traffic Sensor', 103, 'DHAKA4', '2023-04-20', 'Active', '2024-11-01 10:15:00', 'SensorTech', '68%'),
    ('SENSOR025','Traffic Sensor', 103, 'DHAKA5', '2023-05-10', 'Active', '2024-11-01 11:00:00', 'SensorTech', '54%'),
    ('SENSOR026','Traffic Sensor', 103, 'DHAKA6', '2023-06-15', 'Active', '2024-11-01 06:30:00', 'SensorTech', '59%'),
    ('SENSOR027','Traffic Sensor', 103, 'DHAKA7', '2023-07-25', 'Active', '2024-11-01 17:00:00', 'SensorTech', '5%'),
    ('SENSOR028','Traffic Sensor', 103, 'DHAKA8', '2023-08-30', 'Active', '2024-11-01 12:30:00', 'SensorTech', '45%'),
    ('SENSOR029','Traffic Sensor', 103, 'DHAKA8', '2023-09-15', 'Active', '2024-11-01 18:45:00', 'SensorTech', '95%'),
    ('SENSOR030','Traffic Sensor', 103, 'DHAKA9', '2023-10-10', 'Active', '2024-11-01 05:30:00', 'SensorTech', '100%'),
    ('SENSOR031','Traffic Sensor', 103, 'DHAKA0', '2023-01-15', 'Active', '2024-11-01 08:00:00', 'SensorTech', '75%'),
    ('SENSOR032','Traffic Sensor', 103, 'DHAKA11', '2023-02-10', 'Active', '2024-11-01 09:00:00', 'SensorTech', '49%'),
    ('SENSOR033','Traffic Sensor', 103, 'DHAKA12', '2023-03-05', 'Active', '2024-11-01 07:45:00', 'SensorTech', '69%'),
    ('SENSOR034','Traffic Sensor', 103, 'DHAKA13', '2023-04-20', 'Active', '2024-11-01 10:15:00', 'SensorTech', '90%'),
    ('SENSOR035','Traffic Sensor', 103, 'DHAKA14', '2023-05-10', 'Active', '2024-11-01 11:00:00', 'SensorTech', '58%'),
    ('SENSOR036','Traffic Sensor', 103, 'DHAKA15', '2023-06-15', 'Active', '2024-11-01 06:30:00', 'SensorTech', '64%'),
    ('SENSOR037','Traffic Sensor', 103, 'DHAKA16', '2023-07-25', 'Active', '2024-11-01 17:00:00', 'SensorTech', '45%'),
    ('SENSOR038','Traffic Sensor', 103, 'DHAKA17', '2023-08-30', 'Active', '2024-11-01 12:30:00', 'SensorTech', '55%'),
    ('SENSOR039','Traffic Sensor', 103, 'DHAKA18', '2023-09-15', 'Active', '2024-11-01 18:45:00', 'SensorTech', '25%'),
    ('SENSOR040','Traffic Sensor', 103, 'DHAKA19', '2023-10-10', 'Active', '2024-11-01 05:30:00', 'SensorTech', '49%'),
    ('SENSOR041','Traffic Sensor', 103, 'DHAKA20', '2023-09-15', 'Active', '2024-11-01 18:45:00', 'SensorTech', '56%'),
    ('SENSOR042','Traffic Sensor', 103, 'DHAKA19', '2023-10-10', 'Active', '2024-11-01 05:30:00', 'SensorTech', '79%');

select*
FROM IoT_Devices;

-- Traffic_Data Table
CREATE TABLE Traffic_Data (
    Traffic_ID VARCHAR(50) PRIMARY KEY,
    Location_ID VARCHAR(50) NOT NULL,
    Device_ID VARCHAR(30) NOT NULL,
    Vehicle_Count INT,
    Average_Speed DECIMAL(5, 2),
    Accident_Reports INT,
    Congestion_Level VARCHAR(50),
    Timestamp DATETIME NOT NULL,
    FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID),
    FOREIGN KEY (Device_ID) REFERENCES IoT_Devices(Device_ID)
);

-- Populating Traffic_Data Table
INSERT INTO Traffic_Data (Traffic_ID, Location_ID, Device_ID, Vehicle_Count, Average_Speed, Accident_Reports, Congestion_Level, Timestamp)
VALUES
    ('T001', 'DHAKA1', 'SENSOR021', 120, 45.50, 1, 'Moderate', '2024-12-07 15:00:00'),
    ('T002', 'DHAKA2', 'SENSOR022', 200, 40.30, 0, 'High', '2024-12-07 15:05:00'),
    ('T003', 'DHAKA3', 'SENSOR023', 50, 55.20, 0, 'Low', '2024-12-07 15:10:00'),
    ('T004', 'DHAKA4', 'SENSOR024', 80, 35.10, 2, 'High', '2024-12-07 15:15:00'),
    ('T005', 'DHAKA5', 'SENSOR025', 150, 42.80, 0, 'Moderate', '2024-12-07 15:20:00'),
    ('T006', 'DHAKA6', 'SENSOR026', 90, 48.60, 1, 'Moderate', '2024-12-07 15:25:00'),
    ('T007', 'DHAKA7', 'SENSOR027', 110, 50.40, 0, 'Moderate', '2024-12-07 15:30:00'),
    ('T008', 'DHAKA8', 'SENSOR028', 180, 38.70, 1, 'High', '2024-12-07 15:35:00'),
    ('T009', 'DHAKA9', 'SENSOR029', 70, 60.10, 0, 'Low', '2024-12-07 15:40:00'),
    ('T010', 'DHAKA0', 'SENSOR030', 130, 43.90, 3, 'High', '2024-12-07 15:45:00'),
    ('T011', 'DHAKA11', 'SENSOR031', 100, 47.30, 0, 'Moderate', '2024-12-07 15:50:00'),
    ('T012', 'DHAKA12', 'SENSOR032', 60, 53.40, 1, 'Low', '2024-12-07 15:55:00'),
    ('T013', 'DHAKA13', 'SENSOR033', 140, 41.80, 2, 'High', '2024-12-07 16:00:00'),
    ('T014', 'DHAKA14', 'SENSOR034', 220, 35.60, 3, 'High', '2024-12-07 16:05:00'),
    ('T015', 'DHAKA15', 'SENSOR035', 90, 50.90, 0, 'Moderate', '2024-12-07 16:10:00'),
    ('T016', 'DHAKA16', 'SENSOR036', 180, 42.30, 0, 'Moderate', '2024-12-07 16:15:00'),
    ('T017', 'DHAKA17', 'SENSOR037', 120, 48.70, 1, 'Moderate', '2024-12-07 16:20:00'),
    ('T018', 'DHAKA18', 'SENSOR038', 110, 49.10, 0, 'Moderate', '2024-12-07 16:25:00'),
    ('T019', 'DHAKA19', 'SENSOR039', 160, 40.20, 2, 'High', '2024-12-07 16:30:00'),
    ('T020', 'DHAKA20', 'SENSOR040', 130, 44.60, 0, 'Moderate', '2024-12-07 16:35:00');

-- select*
-- from traffic_data;
-- Utility_Monitoring Table

CREATE TABLE Utility_Monitoring (
    Utility_ID VARCHAR(50) PRIMARY KEY,
    Location_ID VARCHAR(30) NOT NULL,
    Utility_Type VARCHAR(50) NOT NULL,
    Consumption DECIMAL(10, 2) NOT NULL,
    Provider VARCHAR(100) NOT NULL,
    Timestamp DATETIME NOT NULL,
    Cost_Per_Unit DECIMAL(10, 2) NOT NULL,
    Peak_Consumption_Period VARCHAR(50),
    Device_ID VARCHAR(30) NOT NULL,
    FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID),
    FOREIGN KEY (Device_ID) REFERENCES IoT_Devices(Device_ID)
);

-- Populating Utility_Monitoring Table

INSERT INTO Utility_Monitoring (Utility_ID, Location_ID, Utility_Type, Consumption, Provider, Timestamp, Cost_Per_Unit, Peak_Consumption_Period, Device_ID)
VALUES
    ('U001', 'DHAKA1', 'Electricity', 1200.50, 'PowerGrid Ltd.', '2024-12-07 16:00:00', 5.20, '08:00-10:00', 'SENSOR001'),
    ('U002', 'DHAKA2', 'Water', 800.00, 'WaterSupply Co.', '2024-12-07 16:05:00', 2.10, '06:00-08:00', 'SENSOR002'),
    ('U003', 'DHAKA3', 'Gas', 350.75, 'GasDistribution Inc.', '2024-12-07 16:10:00', 3.50, '18:00-20:00', 'SENSOR003'),
    ('U004', 'DHAKA4', 'Electricity', 950.25, 'PowerGrid Ltd.', '2024-12-07 16:15:00', 5.20, '09:00-11:00', 'SENSOR004'),
    ('U005', 'DHAKA5', 'Water', 1050.60, 'WaterSupply Co.', '2024-12-07 16:20:00', 2.10, '07:00-09:00', 'SENSOR005'),
    ('U006', 'DHAKA6', 'Gas', 200.45, 'GasDistribution Inc.', '2024-12-07 16:25:00', 3.50, '19:00-21:00', 'SENSOR006'),
    ('U007', 'DHAKA7', 'Electricity', 1150.80, 'PowerGrid Ltd.', '2024-12-07 16:30:00', 5.20, '10:00-12:00', 'SENSOR007'),
    ('U008', 'DHAKA8', 'Water', 900.25, 'WaterSupply Co.', '2024-12-07 16:35:00', 2.10, '05:00-07:00', 'SENSOR008'),
    ('U009', 'DHAKA9', 'Gas', 450.50, 'GasDistribution Inc.', '2024-12-07 16:40:00', 3.50, '15:00-17:00', 'SENSOR009'),
    ('U010', 'DHAKA0', 'Electricity', 1300.00, 'PowerGrid Ltd.', '2024-12-07 16:45:00', 5.20, '11:00-13:00', 'SENSOR010');


select * 

from utility_monitoring;

