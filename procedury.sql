

-------------------------------------------------------------
----------------	PROCEDURY		-----------------------------
-------------------------------------------------------------

USE u_koszarek
GO

---------dodawanie klienta indywidualnego
CREATE PROCEDURE [add_individual_customer] 
(@firstname nvarchar(50), @middlename nvarchar(50), @lastname nvarchar(50),
 @phone nchar(10), @adress nvarchar(50), @email nvarchar(50), @restaurantid int,
 @companyid int, @startdate date, @enddate date)
as
begin
	insert into customers
		values (@phone, @adress, @email, @restaurantid)
	insert into Person 
		values (@@IDENTITY, @firstname, @middlename, @lastname)
	if @companyid is not null AND @startdate is not null AND @enddate is not null
	begin
		insert into WorksIn
			values (@@IDENTITY, @companyid, @startdate, @enddate);
	end
end
go


---------dodawanie klienta firmowego
CREATE PROCEDURE [add_company_customer] 
(@companyname nvarchar(50), @nip nvarchar(50), @companyadress nvarchar(50),
 @phone nchar(10), @adress nvarchar(50), @email nvarchar(50), @restaurantid int)
as
begin
	insert into customers
		values (@phone, @adress, @email, @restaurantid)
	insert into Company 
		values (@@IDENTITY, @companyname, @nip, @companyadress)
end
go


----------------- dodawanie dania

-- tworzenie table-value paramteru
CREATE TYPE [DishDetailsType] 
   AS TABLE
      (HalfProductID int, quantity float);
GO

-- tworzenie wlasciwej procedury przyjmujacej powyzszy typ jako paramter
CREATE PROCEDURE [dbo].[add_dish]
   (@dishdetails DishDetailsType READONLY,
	@dishname nvarchar(50), @unitprice money, @categoryid int)
as
begin
	insert into dishes
		values (@dishname, @unitprice, @categoryid)

	insert into DishDetails
		select @@IDENTITY, * from @dishdetails
end
GO




------- dodawanie zamowienia

-- tworzenie table-value paramteru
CREATE TYPE [OrderPositionsType] 
   AS TABLE
      (MenuPosition int, ammount int);
GO

/* tworzenie wlasciwej procedury dodajacej zamowienie,
		przyjmujacej table-value parametr */
CREATE PROCEDURE add_order
   (@orderpositions OrderPositionsType READONLY,
	@customerid int, @orderdate date, @preferedrealdate date,
	@orderadress nvarchar(50), @employeeid int)
as
begin
	insert into Orders
		values (@customerid, @orderdate, @preferedrealdate,
				@orderadress, @employeeid)

	insert into OrderDetails
		select @@IDENTITY, * from @orderpositions
end
GO


--------- dodawanie pozycji
create procedure add_position
	(@positionname nvarchar(50))
as
begin
	insert into Positions
		values (@positionname)
end
go



--------- dodawanie pracownika
create procedure add_employee
	(@positionid int, @salary money, @firstname nvarchar(50), @lastname nvarchar(50))
as
begin
	insert into Dishes
		values (@positionid, @salary, @firstname, @lastname)
end
go



