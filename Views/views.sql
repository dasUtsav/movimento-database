CREATE VIEW CabTrends(CabID, ModelName) AS SELECT CabID, ModelName FROM Cab; 

CREATE VIEW Premiums(CustomerID, isPremium) AS SELECT CustomerID, isPremium FROM Customer WHERE isPremium = '1';

SELECT * FROM Premiums;

SELECT * FROM CabTrends WHERE ModelName = 'Vanquish S';