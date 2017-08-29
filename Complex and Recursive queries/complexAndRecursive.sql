SELECT * FROM Cab WHERE CabID IN (SELECT CabID FROM CabLocation AS cl WHERE cl.Occupied = 'Unoccupied');

SELECT * FROM Cab WHERE CabID IN (SELECT CabID FROM CabCondition AS cc WHERE cc.Solved = '0' AND cc.ProblemDate = '2017-05-08');

SELECT p.PersonID, DateOfBirth, Gender, CustomerID, isPremium FROM Person as p, Customer as c WHERE p.PersonID = c.CustomerID AND CustomerID IN (Select CustomerID FROM Promos AS pr WHERE pr.isRedeemed = '1');

SELECT TypeName, CompanyName FROM CabType AS ct, Cab AS c, CabLocation AS cl WHERE ct.TypeID = c.TypeID AND c.CabID = cl.CabID AND cl.Occupied = 'Free';

SELECT CustomerID, Name, Contact FROM Customer AS c, Person AS p WHERE c.CustomerID = p.PersonID AND p.Gender = 'F';

ALTER TABLE Cab ADD Proprietor varchar(30);

UPDATE Cab SET Proprietor = '1' WHERE DriverID = ('5');
UPDATE Cab SET Proprietor = '1' WHERE DriverID = ('6');
UPDATE Cab SET Proprietor = '1' WHERE DriverID = ('7');
UPDATE Cab SET Proprietor = '1' WHERE DriverID = ('8');
UPDATE Cab SET Proprietor = '1' WHERE DriverID = ('9');

UPDATE Cab SET Proprietor = '2' WHERE DriverID = ('10');
UPDATE Cab SET Proprietor = '2' WHERE DriverID = ('11');
UPDATE Cab SET Proprietor = '2' WHERE DriverID = ('12');
UPDATE Cab SET Proprietor = '2' WHERE DriverID = ('13');

UPDATE Cab SET Proprietor = '3' WHERE DriverID = ('14');
UPDATE Cab SET Proprietor = '3' WHERE DriverID = ('15');
UPDATE Cab SET Proprietor = '3' WHERE DriverID = ('16');

UPDATE Cab SET Proprietor = '4' WHERE DriverID = ('17');
UPDATE Cab SET Proprietor = '4' WHERE DriverID = ('18');
UPDATE Cab SET Proprietor = '4' WHERE DriverID = ('19');
UPDATE Cab SET Proprietor = '4' WHERE DriverID = ('20');


SELECT * FROM Person;
SELECT * FROM Driver;
SELECT * FROM Cab; 
select * from CabType;
select * from CabLocation;
select * from Customer;

WITH Owners 
AS
(

--intialization

SELECT DriverID, CompanyName, Proprietor FROM Cab WHERE Proprietor IS NULL

UNION ALL

-- recursive execution

SELECT c.DriverID, c.CompanyName, c.Proprietor FROM Cab AS c INNER JOIN Owners AS o ON c.Proprietor = o.DriverID 
)

SELECT * FROM Owners;

select * from CabCondition;
select * from Passbook;
select * from Promos; 
select * from Cab;

select * from Premiums;
