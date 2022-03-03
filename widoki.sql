
-------------------------------------------------------------
----------------	WIDOKI		-----------------------------
-------------------------------------------------------------

USE u_koszarek
GO



--------Aktualne pozycje w menu---------
CREATE VIEW [Current Menu] AS
SELECT *
FROM Menu
WHERE StartDate <= GETDATE() and GETDATE() <= EndDate
GO




----------		RAPORTY		-------------------

---Raport dot. liczby zamówieñ dla kazdego klienta (indywidualnego oraz firmowego)
CREATE VIEW [Customers Orders Ammount] AS
select p.firstname + p.lastname as name,
			COUNT (*) as [Number of orders]
from Person as p
left join Customers as c
	on p.CustomerID = c.CustomerID
left join Orders as o
	on c.CustomerID = o.CustomerID
group by o.CustomerID, p.Firstname, p.Lastname
union
select com.companyname as name,
			COUNT (*) as [Number of orders]
from company as com
left join Customers as c
	on com.CustomerID = c.CustomerID
left join Orders as o
	on c.CustomerID = o.CustomerID
group by o.CustomerID, com.CompanyName
GO


---Raport dot. kwot oraz dat zamowien dla klientów (indyw. i firmowych)
CREATE VIEW [dbo].[Order Statistics] AS
select o.CustomerID, o.OrderID, o.OrderDate, SUM(d.UnitPrice*od.Amount) as [value]
from Orders as o
inner join OrderDetails as od
	on o.OrderID = od.OrderID
inner join Menu as m
	on m.MenuPositionID = od.MenuPositionID
inner join Dishes as d
	on d.DishID = m.DishID
group by o.OrderID, o.CustomerID, o.Orderdate
GO

--------------------
--MIESIECZNE:

---Raport miesiêczny dot. rezerwacji stolików
CREATE VIEW [Table reservations last months] AS
select * from Reservations
where DATEDIFF(MONTH, ReservationDate, GETDATE()) <= 1
GO


---Raport miesieczny dot. rabatów przyznanych klientom
CREATE VIEW [Given Discounts last month] AS
select * from CustomerDiscounts
where DATEDIFF(MONTH, RecieveDate, GETDATE()) <= 1
GO

---Raport miesieczny dot. pozycji pojawiaj¹cych sie w menu
CREATE VIEW [Menu Positions last month] AS
select * from Menu
where DATEDIFF(MONTH, StartDate, GETDATE()) <= 1
GO

--------------------
--TYGODNIOWE:

---Raport tygodniowy dot. rezerwacji stolików
CREATE VIEW [Table reservations last week] AS
select * from Reservations
where DATEDIFF(DAY, ReservationDate, GETDATE()) <= 7
GO

---Raport tygodniowy dot. rabatów przyznanych klientom
CREATE VIEW [Given Discounts last week] AS
select * from CustomerDiscounts
where DATEDIFF(DAY, RecieveDate, GETDATE()) <= 7
GO

---Raport tygodniowy dot. pozycji pojawiaj¹cych sie w menu
CREATE VIEW [Menu Positions last week] AS
select * from Menu
where DATEDIFF(DAY, StartDate, GETDATE()) <= 7
GO


