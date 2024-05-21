--Q1. Không được dùng/nộp các câu lệnh create database, use, go
create table Departments
(
	DeptID varchar(15) primary key,
	[Name] nvarchar(60)	
)

create table Offices
(
	OfficeNumber int PRIMARY KEY,
	[Address] nvarchar(30),
	Phone varchar(15),
	DeptID varchar(15) FOREIGN KEY REFERENCES Departments(DeptID)
)
create table Employees
(
	EmployeeID int PRIMARY KEY,
	FullName nvarchar(50),
	OfficeNumber int FOREIGN KEY REFERENCES Offices(OfficeNumber)
)

create table WorkFor
(
	EmployeeID int FOREIGN KEY REFERENCES Employees(EmployeeID),
	DeptID varchar(15) FOREIGN KEY REFERENCES Departments(DeptID),
	[From] DATE ,
	Salary float,
	[To] DATE
	PRIMARY KEY(EmployeeID, DeptID, [From]),
	

)