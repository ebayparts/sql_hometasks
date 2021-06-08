CREATE DATABASE Academy;

-- DROP DATABASE PublicBank;

USE Academy;
go
CREATE TABLE Groups
(
	Id int PRIMARY KEY IDENTITY(1, 1),
	Name nvarchar(10) UNIQUE NOT NULL check(Name <> ''),
	Rating int NOT NULL check(Rating BETWEEN 0 AND 5),
	[Year] int NOT NULL check([Year] BETWEEN 0 AND 5),
);

CREATE TABLE Departments
(
	Id int PRIMARY KEY IDENTITY(1, 1),
	Financing money NOT NULL check(Financing >= 0) default('0'),
	Name nvarchar(100) UNIQUE NOT NULL check(Name <> ''),
);

CREATE TABLE Faculties
(
	Id int PRIMARY KEY IDENTITY(1, 1),
	Name nvarchar(100) NOT NULL check(Name <> ''),
);

CREATE TABLE Teachers
(
	Id int PRIMARY KEY IDENTITY(1, 1),
	EmploymentDate date NOT NULL check(EmploymentDate >= '01.01.1990'),
	[Name] nvarchar(MAX) NOT NULL check(Name <> ''),
	Premium money NOT NULL check(Premium >= 0) default('0'),
	Salary money NOT NULL check(Salary > 0),
	Surname nvarchar(MAX) NOT NULL check (Surname <> ''),
);
