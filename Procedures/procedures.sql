-- Get nearby Cabs --

ALTER PROCEDURE getNearbyCab(@latitude DECIMAL, @longitude DECIMAL, @nearestCabID INT OUTPUT) AS 
BEGIN
	DECLARE @countCabID INT = 1;
	DECLARE @cabLat as DECIMAL, @cabLong as DECIMAL;

	DECLARE @minDistance FLOAT = 1000;

	WHILE @countCabID < 20
	BEGIN
		SELECT @cabLat = Latitude, @cabLong = Longitude FROM CabLocation WHERE CabID = @countCabID AND Occupied = 'Free';
		DECLARE @dLat FLOAT = @cabLat - @latitude;
		DECLARE @dLong FLOAT = @cabLong - @longitude;

		DECLARE @a FLOAT = power((sin(@dLat/2)), 2) + cos(@cabLat) * cos(@latitude) * power((sin(@dLong/2)), 2);
		DECLARE @c FLOAT = 2 * atn2( sqrt(@a), sqrt(1-@a) );
		
		IF @c < @minDistance
		BEGIN
			SET @minDistance = @c;
			SET @nearestCabID = @countCabID;
		END; 
		SET @countCabID = @countCabID + 1;
	END;
END;

BEGIN
DECLARE @cabID as INT;
EXECUTE getNearbyCab -7, 107, @cabID Output;
print @cabID;
END

SELECT * FROM CabLocation;

-- Book A ride --
ALTER PROCEDURE bookACab(@sourcelat DECIMAL, @sourcelong DECIMAL, @destlat DECIMAL, @destlong DECIMAL, @customerID INT) AS
BEGIN
	DECLARE @cabID as INT;

	EXECUTE getNearbyCab @sourcelat, @sourcelong, @cabID Output;

	INSERT INTO Reservation (FromLatitude, FromLongitude, ToLatitude, ToLongitude, CabID, CustomerID)
		VALUES (@sourcelat, @sourcelong, @destlat, @destlong, @cabID, @customerID);

	print 'Booking Successful! Wait for the driver to accept your ride request';
END;

execute bookACab 48, 16, 5, 88, 10;

Select * from Reservation;

-- Refill Wallet --
ALTER PROCEDURE refillWallet (@amount int, @customerID int) AS
BEGIN
	insert into Passbook (Credit, Debit, CustomerID, TransactionDate) values (@amount, 0, @customerID, GETDATE());
END

execute refillWallet 200, 5;