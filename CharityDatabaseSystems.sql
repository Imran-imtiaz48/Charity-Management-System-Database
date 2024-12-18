USE [master];
GO

-- Create CharityDB Database
CREATE DATABASE [CharityDB]
CONTAINMENT = NONE
ON PRIMARY 
(
    NAME = N'CharityDB',
    FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS03\MSSQL\DATA\CharityDB.mdf',
    SIZE = 8192KB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 65536KB
)
LOG ON 
(
    NAME = N'CharityDB_log',
    FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS03\MSSQL\DATA\CharityDB_log.ldf',
    SIZE = 8192KB,
    MAXSIZE = 2048GB,
    FILEGROWTH = 65536KB
)
WITH CATALOG_COLLATION = DATABASE_DEFAULT;
GO

-- Set Compatibility Level
ALTER DATABASE [CharityDB] SET COMPATIBILITY_LEVEL = 150;
GO

-- Enable Full-Text Search if Installed
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
BEGIN
    EXEC [CharityDB].[dbo].[sp_fulltext_database] @action = 'enable';
END
GO

-- Configure Database Settings
ALTER DATABASE [CharityDB] SET AUTO_CLOSE OFF;
ALTER DATABASE [CharityDB] SET AUTO_SHRINK OFF;
ALTER DATABASE [CharityDB] SET RECOVERY SIMPLE;
ALTER DATABASE [CharityDB] SET MULTI_USER;
ALTER DATABASE [CharityDB] SET PAGE_VERIFY CHECKSUM;
ALTER DATABASE [CharityDB] SET TARGET_RECOVERY_TIME = 60 SECONDS;
ALTER DATABASE [CharityDB] SET AUTO_UPDATE_STATISTICS ON;
ALTER DATABASE [CharityDB] SET QUERY_STORE = OFF;
GO

USE [CharityDB];
GO

-- Create Projects Table
CREATE TABLE [dbo].[Projects] (
    [ProjectID] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [Title] NVARCHAR(100) NOT NULL,
    [Description] NVARCHAR(MAX) NULL,
    [StartDate] DATE NULL,
    [EndDate] DATE NULL
);
GO

-- Create Donations Table
CREATE TABLE [dbo].[Donations] (
    [DonationID] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [DonorID] INT NOT NULL,
    [ProjectID] INT NOT NULL,
    [Amount] DECIMAL(10, 2) NOT NULL,
    [DonationDate] DATE NOT NULL
);
GO

-- Create Volunteers Table
CREATE TABLE [dbo].[Volunteers] (
    [VolunteerID] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [FirstName] NVARCHAR(50) NOT NULL,
    [LastName] NVARCHAR(50) NOT NULL,
    [Email] NVARCHAR(100) NOT NULL,
    [PhoneNumber] NVARCHAR(15) NULL,
    [JoinedDate] DATE NOT NULL
);
GO

-- Add Foreign Key Constraints
ALTER TABLE [dbo].[Donations]
ADD CONSTRAINT FK_Donations_Donors FOREIGN KEY ([DonorID])
REFERENCES [dbo].[Donors] ([DonorID]) ON DELETE CASCADE;

ALTER TABLE [dbo].[Donations]
ADD CONSTRAINT FK_Donations_Projects FOREIGN KEY ([ProjectID])
REFERENCES [dbo].[Projects] ([ProjectID]) ON DELETE CASCADE;
GO

-- Create Donation Summary View
CREATE VIEW [dbo].[DonationSummaryByProject] AS
SELECT 
    p.ProjectID,
    p.Title AS ProjectTitle,
    COUNT(d.DonationID) AS TotalDonations,
    SUM(d.Amount) AS TotalAmountDonated
FROM 
    [dbo].[Projects] p
LEFT JOIN 
    [dbo].[Donations] d ON p.ProjectID = d.ProjectID
GROUP BY 
    p.ProjectID, p.Title;
GO

-- Create Stored Procedure to Insert Donation
CREATE PROCEDURE [dbo].[InsertDonation]
    @DonorID INT,
    @ProjectID INT,
    @Amount DECIMAL(10, 2),
    @DonationDate DATE
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        INSERT INTO [dbo].[Donations] ([DonorID], [ProjectID], [Amount], [DonationDate])
        VALUES (@DonorID, @ProjectID, @Amount, @DonationDate);
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH;
END;
GO

-- Create Stored Procedure to Get Donation Summary
CREATE PROCEDURE [dbo].[GetDonationSummary]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        p.ProjectID,
        p.Title AS ProjectTitle,
        COUNT(d.DonationID) AS TotalDonations,
        SUM(d.Amount) AS TotalAmountDonated
    FROM 
        [dbo].[Projects] p
    LEFT JOIN 
        [dbo].[Donations] d ON p.ProjectID = d.ProjectID
    GROUP BY 
        p.ProjectID, p.Title;
END;
GO
