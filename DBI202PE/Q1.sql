create table Roles
(
	RoleID int PRIMARY KEY,
	[name] nvarchar(100)
)

create table Users
(
	Username varchar(30) PRIMARY KEY,
	[Password] nvarchar(20),
	Email nvarchar(200),
	RoleID int FOREIGN KEY REFERENCES Roles(RoleID)
)

create table [Permissions]
(
	permissionID int primary key,
	name nvarchar(50)
)

create table [hasPermission]
(
	permissionID int FOREIGN KEY REFERENCES [Permissions](permissionID),
	RoleID int FOREIGN KEY REFERENCES [Roles](RoleID),
	PRIMARY KEY(permissionID, RoleID)
)