create table Staff
(
	StaffID int PRIMARY KEY,
	[Name] nvarchar(100)
)

create table Logins
(
	username nvarchar(50) PRIMARY KEY,
	[Password] nvarchar(265),
	[Role] nvarchar(100),
	StaffID INT FOREIGN KEY REFERENCES Staff(StaffID)
)
create table Reports
(
	ReportNumber int PRIMARY KEY,
	[Date] DATE,
	issueReturn nvarchar(200),
	username nvarchar(50) FOREIGN KEY REFERENCES Logins(username)
)