CREATE FUNCTION getBalance (@CustomerID as INT) RETURNS INT AS
BEGIN
	DECLARE @Balance as INT;
	SELECT TOP 1 @Balance = Balance FROM Passbook WHERE CustomerID = @CustomerID ORDER BY TransactionID DESC;
	RETURN @Balance;
END

BEGIN
	print dbo.getBalance(80);
END