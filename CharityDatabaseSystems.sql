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
);
GO

-- Set Compatibility Level
ALTER DATABASE [CharityDB] SET COMPATIBILITY_LEVEL = 150;
GO

-- Enable Full-Text Search if Installed
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
BEGIN
    EXEC [CharityDB].[dbo].[sp_fulltext_database] @action = 'enable';
END;
GO

-- Configure Database Settings
ALTER DATABASE [CharityDB] SET AUTO_CLOSE OFF;
ALTER DATABASE [CharityDB] SET AUTO_SHRINK OFF;
ALTER DATABASE [CharityDB] SET RECOVERY FULL;
ALTER DATABASE [CharityDB] SET MULTI_USER;
ALTER DATABASE [CharityDB] SET PAGE_VERIFY CHECKSUM;
ALTER DATABASE [CharityDB] SET TARGET_RECOVERY_TIME = 60 SECONDS;
ALTER DATABASE [CharityDB] SET AUTO_UPDATE_STATISTICS ON;
ALTER DATABASE [CharityDB] SET QUERY_STORE = ON;
GO

USE [CharityDB];
GO

-- Create Donors Table
CREATE TABLE [dbo].[Donors] (
    [DonorID] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [FirstName] NVARCHAR(50) NOT NULL,
    [LastName] NVARCHAR(50) NOT NULL,
    [Email] NVARCHAR(100) NOT NULL UNIQUE,
    [PhoneNumber] NVARCHAR(15) NULL
);
GO

-- Create Projects Table
CREATE TABLE [dbo].[Projects] (
    [ProjectID] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [Title] NVARCHAR(100) NOT NULL,
    [Description] NVARCHAR(MAX) NULL,
    [StartDate] DATE NOT NULL,
    [EndDate] DATE NULL CHECK (EndDate >= StartDate)
);
GO

-- Create Donations Table
CREATE TABLE [dbo].[Donations] (
    [DonationID] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [DonorID] INT NOT NULL,
    [ProjectID] INT NOT NULL,
    [Amount] DECIMAL(10, 2) NOT NULL CHECK (Amount > 0),
    [DonationDate] DATE NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Donations_Donors FOREIGN KEY ([DonorID])
        REFERENCES [dbo].[Donors] ([DonorID]) ON DELETE CASCADE,
    CONSTRAINT FK_Donations_Projects FOREIGN KEY ([ProjectID])
        REFERENCES [dbo].[Projects] ([ProjectID]) ON DELETE CASCADE
);
GO

-- Create Volunteers Table
CREATE TABLE [dbo].[Volunteers] (
    [VolunteerID] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [FirstName] NVARCHAR(50) NOT NULL,
    [LastName] NVARCHAR(50) NOT NULL,
    [Email] NVARCHAR(100) NOT NULL UNIQUE,
    [PhoneNumber] NVARCHAR(15) NULL,
    [JoinedDate] DATE NOT NULL DEFAULT GETDATE()
);
GO

-- Add Indexes for Performance Optimization
CREATE INDEX IDX_Donations_DonorID ON [dbo].[Donations] ([DonorID]);
CREATE INDEX IDX_Donations_ProjectID ON [dbo].[Donations] ([ProjectID]);
GO

-- Create Donation Summary View
CREATE VIEW [dbo].[DonationSummaryByProject] AS
SELECT 
    p.ProjectID,
    p.Title AS ProjectTitle,
    COUNT(d.DonationID) AS TotalDonations,
    COALESCE(SUM(d.Amount), 0) AS TotalAmountDonated
FROM 
    [dbo].[Projects] p
LEFT JOIN 
    [dbo].[Donations] d ON p.ProjectID = d.ProjectID
GROUP BY 
    p.ProjectID, p.Title;
GO

-- Create Stored Procedure to Insert Donation with Validations
CREATE PROCEDURE [dbo].[InsertDonation]
    @DonorID INT,
    @ProjectID INT,
    @Amount DECIMAL(10, 2),
    @DonationDate DATE
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        -- Validate Donor
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Donors] WHERE [DonorID] = @DonorID)
        BEGIN
            THROW 50000, 'Invalid DonorID. Donor does not exist.', 1;
        END

        -- Validate Project
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Projects] WHERE [ProjectID] = @ProjectID)
        BEGIN
            THROW 50001, 'Invalid ProjectID. Project does not exist.', 1;
        END

        -- Insert Donation
        INSERT INTO [dbo].[Donations] ([DonorID], [ProjectID], [Amount], [DonationDate])
        VALUES (@DonorID, @ProjectID, @Amount, @DonationDate);
    END TRY
    BEGIN CATCH
        -- Log Error and Rethrow
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
        COALESCE(SUM(d.Amount), 0) AS TotalAmountDonated
    FROM 
        [dbo].[Projects] p
    LEFT JOIN 
        [dbo].[Donations] d ON p.ProjectID = d.ProjectID
    GROUP BY 
        p.ProjectID, p.Title;
END;
GO
