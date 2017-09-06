-- Person Table --
-- | The person table consists of personal details of every person (Driver and Customer)
-- | Age is derived from DateOfBirth 
-- | The primary Key is auto incremented
-- | Gender has a check constraint

CREATE TABLE Person (
	-- Columns --
	PersonID		int PRIMARY KEY IDENTITY (1,1),
	Name			varchar(30) NOT NULL,
	DateOfBirth		date,
	Gender			char(1),
	Contact			varchar(20),
	Email			varchar(320),
	Age				int,

	-- Constraints --
	CONSTRAINT	chk_gender CHECK (Gender IN ('M', 'F'))
);

-- Driver Table --
-- | The driver's salary is calculated based upon the rides he makes
-- | The driver's rating is derived as average of all his rides
-- | The driver references Person for his personal details

CREATE TABLE Driver(
	-- Columns --
	DriverID		int PRIMARY KEY IDENTITY (1,1),
	Salary			int,
	DriverRating	int,
	PersonID		int FOREIGN KEY REFERENCES Person(PersonID),
	
	-- Constraints --
	CONSTRAINT	chk_driver_rating_avg CHECK (DriverRating >= 1 and DriverRating <= 5)
);

CREATE TABLE Customer(
	-- Columns --
	CustomerID		int PRIMARY KEY IDENTITY (1,1),
	isPremium		bit NOT NULL,
	CustomerRating	int,
	PersonID		int FOREIGN KEY REFERENCES Person(PersonID),

	-- Constraints --
	CONSTRAINT chk_customer_rating_avg CHECK (CustomerRating >= 1 and CustomerRating <= 5)
);

CREATE TABLE CabType (
	-- Columns --
	TypeID			int PRIMARY KEY IDENTITY (1,1),
	TypeName		varchar(30)
);

CREATE TABLE Cab (
	-- Columns --
	CabID			int PRIMARY KEY IDENTITY (1,1),  
	RegistrationNumber varchar(20) NOT NULL,
	ModelName		varchar(30),
	CompanyName		varchar(30),
	DriverID		int FOREIGN KEY REFERENCES Driver(DriverID),
	TypeID			int FOREIGN KEY REFERENCES CabType (TypeID)
);

CREATE TABLE CabCondition (
	-- Columns --
	CabID			int FOREIGN KEY REFERENCES Cab(CabID),
	Problem			varchar(250),
	ProblemDate		date NOT NULL,
	Solved			bit,
	SolvedDate		date,
);

CREATE TABLE CabLocation (
	-- Columns --
	CabID			int FOREIGN KEY REFERENCES Cab(CabID),
	Longitude		decimal NOT NULL,
	Latitude		decimal NOT NULL,
	Occupied		varchar(30),

	-- Constraints --
	CONSTRAINT chk_occupied CHECK (Occupied IN ('Free', 'Unoccupied', 'Unavailable')) 
);

ALTER TABLE CabCondition ADD ConditionID INT IDENTITY(1, 1) PRIMARY KEY;

CREATE TABLE Reservation (
	-- Columns --
	FromLongitude	decimal NOT NULL,
	FromLatitude	decimal NOT NULL,
	ToLongitude		decimal NOT NULL,
	ToLatitude		decimal NOT NULL,
	CustomerID		int FOREIGN KEY REFERENCES Customer(CustomerID),
);

Select * from Reservation;
ALTER TABLE Reservation ADD CabID INT FOREIGN KEY REFERENCES Cab(CabID);

CREATE TABLE Passbook (
	-- Columns --
	TransactionID	int PRIMARY KEY IDENTITY (1,1),
	CustomerID		int FOREIGN KEY REFERENCES Customer(CustomerID),
	Balance			int NOT NULL DEFAULT 100,
	Debit			int,
	Credit			int,
	TransactionDate date,

	-- Constraints --
	CONSTRAINT chk_balance CHECK ( Balance >= 100)
);

CREATE TABLE Ride (
	-- Columns --
	RideID			int PRIMARY KEY,
	TransactionID	int UNIQUE NOT NULL,
	CustomerID		int FOREIGN KEY REFERENCES Customer(CustomerID),
	CabID			int FOREIGN KEY REFERENCES Cab(CabID),
	RideDate		date,
	FromLatitude	decimal NOT NULL,
	FromLongitude	decimal NOT NULL,
	ToLatitude		decimal NOT NULL,
	ToLongitude		decimal NOT NULL,
	TimeTaken		time,
	DriverRating	int,
	CustomerRating	int,

	-- Constraints --
	CONSTRAINT	chk_driver_rating CHECK (DriverRating >= 1 and DriverRating <= 5),
	CONSTRAINT chk_customer_rating CHECK (CustomerRating >= 1 and CustomerRating <= 5)
);

CREATE TABLE Promos (
	-- Columns --
	CustomerID		int FOREIGN KEY REFERENCES Customer(CustomerID),
	PromoCode		int UNIQUE NOT NULL,
	Amount			int,
	isRedeemed		bit
);

-- DROP TABLE
DROP TABLE  Promos;
DROP TABLE	Ride;
DROP TABLE	Passbook;
DROP TABLE	Reservation;
DROP TABLE	CabCondition;
DROP TABLE	CabLocation;
DROP TABLE	Cab;
DROP TABLE	CabType;
DROP TABLE	Customer;
DROP TABLE	Driver;
DROP TABLE	Person;