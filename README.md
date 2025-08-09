# PLP-WEEK-8
This Library Management System is a relational database designed in MySQL to manage a typical library's operations. It stores data about:

Members: Library users who borrow books.

Staff: Employees who manage library activities.

Books: The collection of books available in the library.

Authors: Information about book authors.

Genres: Categories or genres of books.

Borrowings: Records of which members borrowed which books, including borrow date, due date, return date, and staff who processed the transaction.

BookAuthors: A many-to-many relationship table linking books to their authors.

The database enforces data integrity via primary keys, foreign keys, unique constraints, and data validation checks. This project supports managing relationships among entities, tracking loans, and ensuring consistent and accurate library records.


How to Set Up / Run the Project
Prerequisites:

Install MySQL Server (version 5.7+ recommended, ideally 8.0+).

Have a MySQL client tool (such as MySQL Workbench, phpMyAdmin, or command-line client).

Steps to Import SQL Script:

Save the provided SQL script (the full create statements for tables, constraints, and sample inserts) into a file named, for example, library_management_system.sql.

Open your MySQL client and connect to your MySQL server.

Create a new database schema:

sql
CREATE DATABASE LibraryDB;
USE LibraryDB;
Import the SQL script by running the command (adjust path accordingly if using command line):

bash
mysql -u your_username -p LibraryDB < path/to/library_management_system.sql
Or if using MySQL Workbench or phpMyAdmin, open the script file and execute it on the LibraryDB database.

After Import:

The tables will be created with all constraints and relationships.

Sample genre data will be inserted.

You can now run queries to insert members, books, authors, and borrowings or modify the schema as needed.

Using the Database:

To add data: Use INSERT statements into Members, Staff, Books, Authors, etc.

To track borrowings: Insert records in the Borrowings table linking members and books.

To query data: Use SELECT statements joining tables for reports, availability checks, member history, etc.
