USE [master]
GO

-- Create CharityDB Databases
CREATE DATABASE [CharityDB]
CONTAINMENT = NONE
ON  PRIMARY 
( 
    NAME = N'CharityDB', 
    FILENAME = N'C:\.mdf', 
    SIZE = 8192KB, 
    MAXSIZE = UNLIMITED, 
    FILEGROWTH = 65536KB 
)
LOG ON 
( 
    NAME = N'CharityDB_log', 
    FILENAME = N'C:\.ldf', 
    SIZE = 8192KB, 
    MAXSIZE = 2048GB, 
    FILEGROWTH = 65536KB 
)
WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO

-- Database Configuration
ALTER DATABASE [CharityDB] SET COMPATIBILITY_LEVEL = 150
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
BEGIN
    EXEC [CharityDB].[dbo].[sp_fulltext_database] @action = 'enable'
END
GO

ALTER DATABASE [CharityDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CharityDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CharityDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CharityDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CharityDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [CharityDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CharityDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CharityDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CharityDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CharityDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CharityDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CharityDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CharityDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CharityDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CharityDB] SET ENABLE_BROKER 
GO
ALTER DATABASE [CharityDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CharityDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CharityDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CharityDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CharityDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CharityDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CharityDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CharityDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CharityDB] SET MULTI_USER 
GO
ALTER DATABASE [CharityDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CharityDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CharityDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CharityDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CharityDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CharityDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [CharityDB] SET QUERY_STORE = OFF
GO

USE [CharityDB]
GO

-- Create Projects Table
CREATE TABLE [dbo].[Projects](
    [ProjectID] [int] IDENTITY(1,1) NOT NULL,
      NOT NULL,
    [Description] [nvarchar](max) NULL,
    [StartDate] [date] NULL,
    [EndDate] [date] NULL,
PRIMARY KEY CLUSTERED ([ProjectID] ASC)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

-- Create Donations Table
CREATE TABLE [dbo].[Donations](
    [DonationID] [int] IDENTITY(1,1) NOT NULL,
    [DonorID] [int] NOT NULL,
    [ProjectID] [int] NOT NULL,
    [Amount] [decimal](10, 2) NOT NULL,
    [DonationDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED ([DonationID] ASC)
) ON [PRIMARY]
GO

-- Create Volunteers Table
CREATE TABLE [dbo].[Volunteers](
    [VolunteerID] [int] IDENTITY(1,1) NOT NULL,
      NOT NULL,
      NOT NULL,
      NULL,
      NULL,
    [JoinedDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED ([VolunteerID] ASC)
) ON [PRIMARY]
GO

-- Create Sponsorships Table
CREATE TABLE [dbo].[Sponsorships](
    [SponsorshipID] [int] IDENTITY(1,1) NOT NULL,
    [SponsorID] [int] NOT NULL,
    [ProjectID] [int] NOT NULL,
    [Amount] [decimal](10, 2) NOT NULL,
    [StartDate] [date] NOT NULL,
    [EndDate] [date] NULL,
PRIMARY KEY CLUSTERED ([SponsorshipID] ASC)
) ON [PRIMARY]
GO

-- Create Campaigns Table
CREATE TABLE [dbo].[Campaigns](
    [CampaignID] [int] IDENTITY(1,1) NOT NULL,
      NOT NULL,
    [Description] [nvarchar](max) NULL,
    [StartDate] [date] NOT NULL,
    [EndDate] [date] NULL,
PRIMARY KEY CLUSTERED ([CampaignID] ASC)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

-- Create Beneficiaries Table
CREATE TABLE [dbo].[Beneficiaries](
    [BeneficiaryID] [int] IDENTITY(1,1) NOT NULL,
      NOT NULL,
      NOT NULL,
    [BirthDate] [date] NOT NULL,
      NOT NULL,
PRIMARY KEY CLUSTERED ([BeneficiaryID] ASC)
) ON [PRIMARY]
GO

-- Create Events Table
CREATE TABLE [dbo].[Events](
    [EventID] [int] IDENTITY(1,1) NOT NULL,
      NOT NULL,
    [Description] [nvarchar](max) NULL,
    [Location] [nvarchar](max) NULL,
    [StartDate] [date] NOT NULL,
    [EndDate] [date] NULL,
PRIMARY KEY CLUSTERED ([EventID] ASC)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

-- Create EventAttendees Table
CREATE TABLE [dbo].[EventAttendees](
    [EventID] [int] NOT NULL,
    [AttendeeID] [int] NOT NULL,
PRIMARY KEY CLUSTERED ([EventID] ASC, [AttendeeID] ASC),
FOREIGN KEY ([EventID]) REFERENCES [dbo].[Events] ([EventID]) ON DELETE CASCADE
) ON [PRIMARY]
GO

-- Create Expenses Table
CREATE TABLE [dbo].[Expenses](
    [ExpenseID] [int] IDENTITY(1,1) NOT NULL,
    [ProjectID] [int] NOT NULL,
    [Description] [nvarchar](max) NULL,
    [Amount] [decimal](10, 2) NOT NULL,
    [ExpenseDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED ([ExpenseID] ASC),
FOREIGN KEY ([ProjectID]) REFERENCES [dbo].[Projects] ([ProjectID]) ON DELETE CASCADE
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

-- Create Staff Table
CREATE TABLE [dbo].[Staff](
    [StaffID] [int] IDENTITY(1,1) NOT NULL,
      NOT NULL,
      NOT NULL,
      NULL,
PRIMARY KEY CLUSTERED ([StaffID] ASC)
) ON [PRIMARY]
GO

-- Foreign Key Constraints
ALTER TABLE [dbo].[Sponsorships] ADD CONSTRAINT [FK_Sponsorships_Sponsors] FOREIGN KEY ([SponsorID]) REFERENCES [dbo].[Donors] ([DonorID]) ON DELETE CASCADE
ALTER TABLE [dbo].[Sponsorships] ADD CONSTRAINT [FK_Sponsorships_Projects] FOREIGN KEY ([ProjectID]) REFERENCES [dbo].[Projects] ([ProjectID]) ON DELETE CASCADE
GO

-- Create DonationSummaryByProject View
CREATE VIEW [dbo].[DonationSummaryByProject] AS
SELECT 
    p.ProjectID,
    p.Title AS ProjectTitle,
    p.Description AS ProjectDescription,
    COUNT(d.DonationID) AS TotalDonations,
    SUM(d.Amount) AS TotalAmountDonated
FROM 
    Projects p
LEFT JOIN 
    Donations d ON p.ProjectID = d.ProjectID
GROUP BY 
    p.ProjectID, p.Title, p.Description;
GO

-- Create ProductReviews View
CREATE VIEW [dbo].[ProductReviews]
AS
SELECT p.Name AS ProductName, r.Rating, r.Comment
FROM [dbo].[Products] p
JOIN [dbo].[Reviews] r ON p.ProductID = r.ProductID;

-- Create UserOrderSummary View
CREATE VIEW [dbo].[UserOrderSummary]
AS
SELECT u.Username, o.OrderID, o.OrderDate, o.TotalAmount
FROM [dbo].[Users] u
JOIN [dbo].[Orders] o ON u.UserID = o.UserID;

-- Create CashReceipts Table
CREATE TABLE [dbo].[CashReceipts](
    [ReceiptNo] [int] IDENTITY(1,1) NOT NULL,
    [DonationID] [int] NOT NULL,
    [Amount] [decimal](10, 2) NOT NULL,
    [ReceiptDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED ([ReceiptNo] ASC)
) ON [PRIMARY]
GO

-- Create Donors Table
CREATE TABLE [dbo].[Donors](
    [DonorID] [int] IDENTITY(1,1) NOT NULL,
      NOT NULL,
      NOT NULL,
      NULL,
PRIMARY KEY CLUSTERED ([DonorID] ASC)
) ON [PRIMARY]
GO

-- Create EventAttendees Table
CREATE TABLE [dbo].[EventAttendees](
    [EventID] [int] NOT NULL,
    [AttendeeID] [int] NOT NULL,
PRIMARY KEY CLUSTERED ([EventID] ASC, [AttendeeID] ASC)
) ON [PRIMARY]
GO

-- Create Events Table
CREATE TABLE [dbo].[Events](
    [EventID] [int] IDENTITY(1,1) NOT NULL,
      NOT NULL,
    [Description] [nvarchar](max) NULL,
      NULL,
    [StartDate] [date] NULL,
    [EndDate] [date] NULL,
PRIMARY KEY CLUSTERED ([EventID] ASC)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

-- Create Expenses Table
CREATE TABLE [dbo].[Expenses](
    [ExpenseID] [int] IDENTITY(1,1) NOT NULL,
    [StaffID] [int] NOT NULL,
    [Description] [nvarchar](max) NULL,
    [Amount] [decimal](10, 2) NOT NULL,
    [ExpenseDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED ([ExpenseID] ASC)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

-- Create Orphans Table
CREATE TABLE [dbo].[Orphans](
    [OrphanID] [int] IDENTITY(1,1) NOT NULL,
      NOT NULL,
    [Age] [int] NULL,
      NULL,
    [DonorID] [int] NULL,
PRIMARY KEY CLUSTERED ([OrphanID] ASC)
) ON [PRIMARY]
GO

-- Create Pledges Table
CREATE TABLE [dbo].[Pledges](
    [PledgeID] [int] IDENTITY(1,1) NOT NULL,
    [DonorID] [int] NOT NULL,
    [ProjectID] [int] NOT NULL,
    [PledgeAmount] [decimal](10, 2) NOT NULL,
    [PledgeDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED ([PledgeID] ASC)
) ON [PRIMARY]
GO

-- Create Staff Table
CREATE TABLE [dbo].[Staff](
    [StaffID] [int] IDENTITY(1,1) NOT NULL,
      NOT NULL,
      NOT NULL,
      NULL,
PRIMARY KEY CLUSTERED ([StaffID] ASC)
) ON [PRIMARY]
GO

-- Foreign Key Constraints
ALTER TABLE [dbo].[Donations] ADD CONSTRAINT [FK_Donations_Donors] FOREIGN KEY ([DonorID]) REFERENCES [dbo].[Donors] ([DonorID]) ON DELETE CASCADE
ALTER TABLE [dbo].[Donations] ADD CONSTRAINT [FK_Donations_Projects] FOREIGN KEY ([ProjectID]) REFERENCES [dbo].[Projects] ([ProjectID]) ON DELETE CASCADE
ALTER TABLE [dbo].[CashReceipts] ADD CONSTRAINT [FK_CashReceipts_Donations] FOREIGN KEY ([DonationID]) REFERENCES [dbo].[Donations] ([DonationID]) ON DELETE CASCADE
ALTER TABLE [dbo].[EventAttendees] ADD CONSTRAINT [FK_EventAttendees_Events] FOREIGN KEY ([EventID]) REFERENCES [dbo].[Events] ([EventID]) ON DELETE CASCADE
ALTER TABLE [dbo].[Expenses] ADD CONSTRAINT [FK_Expenses_Staff] FOREIGN KEY ([StaffID]) REFERENCES [dbo].[Staff] ([StaffID]) ON DELETE CASCADE
ALTER TABLE [dbo].[Orphans] ADD CONSTRAINT [FK_Orphans_Donors] FOREIGN KEY ([DonorID]) REFERENCES [dbo].[Donors] ([DonorID]) ON DELETE SET NULL
ALTER TABLE [dbo].[Pledges] ADD CONSTRAINT [FK_Pledges_Donors] FOREIGN KEY ([DonorID]) REFERENCES [dbo].[Donors] ([DonorID]) ON DELETE CASCADE
ALTER TABLE [dbo].[Pledges] ADD CONSTRAINT [FK_Pledges_Projects] FOREIGN KEY ([ProjectID]) REFERENCES [dbo].[Projects] ([ProjectID]) ON DELETE CASCADE
GO

-- Stored Procedure to Insert Donation
CREATE PROCEDURE [dbo].[InsertDonation]
    @DonorID int,
    @ProjectID int,
    @Amount decimal(10, 2),
    @DonationDate date
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO [dbo].[Donations] ([DonorID], [ProjectID], [Amount], [DonationDate])
        VALUES (@DonorID, @ProjectID, @Amount, @DonationDate);
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO

-- Stored Procedure to Get Donation Summary
CREATE PROCEDURE [dbo].[GetDonationSummary]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        p.ProjectID,
        p.Title AS ProjectTitle,
        p.Description AS ProjectDescription,
        COUNT(d.DonationID) AS TotalDonations,
        SUM(d.Amount) AS TotalAmountDonated
    FROM 
        Projects p
    LEFT JOIN 
        Donations d ON p.ProjectID = d.ProjectID
    GROUP BY 
        p.ProjectID, p.Title, p.Description;
END
GO
-- Create Views
-- Create VolunteerSummary View
CREATE VIEW [dbo].[VolunteerSummary] AS
SELECT 
    VolunteerID,
    FirstName,
    LastName,
    Email,
    PhoneNumber,
    JoinedDate
FROM 
    Volunteers;
GO

-- Create SponsorshipSummary View
CREATE VIEW [dbo].[SponsorshipSummary] AS
SELECT 
    s.SponsorshipID,
    d.FirstName AS SponsorFirstName,
    d.LastName AS SponsorLastName,
    p.Title AS ProjectTitle,
    s.Amount,
    s.StartDate,
    s.EndDate
FROM 
    Sponsorships s
JOIN 
    Donors d ON s.SponsorID = d.DonorID
JOIN 
    Projects p ON s.ProjectID = p.ProjectID;
GO

-- Create CampaignSummary Views
CREATE VIEW [dbo].[CampaignSummary] AS
SELECT 
    CampaignID,
    Title,
    Description,
    StartDate,
    EndDate
FROM 
    Campaigns;
GO

-- Create BeneficiarySummary Views
CREATE VIEW [dbo].[BeneficiarySummary] AS
SELECT 
    BeneficiaryID,
    FirstName,
    LastName,
    BirthDate,
    Gender
FROM 
    Beneficiaries;
GO
-- DonationSummaryByProject Views
CREATE VIEW [dbo].[DonationSummaryByProject] AS
SELECT 
    p.ProjectID,
    p.Title AS ProjectTitle,
    p.Description AS ProjectDescription,
    COUNT(d.DonationID) AS TotalDonations,
    SUM(d.Amount) AS TotalAmountDonated
FROM 
    Projects p
LEFT JOIN 
    Donations d ON p.ProjectID = d.ProjectID
GROUP BY 
    p.ProjectID, p.Title, p.Description;
GO

-- TotalDonationsByDonor Views
CREATE VIEW [dbo].[TotalDonationsByDonor] AS
SELECT 
    d.DonorID,
    COUNT(dn.DonationID) AS TotalDonations,
    SUM(dn.Amount) AS TotalAmountDonated
FROM 
    Donors d
LEFT JOIN 
    Donations dn ON d.DonorID = dn.DonorID
GROUP BY 
    d.DonorID;
GO

-- OrphanDonorDetails Views
CREATE VIEW [dbo].[OrphanDonorDetails] AS
SELECT 
    o.OrphanID,
    o.FirstName AS OrphanFirstName,
    o.LastName AS OrphanLastName,
    o.Age,
    d.FirstName AS DonorFirstName,
    d.LastName AS DonorLastName
FROM 
    Orphans o
LEFT JOIN 
    Donors d ON o.DonorID = d.DonorID;
GO

-- ProjectExpensesSummary Views
CREATE VIEW [dbo].[ProjectExpensesSummary] AS
SELECT 
    p.ProjectID,
    p.Title AS ProjectTitle,
    COUNT(e.ExpenseID) AS TotalExpenses,
    SUM(e.Amount) AS TotalAmountSpent
FROM 
    Projects p
LEFT JOIN 
    Expenses e ON p.ProjectID = e.ProjectID
GROUP BY 
    p.ProjectID, p.Title;
GO
-- Stored Procedure to Insert Volunteer
CREATE PROCEDURE [dbo].[InsertVolunteer]
    @FirstName nvarchar(50),
    @LastName nvarchar(50),
    @Email nvarchar(100),
    @PhoneNumber nvarchar(15),
    @JoinedDate date
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO [dbo].[Volunteers] ([FirstName], [LastName], [Email], [PhoneNumber], [JoinedDate])
        VALUES (@FirstName, @LastName, @Email, @PhoneNumber, @JoinedDate);
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO

-- Stored Procedure to Insert Sponsorships
CREATE PROCEDURE [dbo].[InsertSponsorship]
    @SponsorID int,
    @ProjectID int,
    @Amount decimal(10, 2),
    @StartDate date,
    @EndDate date
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO [dbo].[Sponsorships] ([SponsorID], [ProjectID], [Amount], [StartDate], [EndDate])
        VALUES (@SponsorID, @ProjectID, @Amount, @StartDate, @EndDate);
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO

-- Stored Procedure to Insert Campaigns
CREATE PROCEDURE [dbo].[InsertCampaign]
    @Title nvarchar(100),
    @Description nvarchar(max),
    @StartDate date,
    @EndDate date
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO [dbo].[Campaigns] ([Title], [Description], [StartDate], [EndDate])
        VALUES (@Title, @Description, @StartDate, @EndDate);
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO

-- Stored Procedure to Insert Beneficiarys
CREATE PROCEDURE [dbo].[InsertBeneficiary]
    @FirstName nvarchar(50),
    @LastName nvarchar(50),
    @BirthDate date,
    @Gender char(1)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO [dbo].[Beneficiaries] ([FirstName], [LastName], [BirthDate], [Gender])
        VALUES (@FirstName, @LastName, @BirthDate, @Gender);
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO
-- Stored Procedure to Insert Event
CREATE PROCEDURE [dbo].[InsertEvent]
    @Title nvarchar(100),
    @Description nvarchar(max),
    @Location nvarchar(100),
    @StartDate date,
    @EndDate date
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO [dbo].[Events] ([Title], [Description], [Location], [StartDate], [EndDate])
        VALUES (@Title, @Description, @Location, @StartDate, @EndDate);
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO

-- Stored Procedure to Insert Orphan
CREATE PROCEDURE [dbo].[InsertOrphan]
    @FirstName nvarchar(50),
    @LastName nvarchar(50),
    @Age int,
    @Gender char(1),
    @DonorID int
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO [dbo].[Orphans] ([FirstName], [LastName], [Age], [Gender], [DonorID])
        VALUES (@FirstName, @LastName, @Age, @Gender, @DonorID);
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO

-- Stored Procedure to Insert Pledge
CREATE PROCEDURE [dbo].[InsertPledge]
    @DonorID int,
    @ProjectID int,
    @PledgeAmount decimal(10, 2),
    @PledgeDate date
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO [dbo].[Pledges] ([DonorID], [ProjectID], [PledgeAmount], [PledgeDate])
        VALUES (@DonorID, @ProjectID, @PledgeAmount, @PledgeDate);
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO

-- Stored Procedure to Update Project
CREATE PROCEDURE [dbo].[UpdateProject]
    @ProjectID int,
    @Title nvarchar(100),
    @Description nvarchar(max),
    @StartDate date,
    @EndDate date
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        UPDATE [dbo].[Projects]
        SET [Title] = @Title, 
            [Description] = @Description,
            [StartDate] = @StartDate,
            [EndDate] = @EndDate
        WHERE [ProjectID] = @ProjectID;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO
-- Stored Procedure to Update Donor
CREATE PROCEDURE [dbo].[UpdateDonor]
    @DonorID int,
    @FirstName nvarchar(50),
    @LastName nvarchar(50),
    @Email nvarchar(100),
    @PhoneNumber nvarchar(15)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        UPDATE [dbo].[Donors]
        SET [FirstName] = @FirstName, 
            [LastName] = @LastName,
            [Email] = @Email,
            [PhoneNumber] = @PhoneNumber
        WHERE [DonorID] = @DonorID;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO
-- Stored Procedure to Update Volunteer
CREATE PROCEDURE [dbo].[UpdateVolunteer]
    @VolunteerID int,
    @FirstName nvarchar(50),
    @LastName nvarchar(50),
    @Email nvarchar(100),
    @PhoneNumber nvarchar(15),
    @JoinedDate date
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        UPDATE [dbo].[Volunteers]
        SET [FirstName] = @FirstName, 
            [LastName] = @LastName,
            [Email] = @Email,
            [PhoneNumber] = @PhoneNumber,
            [JoinedDate] = @JoinedDate
        WHERE [VolunteerID] = @VolunteerID;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO
-- Stored Procedure to Update Sponsorship
CREATE PROCEDURE [dbo].[UpdateSponsorship]
    @SponsorshipID int,
    @SponsorID int,
    @ProjectID int,
    @Amount decimal(10, 2),
    @StartDate date,
    @EndDate date
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        UPDATE [dbo].[Sponsorships]
        SET [SponsorID] = @SponsorID, 
            [ProjectID] = @ProjectID,
            [Amount] = @Amount,
            [StartDate] = @StartDate,
            [EndDate] = @EndDate
        WHERE [SponsorshipID] = @SponsorshipID;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO
-- Stored Procedure to Delete Event
CREATE PROCEDURE [dbo].[DeleteEvent]
    @EventID int
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        DELETE FROM [dbo].[Events]
        WHERE [EventID] = @EventID;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO
-- Stored Procedure to Delete Expense
CREATE PROCEDURE [dbo].[DeleteExpense]
    @ExpenseID int
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        DELETE FROM [dbo].[Expenses]
        WHERE [ExpenseID] = @ExpenseID;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO
-- Stored Procedure to Delete Orphan
CREATE PROCEDURE [dbo].[DeleteOrphan]
    @OrphanID int
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        DELETE FROM [dbo].[Orphans]
        WHERE [OrphanID] = @OrphanID;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO
-- Stored Procedure to Delete Pledge
CREATE PROCEDURE [dbo].[DeletePledge]
    @PledgeID int
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        DELETE FROM [dbo].[Pledges]
        WHERE [PledgeID] = @PledgeID;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO
