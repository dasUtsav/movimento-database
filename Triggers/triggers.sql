CREATE TRIGGER UpdateBalance ON Passbook INSTEAD OF INSERT AS
BEGIN
	DECLARE @debit int, @credit int, @balance int, @customerID int, @transDate date;

	SELECT @debit = Debit, @credit = Credit, @customerID = customerID, @transDate = TransactionDate FROM inserted;

	DECLARE @dBalance INT = @credit - @debit;
	SET @balance =  dbo.getBalance(@customerID);

	SET @balance = @balance + @dBalance;
	 
	insert into Passbook (Credit, Debit, Balance, CustomerID, TransactionDate)
		values (@credit, @debit, @balance, @customerID, @transDate);
END

DROP TRIGGER UpdateBalance;
SELECT * FROM Passbook ORDER BY TransactionID DESC;

BEGIN
	print dbo.getBalance(80);
END

insert into Passbook (Credit, Debit, CustomerID, TransactionDate) values (900, 0, 80, '2017/07/30');

CREATE TRIGGER updateProblemDate on CabCondition FOR UPDATE AS
BEGIN
	DECLARE @ConditionID INT, @solved bit;

	SELECT @ConditionID = ConditionID, @solved = Solved from Inserted;

	if @solved = 1
	BEGIN
		UPDATE CabCondition SET SolvedDate = GETDATE() WHERE ConditionID = @ConditionID;
	END;
END

UPDATE CabCondition SET Solved = 1 WHERE ConditionID = 1;
UPDATE CabCondition SET Solved = 1 WHERE ConditionID = 2;

SELECT * from CabCondition;
