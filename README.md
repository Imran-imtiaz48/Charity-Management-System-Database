This database is designed to optimize operations for a charity organization, managing donors, projects, donations, staff, expenses, events, and their interconnected relationships.

### Donors:
The "Donors" table stores information about individuals or entities who contribute funds or resources to the charity organization. It includes details such as the donor's name, email, and phone number.

### Orphans:
The "Orphans" table represents beneficiaries of the charity organization, specifically orphaned children. It contains details such as the orphan's name, age, gender, and the ID of the donor who sponsors them.

### Projects:
The "Projects" table contains information about the charitable projects undertaken by the organization. It includes details such as the project title, description, start date, and end date.

### Donations:
The "Donations" table tracks all contributions made by donors to specific projects. It includes details such as the donation amount, donation date, and references to the donor and project involved.

### CashReceipts:
The "CashReceipts" table records receipts issued for cash donations received by the organization. It contains details such as the receipt number, donation ID, amount, and receipt date.

### Staff:
The "Staff" table stores information about the organization's staff members who are employed to manage various operations. It includes details such as the staff member's name, email, and phone number.

### Expenses:
The "Expenses" table records all expenses incurred by the organization. It includes details such as the expense description, amount, date, and references to the staff member responsible for the expense.

### Events:
The "Events" table represents various events organized by the charity organization, such as fundraising galas or charity auctions. It includes details such as the event title, description, start date, and end date.

### EventAttendees:
The "EventAttendees" table establishes a many-to-many relationship between events and attendees (who are donors). It tracks which donors attended which events.

### Pledges:
The "Pledges" table tracks commitments made by donors to contribute specific amounts to certain projects. It includes details such as the pledge amount, pledge date, and references to the donor and project involved.

### Volunteers:
The "Volunteers" table stores information about individuals who offer their time and skills to support the charity's activities. It includes details such as the volunteer's name, email, phone number, and the date they joined the organization.

### Sponsorships:
The "Sponsorships" table records sponsorship agreements between donors and projects. It includes details such as the sponsorship amount, start date, end date, and references to the donor and project involved.

### Campaigns:
The "Campaigns" table contains information about fundraising campaigns organized by the charity. It includes details such as the campaign title, description, start date, and end date.

### Beneficiaries:
The "Beneficiaries" table records information about individuals who receive aid from the charity. It includes details such as the beneficiary's name, birth date, gender, and the donor associated with their support.

### Views:
- **DonationSummaryByProject:** This view summarizes donations per project, showing the project title, description, total number of donations, and the total amount donated.
- **TotalDonationsByDonor:** This view summarizes donations by each donor, displaying the total number of donations and the total amount donated by each donor.
- **OrphanDonorDetails:** This view provides details of orphans and their associated donors, including the orphan's first name, last name, age, and the donor's first and last names.
- **ProjectExpensesSummary:** This view summarizes expenses per project, showing the project title, total number of expenses, and the total amount spent.
- **VolunteerSummary:** This view provides a summary of volunteers, including their name, email, phone number, and the date they joined the organization.
- **SponsorshipSummary:** This view summarizes sponsorships, including the sponsorship amount, start date, end date, and the names of the sponsor and the project.
- **CampaignSummary:** This view summarizes campaigns, including the campaign title, description, start date, and end date.
- **BeneficiarySummary:** This view provides a summary of beneficiaries, including their name, birth date, and gender.

Stored Procedures:
-- InsertDonation: Adds a new donation record to the "Donations" table.
-- GetDonationSummary: Fetches a summary of donations grouped by project.
-- InsertVolunteer: Registers a new volunteer in the "Volunteers" table.
-- InsertSponsorship: Records a new sponsorship entry in the "Sponsorships" table.
-- InsertCampaign: Logs a new campaign entry in the "Campaigns" table.
-- InsertBeneficiary: Enters a new beneficiary record into the "Beneficiaries" table.

In essence, this database provides a holistic platform to manage operations and resources within a charity organization. It includes donor management, project tracking, staff supervision, expense monitoring, event planning, and volunteer coordination.
