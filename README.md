The database is designed to facilitate the operations of a charity organization by managing various aspects such as donors, projects, donations, staff, expenses, events, and their relationships.

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

### Views:
- **DonationSummaryByProject:** This view summarizes donations per project, showing the project title, description, total number of donations, and the total amount donated.
- **TotalDonationsByDonor:** This view summarizes donations by each donor, displaying the total number of donations and the total amount donated by each donor.
- **OrphanDonorDetails:** This view provides details of orphans and their associated donors, including the orphan's first name, last name, age, and the donor's first and last names.
- **ProjectExpensesSummary:** This view summarizes expenses per project, showing the project title, total number of expenses, and the total amount spent.

Overall, this database provides a comprehensive platform for managing the activities and resources of a charity organization, including donor management, project tracking, staff management, expense tracking, and event organization.
