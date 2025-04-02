-- Create CharityDB Database
USE [master];
GO
CREATE DATABASE [CharityDB]
ON PRIMARY 
(
    NAME = N'CharityDB',
    FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS03\MSSQL\DATA\CharityDB.mdf',
    SIZE = 8192KB, MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB
)
LOG ON 
(
    NAME = N'CharityDB_log',
    FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS03\MSSQL\DATA\CharityDB_log.ldf',
    SIZE = 8192KB, MAXSIZE = 2048GB, FILEGROWTH = 65536KB
);
GO

-- Set Compatibility Level & Configurations
ALTER DATABASE [CharityDB] SET COMPATIBILITY_LEVEL = 150;
ALTER DATABASE [CharityDB] SET AUTO_CLOSE OFF, AUTO_SHRINK OFF, RECOVERY FULL;
ALTER DATABASE [CharityDB] SET MULTI_USER, PAGE_VERIFY CHECKSUM, TARGET_RECOVERY_TIME = 60 SECONDS;
ALTER DATABASE [CharityDB] SET AUTO_UPDATE_STATISTICS ON, QUERY_STORE = ON;
GO

USE [CharityDB];
GO

-- Create Donors Table
CREATE TABLE [dbo].[Donors] (
    [DonorID] INT IDENTITY(1,1) PRIMARY KEY,
    [FirstName] NVARCHAR(50) NOT NULL,
    [LastName] NVARCHAR(50) NOT NULL,
    [Email] NVARCHAR(100) NOT NULL UNIQUE,
    [PhoneNumber] NVARCHAR(15) NULL
);
GO

-- Create Projects Table
CREATE TABLE [dbo].[Projects] (
    [ProjectID] INT IDENTITY(1,1) PRIMARY KEY,
    [Title] NVARCHAR(100) NOT NULL,
    [Description] NVARCHAR(MAX) NULL,
    [StartDate] DATE NOT NULL,
    [EndDate] DATE NULL CHECK (EndDate >= StartDate)
);
GO

-- Create Donations Table
CREATE TABLE [dbo].[Donations] (
    [DonationID] INT IDENTITY(1,1) PRIMARY KEY,
    [DonorID] INT NOT NULL,
    [ProjectID] INT NOT NULL,
    [Amount] DECIMAL(10,2) NOT NULL CHECK (Amount > 0),
    [DonationDate] DATE NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY ([DonorID]) REFERENCES [dbo].[Donors] ([DonorID]) ON DELETE CASCADE,
    FOREIGN KEY ([ProjectID]) REFERENCES [dbo].[Projects] ([ProjectID]) ON DELETE CASCADE
);
GO

-- Create Volunteers Table
CREATE TABLE [dbo].[Volunteers] (
    [VolunteerID] INT IDENTITY(1,1) PRIMARY KEY,
    [FirstName] NVARCHAR(50) NOT NULL,
    [LastName] NVARCHAR(50) NOT NULL,
    [Email] NVARCHAR(100) NOT NULL UNIQUE,
    [PhoneNumber] NVARCHAR(15) NULL,
    [JoinedDate] DATE NOT NULL DEFAULT GETDATE()
);
GO

-- Create Events Table
CREATE TABLE [dbo].[Events] (
    [EventID] INT IDENTITY(1,1) PRIMARY KEY,
    [EventName] NVARCHAR(100) NOT NULL,
    [EventDate] DATE NOT NULL,
    [Location] NVARCHAR(200) NOT NULL
);
GO

-- Create Volunteer Assignments Table
CREATE TABLE [dbo].[VolunteerAssignments] (
    [AssignmentID] INT IDENTITY(1,1) PRIMARY KEY,
    [VolunteerID] INT NOT NULL,
    [ProjectID] INT NOT NULL,
    [AssignmentDate] DATE NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY ([VolunteerID]) REFERENCES [dbo].[Volunteers]([VolunteerID]),
    FOREIGN KEY ([ProjectID]) REFERENCES [dbo].[Projects]([ProjectID])
);
GO

-- Create Views
CREATE VIEW [dbo].[DonationDetailsView] AS
SELECT 
    d.DonationID, d.DonorID, don.FirstName + ' ' + don.LastName AS DonorName,
    d.ProjectID, p.Title AS ProjectTitle, d.Amount, d.DonationDate
FROM [dbo].[Donations] d
JOIN [dbo].[Donors] don ON d.DonorID = don.DonorID
JOIN [dbo].[Projects] p ON d.ProjectID = p.ProjectID;
GO

-- Stored Procedure: Insert Donation
CREATE PROCEDURE [dbo].[InsertDonation]
    @DonorID INT, @ProjectID INT, @Amount DECIMAL(10,2), @DonationDate DATE
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM [dbo].[Donors] WHERE DonorID = @DonorID)
        THROW 50000, 'Invalid DonorID.', 1;
    IF NOT EXISTS (SELECT 1 FROM [dbo].[Projects] WHERE ProjectID = @ProjectID)
        THROW 50001, 'Invalid ProjectID.', 1;
    INSERT INTO [dbo].[Donations] (DonorID, ProjectID, Amount, DonationDate)
    VALUES (@DonorID, @ProjectID, @Amount, @DonationDate);
END;
GO

-- Stored Procedure: Get Donor Details
CREATE PROCEDURE [dbo].[GetDonorDetails]
    @DonorID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM [dbo].[Donations] WHERE DonorID = @DonorID;
END;
GO

-- Stored Procedure: Assign Volunteer
CREATE PROCEDURE [dbo].[AssignVolunteerToProject]
    @VolunteerID INT, @ProjectID INT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO [dbo].[VolunteerAssignments] (VolunteerID, ProjectID, AssignmentDate)
    VALUES (@VolunteerID, @ProjectID, GETDATE());
END;
GO

-- Backup Job
USE [msdb];
GO
DECLARE @JobName NVARCHAR(128) = 'CharityDB_BackupJob';
IF NOT EXISTS (SELECT 1 FROM msdb.dbo.sysjobs WHERE name = @JobName)
BEGIN
    EXEC msdb.dbo.sp_add_job
        @job_name = @JobName,
        @enabled = 1,
        @notify_level_eventlog = 2,
        @owner_login_name = 'sa';
    
    EXEC msdb.dbo.sp_add_jobstep
        @job_name = @JobName,
        @step_name = 'Full Backup',
        @subsystem = 'TSQL',
        @command = N'BACKUP DATABASE CharityDB TO DISK = ''C:\Backups\CharityDB.bak'' WITH FORMAT, INIT;',
        @retry_attempts = 3,
        @retry_interval = 10;
    
    EXEC msdb.dbo.sp_add_schedule
        @schedule_name = 'DailyMidnightBackup',
        @freq_type = 4,
        @freq_interval = 1,
        @active_start_time = 000000;
    
    EXEC msdb.dbo.sp_attach_schedule
        @job_name = @JobName,
        @schedule_name = 'DailyMidnightBackup';
END;
GO
