USE [CharityDB]
GO
/****** Object:  Table [dbo].[Projects]    Script Date: 5/29/2024 5:09:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Projects](
	[ProjectID] [int] NOT NULL,
	[Title] [nvarchar](100) NULL,
	[Description] [nvarchar](max) NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Donations]    Script Date: 5/29/2024 5:09:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Donations](
	[DonationID] [int] NOT NULL,
	[DonorID] [int] NULL,
	[ProjectID] [int] NULL,
	[Amount] [decimal](10, 2) NULL,
	[DonationDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[DonationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[DonationSummaryByProject]    Script Date: 5/29/2024 5:09:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
/****** Object:  Table [dbo].[CashReceipts]    Script Date: 5/29/2024 5:09:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CashReceipts](
	[ReceiptNo] [int] NOT NULL,
	[DonationID] [int] NULL,
	[Amount] [decimal](10, 2) NULL,
	[ReceiptDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ReceiptNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Donors]    Script Date: 5/29/2024 5:09:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Donors](
	[DonorID] [int] NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Email] [nvarchar](100) NULL,
	[Phone] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[DonorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventAttendees]    Script Date: 5/29/2024 5:09:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventAttendees](
	[EventID] [int] NOT NULL,
	[AttendeeID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EventID] ASC,
	[AttendeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Events]    Script Date: 5/29/2024 5:09:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Events](
	[EventID] [int] NOT NULL,
	[Title] [nvarchar](100) NULL,
	[Description] [nvarchar](max) NULL,
	[Location] [nvarchar](100) NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[EventID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Expenses]    Script Date: 5/29/2024 5:09:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Expenses](
	[ExpenseID] [int] NOT NULL,
	[StaffID] [int] NULL,
	[Description] [nvarchar](max) NULL,
	[Amount] [decimal](10, 2) NULL,
	[ExpenseDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ExpenseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orphans]    Script Date: 5/29/2024 5:09:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orphans](
	[OrphanID] [int] NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Age] [int] NULL,
	[Gender] [nvarchar](10) NULL,
	[DonorID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrphanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pledges]    Script Date: 5/29/2024 5:09:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pledges](
	[PledgeID] [int] NOT NULL,
	[DonorID] [int] NULL,
	[ProjectID] [int] NULL,
	[PledgeAmount] [decimal](10, 2) NULL,
	[PledgeDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[PledgeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 5/29/2024 5:09:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[StaffID] [int] NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Email] [nvarchar](100) NULL,
	[Phone] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[StaffID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VolunteerAssignments]    Script Date: 5/29/2024 5:09:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VolunteerAssignments](
	[AssignmentID] [int] NOT NULL,
	[VolunteerID] [int] NULL,
	[ProjectID] [int] NULL,
	[AssignmentDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[AssignmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Volunteers]    Script Date: 5/29/2024 5:09:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Volunteers](
	[VolunteerID] [int] NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Email] [nvarchar](100) NULL,
	[Phone] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[VolunteerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CashReceipts]  WITH CHECK ADD FOREIGN KEY([DonationID])
REFERENCES [dbo].[Donations] ([DonationID])
GO
ALTER TABLE [dbo].[Donations]  WITH CHECK ADD FOREIGN KEY([DonorID])
REFERENCES [dbo].[Donors] ([DonorID])
GO
ALTER TABLE [dbo].[Donations]  WITH CHECK ADD FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Projects] ([ProjectID])
GO
ALTER TABLE [dbo].[EventAttendees]  WITH CHECK ADD FOREIGN KEY([AttendeeID])
REFERENCES [dbo].[Donors] ([DonorID])
GO
ALTER TABLE [dbo].[EventAttendees]  WITH CHECK ADD FOREIGN KEY([EventID])
REFERENCES [dbo].[Events] ([EventID])
GO
ALTER TABLE [dbo].[Expenses]  WITH CHECK ADD FOREIGN KEY([StaffID])
REFERENCES [dbo].[Staff] ([StaffID])
GO
ALTER TABLE [dbo].[Orphans]  WITH CHECK ADD FOREIGN KEY([DonorID])
REFERENCES [dbo].[Donors] ([DonorID])
GO
ALTER TABLE [dbo].[Pledges]  WITH CHECK ADD FOREIGN KEY([DonorID])
REFERENCES [dbo].[Donors] ([DonorID])
GO
ALTER TABLE [dbo].[Pledges]  WITH CHECK ADD FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Projects] ([ProjectID])
GO
ALTER TABLE [dbo].[VolunteerAssignments]  WITH CHECK ADD FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Projects] ([ProjectID])
GO
ALTER TABLE [dbo].[VolunteerAssignments]  WITH CHECK ADD FOREIGN KEY([VolunteerID])
REFERENCES [dbo].[Volunteers] ([VolunteerID])
GO
/****** Object:  StoredProcedure [dbo].[FetchDataByDate]    Script Date: 5/29/2024 5:09:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FetchDataByDate]
    @Date DATE
AS
BEGIN
    SELECT * FROM Donations WHERE DonationDate = @Date
    UNION ALL
    SELECT * FROM Expenses WHERE ExpenseDate = @Date
END
GO
/****** Object:  StoredProcedure [dbo].[FetchDataByDonorAndProject]    Script Date: 5/29/2024 5:09:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FetchDataByDonorAndProject]
    @DonorID INT,
    @ProjectID INT
AS
BEGIN
    SELECT * FROM Donations WHERE DonorID = @DonorID AND ProjectID = @ProjectID
END
GO
/****** Object:  StoredProcedure [dbo].[FetchDataByDonorID]    Script Date: 5/29/2024 5:09:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FetchDataByDonorID]
    @DonorID INT
AS
BEGIN
    SELECT * FROM Donations WHERE DonorID = @DonorID
END
GO
/****** Object:  StoredProcedure [dbo].[FetchDataByEmail]    Script Date: 5/29/2024 5:09:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FetchDataByEmail]
    @Email NVARCHAR(100)
AS
BEGIN
    SELECT * FROM Donations WHERE DonorID IN (SELECT DonorID FROM Donors WHERE Email = @Email)
END
GO
/****** Object:  StoredProcedure [dbo].[FetchDataByProjectID]    Script Date: 5/29/2024 5:09:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FetchDataByProjectID]
    @ProjectID INT
AS
BEGIN
    SELECT * FROM Donations WHERE ProjectID = @ProjectID
END
GO
/****** Object:  StoredProcedure [dbo].[FetchDonationDetailsByAmountRange]    Script Date: 5/29/2024 5:09:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FetchDonationDetailsByAmountRange]
    @MinAmount DECIMAL(10,2),
    @MaxAmount DECIMAL(10,2)
AS
BEGIN
    SELECT 
        d.DonationID,
        d.Amount AS DonationAmount,
        d.DonationDate,
        dn.Name AS DonorName,
        dn.Email AS DonorEmail,
        p.Title AS ProjectTitle,
        p.Description AS ProjectDescription
    FROM 
        Donations d
    INNER JOIN 
        Donors dn ON d.DonorID = dn.DonorID
    INNER JOIN 
        Projects p ON d.ProjectID = p.ProjectID
    WHERE 
        d.Amount BETWEEN @MinAmount AND @MaxAmount
END
GO
/****** Object:  StoredProcedure [dbo].[FetchDonationsBetweenDates]    Script Date: 5/29/2024 5:09:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FetchDonationsBetweenDates]
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SELECT * FROM Donations WHERE DonationDate BETWEEN @StartDate AND @EndDate
END
GO
/****** Object:  StoredProcedure [dbo].[GetDetailedDonationReport]    Script Date: 5/29/2024 5:09:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedure to Get Detailed Donation Report
CREATE PROCEDURE [dbo].[GetDetailedDonationReport]
    @donorID INT
AS
BEGIN
    SELECT 
        d.DonationID,
        d.DonationDate,
        d.Amount,
        d.CashReceiptNo,
        dn.Name AS DonorName,
        p.ProjectName,
        o.OrphanID,
        o.Name AS OrphanName
    FROM Donations d
    JOIN Donors dn ON d.DonorID = dn.DonorID
    JOIN Projects p ON d.ProjectID = p.ProjectID
    LEFT JOIN OrphanProjects op ON p.ProjectID = op.ProjectID
    LEFT JOIN Orphan o ON op.OrphanID = o.OrphanID
    WHERE d.DonorID = @donorID
    ORDER BY d.DonationDate DESC;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetDonationsByAmount]    Script Date: 5/29/2024 5:09:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedure to Fetch Data Amount-wise
CREATE PROCEDURE [dbo].[GetDonationsByAmount]
    @minAmount DECIMAL(10, 2),
    @maxAmount DECIMAL(10, 2)
AS
BEGIN
    SELECT d.DonationID, d.DonationDate, d.Amount, d.CashReceiptNo, dn.Name AS DonorName
    FROM Donations d
    JOIN Donors dn ON d.DonorID = dn.DonorID
    WHERE d.Amount BETWEEN @minAmount AND @maxAmount;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetDonationsByDonorName]    Script Date: 5/29/2024 5:09:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedure to Fetch Data by Donor Name
CREATE PROCEDURE [dbo].[GetDonationsByDonorName]
    @donorName VARCHAR(100)
AS
BEGIN
    SELECT d.DonationID, d.DonationDate, d.Amount, d.CashReceiptNo, dn.Name AS DonorName
    FROM Donations d
    JOIN Donors dn ON d.DonorID = dn.DonorID
    WHERE dn.Name = @donorName;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetDonationsByEmail]    Script Date: 5/29/2024 5:09:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedure to Fetch Data Email-wise
CREATE PROCEDURE [dbo].[GetDonationsByEmail]
    @donorEmail VARCHAR(100)
AS
BEGIN
    SELECT d.DonationID, d.DonationDate, d.Amount, d.CashReceiptNo, dn.Name AS DonorName
    FROM Donations d
    JOIN Donors dn ON d.DonorID = dn.DonorID
    WHERE dn.Email = @donorEmail;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetDonationSummary]    Script Date: 5/29/2024 5:09:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedure to Get Donation Summary
CREATE PROCEDURE [dbo].[GetDonationSummary]
AS
BEGIN
    SELECT 
        d.DonorID,
        dn.Name AS DonorName,
        d.ProjectID,
        p.ProjectName,
        COUNT(d.DonationID) AS DonationCount,
        SUM(d.Amount) AS TotalAmount
    FROM Donations d
    JOIN Donors dn ON d.DonorID = dn.DonorID
    JOIN Projects p ON d.ProjectID = p.ProjectID
    GROUP BY d.DonorID, d.ProjectID, dn.Name, p.ProjectName;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetEventParticipationSummary]    Script Date: 5/29/2024 5:09:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedure to Get Event Participation Summary
CREATE PROCEDURE [dbo].[GetEventParticipationSummary]
AS
BEGIN
    SELECT 
        o.OrphanID,
        o.Name AS OrphanName,
        COUNT(ep.EventID) AS EventCount,
        SUM(e.Budget) AS TotalEventBudget
    FROM EventParticipants ep
    JOIN Orphan o ON ep.OrphanID = o.OrphanID
    JOIN Events e ON ep.EventID = e.EventID
    GROUP BY o.OrphanID, o.Name;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetOrphansBySponsor]    Script Date: 5/29/2024 5:09:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedure to Get Orphans by Sponsor
CREATE PROCEDURE [dbo].[GetOrphansBySponsor]
    @sponsorName VARCHAR(100),
    @startDate DATE,
    @endDate DATE
AS
BEGIN
    SELECT 
        sp.SponsorID,
        sp.Name AS SponsorName,
        o.OrphanID,
        o.Name AS OrphanName,
        s.StartDate,
        s.EndDate,
        s.Amount
    FROM Sponsorships s
    JOIN Sponsors sp ON s.SponsorID = sp.SponsorID
    JOIN Orphan o ON s.OrphanID = o.OrphanID
    WHERE sp.Name = @sponsorName
      AND s.StartDate >= @startDate
      AND (s.EndDate <= @endDate OR s.EndDate IS NULL);
END;
GO
/****** Object:  StoredProcedure [dbo].[GetOrphanSponsorshipDetails]    Script Date: 5/29/2024 5:09:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedure to Get Orphan Sponsorship Details
CREATE PROCEDURE [dbo].[GetOrphanSponsorshipDetails]
    @orphanID INT
AS
BEGIN
    SELECT 
        o.OrphanID,
        o.Name AS OrphanName,
        sp.Name AS SponsorName,
        s.StartDate,
        s.EndDate,
        s.Amount,
        DATEDIFF(DAY, s.StartDate, ISNULL(s.EndDate, GETDATE())) AS SponsorshipDuration
    FROM Sponsorships s
    JOIN Sponsors sp ON s.SponsorID = sp.SponsorID
    JOIN Orphan o ON s.OrphanID = o.OrphanID
    WHERE o.OrphanID = @orphanID
    ORDER BY s.StartDate DESC;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetVolunteerAssignmentDetails]    Script Date: 5/29/2024 5:09:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedure to Get Volunteer Assignment Details
CREATE PROCEDURE [dbo].[GetVolunteerAssignmentDetails]
    @volunteerID INT
AS
BEGIN
    SELECT 
        v.VolunteerID,
        v.Name AS VolunteerName,
        p.ProjectID,
        p.ProjectName,
        va.StartDate,
        va.EndDate,
        DATEDIFF(DAY, va.StartDate, ISNULL(va.EndDate, GETDATE())) AS AssignmentDuration
    FROM VolunteerAssignments va
    JOIN Volunteers v ON va.VolunteerID = v.VolunteerID
    JOIN Projects p ON va.ProjectID = p.ProjectID
    WHERE v.VolunteerID = @volunteerID;
END;
GO
