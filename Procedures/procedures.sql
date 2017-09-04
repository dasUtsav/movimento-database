-- Get nearby Cabs --

ALTER PROCEDURE getNearbyCab(@latitude DECIMAL, @longitude DECIMAL, @nearestCabID INT OUTPUT) AS 
BEGIN
	DECLARE @countCabID INT = 1;
	DECLARE @cabLat as DECIMAL, @cabLong as DECIMAL;

	DECLARE @minDistance FLOAT = 1000;

	WHILE @countCabID < 20
	BEGIN
		SELECT @cabLat = Latitude, @cabLong = Longitude FROM CabLocation WHERE CabID = @countCabID;
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
EXECUTE getNearbyCab 8.2, 124.7, @cabID Output;
print @cabID;
END

SELECT * FROM CabLocation;