
DROP TABLE IF EXISTS BookAuthors;
DROP TABLE IF EXISTS Borrowings;
DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS Authors;
DROP TABLE IF EXISTS Members;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Genres;

-- Create table: Members (Library users who borrow books)
CREATE TABLE Members (
    memberID INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    joinDate DATE NOT NULL DEFAULT CURRENT_DATE,
    membershipStatus ENUM('Active', 'Inactive', 'Suspended') NOT NULL DEFAULT 'Active'
);

-- Create table: Staff (Employees managing the library)
CREATE TABLE Staff (
    staffID INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    hireDate DATE NOT NULL,
    position VARCHAR(50) NOT NULL
);

-- Create table: Genres (Book categories)
CREATE TABLE Genres (
    genreID INT AUTO_INCREMENT PRIMARY KEY,
    genreName VARCHAR(50) NOT NULL UNIQUE
);

-- Create table: Authors
CREATE TABLE Authors (
    authorID INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    birthDate DATE,
    bio TEXT
);

-- Create table: Books
CREATE TABLE Books (
    bookID INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    genreID INT NOT NULL,
    publishedYear YEAR,
    isbn VARCHAR(20) NOT NULL UNIQUE,
    copiesAvailable INT NOT NULL DEFAULT 1,
    CONSTRAINT fk_Books_Genres FOREIGN KEY (genreID) REFERENCES Genres(genreID)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE BookAuthors (
    bookID INT NOT NULL,
    authorID INT NOT NULL,
    PRIMARY KEY (bookID, authorID),
    CONSTRAINT fk_BookAuthors_Books FOREIGN KEY (bookID) REFERENCES Books(bookID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_BookAuthors_Authors FOREIGN KEY (authorID) REFERENCES Authors(authorID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Borrowings (
    borrowingID INT AUTO_INCREMENT PRIMARY KEY,
    memberID INT NOT NULL,
    bookID INT NOT NULL,
    borrowDate DATE NOT NULL DEFAULT CURRENT_DATE,
    dueDate DATE NOT NULL,
    returnDate DATE,
    staffID INT,  -- Staff who processed the borrowing
    CONSTRAINT fk_Borrowings_Members FOREIGN KEY (memberID) REFERENCES Members(memberID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_Borrowings_Books FOREIGN KEY (bookID) REFERENCES Books(bookID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_Borrowings_Staff FOREIGN KEY (staffID) REFERENCES Staff(staffID)
        ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT chk_dueDate CHECK (dueDate > borrowDate),
    CONSTRAINT chk_returnDate CHECK (returnDate IS NULL OR returnDate >= borrowDate)
);


INSERT INTO Genres (genreName) VALUES
('Fiction'),
('Non-Fiction'),
('Science Fiction'),
('Biography'),
('Mystery'),
('Fantasy'),
('History');

CREATE INDEX idx_books_genreID ON Books(genreID);
CREATE INDEX idx_borrowings_memberID ON Borrowings(memberID);
CREATE INDEX idx_borrowings_bookID ON Borrowings(bookID);
CREATE INDEX idx_borrowings_staffID ON Borrowings(staffID);

