CREATE TRIGGER CalculateAge
ON Person
AFTER INSERT, UPDATE
AS	
BEGIN

	DECLARE @age int, @dob date, @PersonID int
	SELECT @dob = DateOfBirth, @PersonID = PersonID FROM inserted

	SELECT @age = DATEDIFF(year,@dob,GETDATE())

	Update Person Set Age  = @age WHERE PersonID = @PersonID
END

Drop trigger CalculateAge;

select * from Person;

INSERT INTO Person(Name, DateOfBirth) VALUES ('Severus','1997-07-13');
INSERT INTO Person(Name, DateOfBirth) VALUES ('Harry','1988-07-13');
INSERT INTO Person(Name, DateOfBirth, Gender, Contact, Email) VALUES ('Luna','1988-07-13','F','487-567-56','ggwp@eaef.com');
INSERT INTO Person(Name, DateOfBirth, Gender, Contact, Email) VALUES ('Cleopatra','1965-05-11','F','487-567-56','rwg@eegw.com');
INSERT INTO Person(Name, DateOfBirth) VALUES ('Harry','2007-07-13');
INSERT INTO Person(Name, DateOfBirth) VALUES ('Severus','1993-06-11');

Alter table Person alter column Name varchar(30);

SELECT * FROM Passbook;
SELECT * FROM Reservation;

CREATE TRIGGER UpdateBalance
ON Passbook
AFTER INSERT, UPDATE
AS
BEGIN

DECLARE
	@debit int, @credit int, @balance int, @transactionID int
	SELECT @debit = Debit, @credit = Credit, @transactionID = TransactionID, @balance = Balance FROM inserted;

	IF(@debit > 0)
		@balance = @balance + @debit;
	

	IF(@debit > 0)
		BEGIN
			UPDATE Passbook SET Balance = @balance WHERE TransactionID = @transactionID;
		END
	ELSE
	BEGIN
		UPDATE Passbook SET Balance = @balance - @credit WHERE TransactionID = @transactionID;
	END
END

INSERT INTO Passbook (CustomerID, Debit, Credit) VALUES ('30','300','0');

select * from Passbook;