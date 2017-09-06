SELECT * FROM Person as p, Cab as c WHERE p.PersonID = c.DriverID AND c.ModelName = 'Diamante';
SELECT * FROM Cab as c, CabLocation as cl WHERE c.CabID = cl.CabID AND cl.Occupied = 'Free' AND c.CompanyName = 'Audi';

select * from Cab;
select * from Driver;
select * from Person;
select * from CabLocation;