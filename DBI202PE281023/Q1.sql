create table Manufacturers
(
	ManufacturerID int PRIMARY KEY,
	ManufacturerAddress nvarchar(100),
	ManufacturerPhone varchar(20),
	ManufacturerFax varchar(20)
)

create table Laptops
(
	LaptopSKU VARCHAR(100) PRIMARY KEY,
	LaptopName nvarchar(50),
	Price DECIMAL(8,2),
	[Description] nvarchar(300),
	ManufacturerID int FOREIGN KEY REFERENCES Manufacturers(ManufacturerID)
)

create table Customers
(
	CustomerID int PRIMARY KEY,
	CustomerPhone varchar(20),
	CustomerAddress nvarchar(100)
)


create table Purchase
(
	CustomerID int FOREIGN KEY REFERENCES Customers(CustomerID),
	LaptopSKU VARCHAR(100) FOREIGN KEY REFERENCES Laptops(LaptopSKU),
	[Date] DATETIME,
	Quantity int,
	PRIMARY KEY (CustomerID, LaptopSKU)

)