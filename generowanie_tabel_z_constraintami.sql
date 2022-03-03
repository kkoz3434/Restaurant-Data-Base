
----------------------------------------------------------------------
--------  GENEROWANIE TABEL Z CONSTRAINTAMI  ------------------------------------------
----------------------------------------------------------------------

USE u_koszarek
GO


-----------MENU------------------
CREATE TABLE [dbo].[Menu](
	[DishID] [int] NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NULL,
	[MenuPositionID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED 
(
	[MenuPositionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Menu]  WITH CHECK ADD  CONSTRAINT [FK_Menu_Dishes] FOREIGN KEY([DishID])
REFERENCES [dbo].[Dishes] ([DishID])
GO
ALTER TABLE [dbo].[Menu] CHECK CONSTRAINT [FK_Menu_Dishes]
GO
ALTER TABLE [dbo].[Menu]  WITH CHECK ADD  CONSTRAINT [CK_Menu] CHECK  (([startdate]<[enddate]))
GO
ALTER TABLE [dbo].[Menu] CHECK CONSTRAINT [CK_Menu]
GO


-------------DISHES----------------------
CREATE TABLE [dbo].[Dishes](
	[DishID] [int] IDENTITY(1,1) NOT NULL,
	[DishName] [nvarchar](50) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[UnitPrice] [money] NOT NULL,
 CONSTRAINT [PK_Dishes] PRIMARY KEY CLUSTERED 
(
	[DishID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [dishid] UNIQUE NONCLUSTERED 
(
	[DishID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
---checks
ALTER TABLE [dbo].[Dishes]  WITH CHECK 
ADD  CONSTRAINT [FK_Dishes_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Dishes] CHECK CONSTRAINT [FK_Dishes_Categories]
GO
ALTER TABLE [dbo].[Dishes]  WITH CHECK 
ADD  CONSTRAINT [CK_Dishes] CHECK  (([Unitprice]>(0)))
GO
ALTER TABLE [dbo].[Dishes] CHECK CONSTRAINT [CK_Dishes]
GO
---unique
ALTER TABLE [dbo].[Dishes]
ADD CONSTRAINT UC_DISHES UNIQUE (DishName)
GO


------------DISH DETAILS-------------------
CREATE TABLE [dbo].[DishDetails](
	[HalfProdID] [int] NOT NULL,
	[DishID] [int] NOT NULL,
	[Quantity] [float] NOT NULL,
	CONSTRAINT [PK_DishDetails] PRIMARY KEY CLUSTERED 
(
	[HalfProdID] ASC,
	[DishID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
---checks
ALTER TABLE [dbo].[DishDetails]  WITH CHECK
ADD  CONSTRAINT [FK_DishDetails_Dishes] FOREIGN KEY([DishID])
REFERENCES [dbo].[Dishes] ([DishID])
GO
ALTER TABLE [dbo].[DishDetails] CHECK CONSTRAINT [FK_DishDetails_Dishes]
GO
ALTER TABLE [dbo].[DishDetails]  WITH CHECK
ADD  CONSTRAINT [FK_DishDetails_HalfProducts] FOREIGN KEY([HalfProdID])
REFERENCES [dbo].[HalfProducts] ([HalfProductID])
GO
ALTER TABLE [dbo].[DishDetails] CHECK CONSTRAINT [FK_DishDetails_HalfProducts]
GO
ALTER TABLE [dbo].[DishDetails]  WITH CHECK 
ADD  CONSTRAINT [CK_DishDetails] CHECK  (([quantity]>(0)))
GO
ALTER TABLE [dbo].[DishDetails] CHECK CONSTRAINT [CK_DishDetails]
GO
---unique
ALTER TABLE [dbo].[DishDetails]
ADD CONSTRAINT UC_DISHDETAILS UNIQUE (HalfProductID, DishID)
GO


----------HALF PRODUCTS-----------------
CREATE TABLE [dbo].[HalfProducts](
	[HalfProductID] [int] IDENTITY(1,1) NOT NULL,
	[HalfProductName] [nvarchar](50) NOT NULL,
	[UnitsInStock] [float] NOT NULL,
 CONSTRAINT [PK_HalfProducts] PRIMARY KEY CLUSTERED 
(
	[HalfProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
---checks
ALTER TABLE [dbo].[HalfProducts]  WITH CHECK
ADD  CONSTRAINT [CK_HalfProducts] CHECK  (([unitsinstock]>=(0)))
GO
ALTER TABLE [dbo].[HalfProducts] CHECK CONSTRAINT [CK_HalfProducts]
GO
---unique
ALTER TABLE [dbo].[HalfProducts]
ADD CONSTRAINT UC_HALFPRODUCTS UNIQUE (HalfProductName)
GO



--------------RESTAURANTS-------------------
CREATE TABLE [dbo].[Restaurants](
	[RestaurantID] [int] IDENTITY(1,1) NOT NULL,
	[RestaurantName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Restaurants] PRIMARY KEY CLUSTERED 
(
	[RestaurantID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
----auto increment------------
alter table [dbo].[restaurants]
add constraint identity_dishes IDENTITY(1,1) (Restaurantid) 
go
---unique
ALTER TABLE [dbo].[Restaurants]
ADD CONSTRAINT UC_DISHES UNIQUE (RestaurantName)
GO



--------------CATEGORIES-------------------
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
---unique
ALTER TABLE [dbo].[Categories]
ADD CONSTRAINT UC_CATEGORIES UNIQUE (CategoryName)
GO



--------ORDERS------------
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[OrderDate] [date] NOT NULL default getdate(),
	[PreferedRealisationDate] [date] NOT NULL default getdate(),
	[OrderAdress] [nvarchar](50) NULL,
	[EmployeeID] [int] NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
-----checks
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Employees]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [CK_Orders] CHECK  (([orderdate]<=[preferedrealisationdate]))
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [CK_Orders]
GO


-----------------ORDER DETAILS-------------
CREATE TABLE [dbo].[OrderDetails](
	[OrderID] [int] NOT NULL,
	[MenuPositionID] [int] NOT NULL,
	[Amount] [int] NOT NULL,
CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[MenuPositionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
ALLOW_ROW_LOCKS = ON,ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
-----checks
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK 
ADD  CONSTRAINT [FK_OrderDetails_Menu] FOREIGN KEY([MenuPositionID])
REFERENCES [dbo].[Menu] ([MenuPositionID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Menu]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK 
ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK 
ADD  CONSTRAINT [CK_OrderDetails] CHECK  (([amount]>(0)))
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [CK_OrderDetails]
GO
-----unique
ALTER TABLE [dbo].[OrderDetails]
ADD CONSTRAINT UC_ORDERDETAILS UNIQUE (OrderID, MenuPositionID)
GO



-------------EMPLOYEES--------------------
CREATE TABLE [dbo].[Employees](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[PositionID] [int] NOT NULL,
	[Salary] [money] NOT NULL,
	[Firstname] [nvarchar](50) NOT NULL,
	[Lastname] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
-----checks
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Positions] FOREIGN KEY([PositionID])
REFERENCES [dbo].[Positions] ([PositionID])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_Positions]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [CK_Employees] CHECK  (([salary]>(0)))
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [CK_Employees]
GO


--------------------POSITIONS--------------
CREATE TABLE [dbo].[Positions](
	[PositionID] [int] IDENTITY(1,1) NOT NULL,
	[PositionName] [varbinary](50) NOT NULL,
 CONSTRAINT [PK_Positions] PRIMARY KEY CLUSTERED 
(
	[PositionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
----unique
ALTER TABLE [dbo].[Positions]
ADD CONSTRAINT UC_POSITIONS UNIQUE (PositionName)
GO



---------------------TABLES------------------
CREATE TABLE [dbo].[Tables](
	[TableID] [int] IDENTITY(1,1) NOT NULL,
	[Seats] [int] NOT NULL,
	[RestaurantID] [int] NOT NULL,
 CONSTRAINT [PK_Tables] PRIMARY KEY CLUSTERED 
(
	[TableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
-----checks
ALTER TABLE [dbo].[Tables]  WITH CHECK ADD
CONSTRAINT [FK_Tables_Restaurants] FOREIGN KEY([RestaurantID])
REFERENCES [dbo].[Restaurants] ([RestaurantID])
GO
ALTER TABLE [dbo].[Tables] CHECK CONSTRAINT [FK_Tables_Restaurants]
GO
ALTER TABLE [dbo].[Tables]  WITH CHECK ADD  CONSTRAINT [CK_Tables] CHECK  (([seats]>(0)))
GO
ALTER TABLE [dbo].[Tables] CHECK CONSTRAINT [CK_Tables]
GO



---------------AVAILABLE TABLES---------
CREATE TABLE [dbo].[AvailableTables](
	[AvailableTableID] [int] IDENTITY(1,1) NOT NULL,
	[TableID] [int] NOT NULL,
	[SeatsAmmount] [int] NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
CONSTRAINT [PK_AvailableTables] PRIMARY KEY CLUSTERED ([AvailableTableID] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
---checks
ALTER TABLE [dbo].[AvailableTables]  WITH CHECK ADD  CONSTRAINT [FK_AvailableTables_Tables] FOREIGN KEY([TableID])
REFERENCES [dbo].[Tables] ([TableID])
GO
ALTER TABLE [dbo].[AvailableTables] CHECK CONSTRAINT [FK_AvailableTables_Tables]
GO
ALTER TABLE [dbo].[AvailableTables]  WITH CHECK ADD  CONSTRAINT [CK_AvailableTables] CHECK  (([startdate]<[enddate]))
GO
ALTER TABLE [dbo].[AvailableTables] CHECK CONSTRAINT [CK_AvailableTables]
GO

-----funkcja do pozyskania liczby miejsc ze stolika (danych z innej tabeli)-----
create function dbo.CheckTableSeats(@tableId int)
returns int
as begin
    return (select seats from Tables where TableID = @tableId)
end
GO

------checks
alter table [dbo].[AvailableTables] 
add constraint [CK_LessSeats] check (dbo.CheckTableSeats(availabletableID) > seatsammount)
GO

----unique
ALTER TABLE [dbo].[AvailableTables]
ADD CONSTRAINT UC_AVAILABLETABLES UNIQUE (TableID, StartDate, EndDate)
GO



----------PERSON DISCOUNTS ------
CREATE TABLE [dbo].[PersonDiscounts](
	[DiscountID] [int] IDENTITY(1,1) NOT NULL,
	[Percent] [real] NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NULL,
	[MinValueTotal] [money] NOT NULL,
	[ValidityTime] [int] NULL,
	[NumberOfOrders] [int] NOT NULL,
	[MinValuePerOrder] [money] NOT NULL,
 CONSTRAINT [PK_Discounts] PRIMARY KEY CLUSTERED 
(
	[DiscountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
----checks
ALTER TABLE [dbo].[PersonDiscounts]  WITH CHECK ADD  CONSTRAINT [CK_PersonDiscounts] CHECK  (((0)<=[percent] AND [percent]<=(1)))
GO
ALTER TABLE [dbo].[PersonDiscounts] CHECK CONSTRAINT [CK_PersonDiscounts]
GO
ALTER TABLE [dbo].[PersonDiscounts]  WITH CHECK ADD  CONSTRAINT [CK_PersonDiscounts_1] CHECK  (([startdate]<[enddate]))
GO
ALTER TABLE [dbo].[PersonDiscounts] CHECK CONSTRAINT [CK_PersonDiscounts_1]
GO
ALTER TABLE [dbo].[PersonDiscounts]  WITH CHECK ADD  CONSTRAINT [CK_PersonDiscounts_2] CHECK  (([validitytime]>=(0)))
GO
ALTER TABLE [dbo].[PersonDiscounts] CHECK CONSTRAINT [CK_PersonDiscounts_2]
GO
ALTER TABLE [dbo].[PersonDiscounts]  WITH CHECK ADD  CONSTRAINT [CK_PersonDiscounts_3] CHECK  (([minvaluetotal]>=(0)))
GO
ALTER TABLE [dbo].[PersonDiscounts] CHECK CONSTRAINT [CK_PersonDiscounts_3]
GO
ALTER TABLE [dbo].[PersonDiscounts]  WITH CHECK ADD  CONSTRAINT [CK_PersonDiscounts_4] CHECK  (([numberoforders]>=(0)))
GO
ALTER TABLE [dbo].[PersonDiscounts] CHECK CONSTRAINT [CK_PersonDiscounts_4]
GO
ALTER TABLE [dbo].[PersonDiscounts]  WITH CHECK ADD  CONSTRAINT [CK_PersonDiscounts_5] CHECK  (([minvalueperorder]>=(0)))
GO
ALTER TABLE [dbo].[PersonDiscounts] CHECK CONSTRAINT [CK_PersonDiscounts_5]
GO


-------------COMPANY DISCOUNTS---------------
CREATE TABLE [dbo].[CompanyDiscount](
	[DiscountID] [int] IDENTITY(1,1) NOT NULL,
	[Percent] [real] NOT NULL,
	[NumberOfOrders] [int] NOT NULL,
	[ContinuityPeriod] [int] NOT NULL,
	[MinValueTotal] [money] NOT NULL,
	[MaxCompoundPercent] [real] NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NULL,
 CONSTRAINT [PK_CompanyDiscount] PRIMARY KEY CLUSTERED 
(
	[DiscountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
-----checks
ALTER TABLE [dbo].[CompanyDiscount]  WITH CHECK ADD  CONSTRAINT [CK_CompanyDiscount] CHECK  (((0)<=[percent] AND [percent]<=(1)))
GO
ALTER TABLE [dbo].[CompanyDiscount] CHECK CONSTRAINT [CK_CompanyDiscount]
GO
ALTER TABLE [dbo].[CompanyDiscount]  WITH CHECK ADD  CONSTRAINT [CK_CompanyDiscount_1] CHECK  (([numberoforders]>=(0)))
GO
ALTER TABLE [dbo].[CompanyDiscount] CHECK CONSTRAINT [CK_CompanyDiscount_1]
GO
ALTER TABLE [dbo].[CompanyDiscount]  WITH CHECK ADD  CONSTRAINT [CK_CompanyDiscount_2] CHECK  (([continuityperiod]>(0)))
GO
ALTER TABLE [dbo].[CompanyDiscount] CHECK CONSTRAINT [CK_CompanyDiscount_2]
GO
ALTER TABLE [dbo].[CompanyDiscount]  WITH CHECK ADD  CONSTRAINT [CK_CompanyDiscount_3] CHECK  (([minvaluetotal]>=(0)))
GO
ALTER TABLE [dbo].[CompanyDiscount] CHECK CONSTRAINT [CK_CompanyDiscount_3]
GO
ALTER TABLE [dbo].[CompanyDiscount]  WITH CHECK 
ADD  CONSTRAINT [CK_CompanyDiscount_4] CHECK  (([percent]<=[maxcompoundpercent] AND [maxcompoundpercent]<=(1)))
GO
ALTER TABLE [dbo].[CompanyDiscount] CHECK CONSTRAINT [CK_CompanyDiscount_4]
GO


-------CUSTOMER DISCOUNTS-------------
CREATE TABLE [dbo].[CustomerDiscounts](
	[CustomerID] [int] NOT NULL,
	[DiscountID] [int] NOT NULL,
	[RecieveDate] [date] NOT NULL,
	[EndDate] [date] NULL,
	[Utilised] [bit] NOT NULL default 0
 CONSTRAINT [PK_CustomerDiscounts] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC,
	[DiscountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]

) ON [PRIMARY]
GO
----checks
ALTER TABLE [dbo].[CustomerDiscounts]  WITH CHECK
ADD  CONSTRAINT [FK_CustomerDiscounts_CompanyDiscount] FOREIGN KEY([DiscountID])
REFERENCES [dbo].[CompanyDiscount] ([DiscountID])
GO
ALTER TABLE [dbo].[CustomerDiscounts] CHECK CONSTRAINT [FK_CustomerDiscounts_CompanyDiscount]
GO
ALTER TABLE [dbo].[CustomerDiscounts]  WITH CHECK
ADD  CONSTRAINT [FK_CustomerDiscounts_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[CustomerDiscounts] CHECK CONSTRAINT [FK_CustomerDiscounts_Customers]
GO
ALTER TABLE [dbo].[CustomerDiscounts]  WITH CHECK
ADD  CONSTRAINT [FK_CustomerDiscounts_Discounts] FOREIGN KEY([DiscountID])
REFERENCES [dbo].[PersonDiscounts] ([DiscountID])
GO
ALTER TABLE [dbo].[CustomerDiscounts] CHECK CONSTRAINT [FK_CustomerDiscounts_Discounts]
GO
ALTER TABLE [dbo].[CustomerDiscounts]  WITH CHECK
ADD  CONSTRAINT [CK_CustomerDiscounts] CHECK  (([recievedate]<[enddate]))
GO
ALTER TABLE [dbo].[CustomerDiscounts] CHECK CONSTRAINT [CK_CustomerDiscounts]
GO
----unique
ALTER TABLE [dbo].[CustomerDiscounts]
ADD CONSTRAINT UC_CUSTOMERDISCOUNT UNIQUE (DiscountID, CustomerID, RecieveDate) 
GO



--------------CUSTOMERS------------
CREATE TABLE [dbo].[Customers](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[Phone] [nchar](10) NULL,
	[Adress] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[RestaurantID] [int] NOT NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
ALLOW_ROW_LOCKS = ON,ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
------checks
ALTER TABLE [dbo].[Customers]  WITH CHECK
ADD  CONSTRAINT [FK_Customers_Restaurants] FOREIGN KEY([RestaurantID])
REFERENCES [dbo].[Restaurants] ([RestaurantID])
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Customers_Restaurants]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK
ADD  CONSTRAINT [CK_Customers] CHECK  (([email] like '%@%'))
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [CK_Customers]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK 
ADD  CONSTRAINT [CK_Customers_1] CHECK  ((isnumeric([phone])=(1)))
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [CK_Customers_1]
GO



-----------PERSON---------------
CREATE TABLE [dbo].[Person](
	[CustomerID] [int] NOT NULL,
	[Firstname] [nvarchar](50) NOT NULL,
	[Middlename] [nvarchar](50) NULL,
	[Lastname] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Person_1] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Person]  WITH CHECK 
ADD  CONSTRAINT [FK_Person_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_Customers]
GO


------------COMPANY-----------------
CREATE TABLE [dbo].[Company](
	[CustomerID] [int] NOT NULL,
	[CompanyName] [nvarchar](50) NOT NULL,
	[NIP] [nvarchar](50) NOT NULL,
	[CompanyAdress] [nvarchar](50) NULL,
 CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
----checks
ALTER TABLE [dbo].[Company]  WITH CHECK ADD  CONSTRAINT [FK_Company_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Company] CHECK CONSTRAINT [FK_Company_Customers]
GO
ALTER TABLE [dbo].[Company]  WITH CHECK ADD  CONSTRAINT [CK_Company] CHECK  ((isnumeric([nip])=(1)))
GO
ALTER TABLE [dbo].[Company] CHECK CONSTRAINT [CK_Company]
GO
----unique
ALTER TABLE [dbo].[Company]
ADD CONSTRAINT UC_COMPANY UNIQUE (NIP)
GO



-----------WORKS IN--------------------
CREATE TABLE [dbo].[WorksIn](
	[PersonID] [int] NOT NULL,
	[CompanyID] [int] NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
CONSTRAINT [PK_WorksIn] PRIMARY KEY CLUSTERED 
(
	[PersonID] ASC,
	[CompanyID] ASC,
	[StartDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
----check
ALTER TABLE [dbo].[WorksIn]  WITH CHECK ADD  CONSTRAINT [FK_WorksIn_Company] FOREIGN KEY([CompanyID])
REFERENCES [dbo].[Company] ([CustomerID])
GO
ALTER TABLE [dbo].[WorksIn] CHECK CONSTRAINT [FK_WorksIn_Company]
GO
ALTER TABLE [dbo].[WorksIn]  WITH CHECK ADD  CONSTRAINT [FK_WorksIn_Person] FOREIGN KEY([PersonID])
REFERENCES [dbo].[Person] ([CustomerID])
GO
ALTER TABLE [dbo].[WorksIn] CHECK CONSTRAINT [FK_WorksIn_Person]
GO
ALTER TABLE [dbo].[WorksIn]  WITH CHECK ADD  CONSTRAINT [CK_WorksIn] CHECK  (([startdate]<[enddate]))
GO
ALTER TABLE [dbo].[WorksIn] CHECK CONSTRAINT [CK_WorksIn]
GO
----unique
ALTER TABLE [dbo].[WorksIn]
ADD CONSTRAINT UC_WORKSIN UNIQUE (PersonID, CompanyID, StartDate, EndDate)
GO



-------RESERVATIONS-------------------
CREATE TABLE [dbo].[Reservations](
	[ReservationID] [int] IDENTITY(1,1) NOT NULL,
	[ReservationDate] [date] NOT NULL default getdate(),
	[SeatsAmount] [int] NULL,
	[OrderID] [int] NOT NULL,
	[AvailableTableID] [int] NOT NULL,
 CONSTRAINT [PK_Reservations] PRIMARY KEY CLUSTERED 
(
	[ReservationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
----checks
ALTER TABLE [dbo].[Reservations]  WITH CHECK
ADD  CONSTRAINT [FK_Reservations_AvailableTables] FOREIGN KEY([AvailableTableID])
REFERENCES [dbo].[AvailableTables] ([AvailableTableID])
GO
ALTER TABLE [dbo].[Reservations] CHECK CONSTRAINT [FK_Reservations_AvailableTables]
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK
ADD  CONSTRAINT [FK_Reservations_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[Reservations] CHECK CONSTRAINT [FK_Reservations_Orders]
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK
ADD  CONSTRAINT [FK_Reservations_ReservationIndividual] FOREIGN KEY([ReservationID])
REFERENCES [dbo].[ReservationIndividual] ([ReservationID])
GO
ALTER TABLE [dbo].[Reservations] CHECK CONSTRAINT [FK_Reservations_ReservationIndividual]
GO


-----funkcja do pozyskania liczby miejsc ze stolika (danych z innej tabeli)-----
create function dbo.CheckAvailableTableSeats(@availabletableId int)
returns int
as begin
    return (select availableseats from AvailableTables where availableTableID = @availabletableId)
end
go

alter table [dbo].[Reservations]
add constraint [CK_LessAvailableSeats] check (dbo.CheckAvailableTableSeats(availabletableID) > seatsamount) GO



-------------RESERVATION INDIVIDUAL------------------
CREATE TABLE [dbo].[ReservationIndividual](
	[PersonID] [int] NOT NULL,
	[ReservationID] [int] NOT NULL,
	[Paid] [bit] NOT NULL,
 CONSTRAINT [PK_ReservationIndividual] PRIMARY KEY CLUSTERED 
(
	[ReservationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
----checks
ALTER TABLE [dbo].[ReservationIndividual]  WITH CHECK
ADD  CONSTRAINT [FK_ReservationIndividual_Person] FOREIGN KEY([PersonID])
REFERENCES [dbo].[Person] ([CustomerID])
GO
ALTER TABLE [dbo].[ReservationIndividual] CHECK CONSTRAINT [FK_ReservationIndividual_Person]
GO


------------RESERVATION COMPANY----------------
CREATE TABLE [dbo].[ReservationCompany](
	[ReservationID] [int] NOT NULL,
	[CompanyID] [int] NOT NULL,
 CONSTRAINT [PK_ReservationCompany_1] PRIMARY KEY CLUSTERED 
(
	[ReservationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
----checks
ALTER TABLE [dbo].[ReservationCompany]  WITH CHECK
ADD  CONSTRAINT [FK_ReservationCompany_Company] FOREIGN KEY([CompanyID])
REFERENCES [dbo].[Company] ([CustomerID])
GO
ALTER TABLE [dbo].[ReservationCompany] CHECK CONSTRAINT [FK_ReservationCompany_Company]
GO
ALTER TABLE [dbo].[ReservationCompany]  WITH CHECK
ADD  CONSTRAINT [FK_ReservationCompany_Reservations] FOREIGN KEY([ReservationID])
REFERENCES [dbo].[Reservations] ([ReservationID])
GO
ALTER TABLE [dbo].[ReservationCompany] CHECK CONSTRAINT [FK_ReservationCompany_Reservations]
GO


--------------RESERVATION COMPANY WORKERS--------------------
CREATE TABLE [dbo].[ReservationCompanyWorkers](
	[ReservationID] [int] NOT NULL,
	[WorkerID] [int] NOT NULL,
CONSTRAINT [PK_ReservationCompanyWorkers] PRIMARY KEY CLUSTERED 
(
	[ReservationID] ASC,
	[WorkerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
-----checks
ALTER TABLE [dbo].[ReservationCompanyWorkers]  WITH
CHECK ADD  CONSTRAINT [FK_ReservationCompanyWorkers_Person] FOREIGN KEY([WorkerID])
REFERENCES [dbo].[Person] ([CustomerID])
GO
ALTER TABLE [dbo].[ReservationCompanyWorkers] CHECK CONSTRAINT [FK_ReservationCompanyWorkers_Person]
GO
ALTER TABLE [dbo].[ReservationCompanyWorkers]  WITH CHECK
ADD  CONSTRAINT [FK_ReservationCompanyWorkers_ReservationCompany1] FOREIGN KEY([ReservationID])
REFERENCES [dbo].[ReservationCompany] ([ReservationID])
GO
ALTER TABLE [dbo].[ReservationCompanyWorkers] CHECK CONSTRAINT [FK_ReservationCompanyWorkers_ReservationCompany1]
GO
---unique
ALTER TABLE [dbo].[ReservationCompanyWorkers]
ADD CONSTRAINT UC_RESERVATIONCOMPANYWORKERS UNIQUE (ReservationID, WorkerID)
GO