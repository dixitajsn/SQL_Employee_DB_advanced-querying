Set SEARCH_PATH to "DDL-DML", public;

-- Book table
CREATE TABLE Book (
 ISBN VARCHAR(13) PRIMARY KEY,
 title VARCHAR(255) NOT NULL,
 edition SMALLINT CHECK (edition >= 1),
 year SMALLINT CHECK (year >= 1800) NOT NULL
);

-- BookCopy table
CREATE TABLE BookCopy (
 copyNo SMALLINT PRIMARY KEY,
 ISBN VARCHAR(13) NOT NULL,
 available BOOLEAN NOT NULL,
 FOREIGN KEY (ISBN) REFERENCES Book(ISBN) ON DELETE CASCADE ON
UPDATE CASCADE
);

-- Borrower table
CREATE TABLE Borrower (
 borrowerNo SMALLINT PRIMARY KEY,
 borrowerName VARCHAR(255) NOT NULL,
 borrowerAddress VARCHAR(255)
);

-- BookLoan table
CREATE TABLE BookLoan (
 copyNo SMALLINT NOT NULL,
 dateOut DATE NOT NULL,
 dateDue DATE NOT NULL,
 borrowerNo SMALLINT NOT NULL,
 PRIMARY KEY (copyNo, dateOut),
 FOREIGN KEY (copyNo) REFERENCES BookCopy(copyNo) ON DELETE
RESTRICT ON UPDATE RESTRICT,
 FOREIGN KEY (borrowerNo) REFERENCES Borrower(borrowerNo) ON DELETE
RESTRICT ON UPDATE RESTRICT
);

-- Sample records for the Book table
INSERT INTO Book (ISBN, title, edition, year) VALUES
 ('9780451524935', '1984', 1, 1949),
 ('9780061120084', 'To Kill a Mockingbird', 1, 1960),
 ('9780141185035', 'The Great Gatsby', 2, 1925),
 ('9780452284234', 'Animal Farm', 1, 1945),
 ('9780060935467', 'Brave New World', 1, 1932);

-- Sample records for the BookCopy table
INSERT INTO BookCopy (copyNo, ISBN, available) VALUES
 (1, '9780451524935', false),
 (2, '9780451524935', false),
 (3, '9780061120084', false),
 (4, '9780141185035', false),
 (5, '9780452284234', false),
 (6, '9780060935467', true);

-- Sample records for the Borrower table
INSERT INTO Borrower (borrowerNo, borrowerName, borrowerAddress) VALUES
 (1, 'John Smith', '123 Main Street'),
 (2, 'Jane Doe', '456 Elm Avenue'),
 (3, 'David Johnson', '789 Oak Road'),
 (4, 'Emily Wilson', '321 Pine Lane'),
 (5, 'Michael Brown', '654 Birch Drive');

-- Sample records for the BookLoan table
INSERT INTO BookLoan (copyNo, dateOut, dateDue, borrowerNo) VALUES
 (1, '2023-10-01', '2023-10-15', 1),
 (3, '2023-10-02', '2023-10-23', 2),
 (5, '2023-10-03', '2023-10-24', 3),
 (2, '2023-10-04', '2023-10-25', 4),
 (4, '2023-10-05', '2023-10-26', 5);

SELECT * FROM Book;
SELECT * FROM BookCopy;
SELECT * FROM Borrower;
SELECT * FROM BookLoan;

-- (1) List all book titles.
SELECT title FROM Book;

-- (2) List all borrower details.
SELECT * FROM Borrower;

-- (3) List all books titles published between 1940 and 1960.
SELECT * FROM book
WHERE year BETWEEN '1940' AND '1960';

-- (4) List all book titles that have never been borrowed by any borrower.
SELECT * FROM BOOK
WHERE ISBN NOT IN (SELECT ISBN
FROM BOOKCOPY C, BOOKLOAN L
WHERE L.copyno=C.copyno);

-- (5) List all book titles that contain the word ‘Great’ and are available for loan.
SELECT b.ISBN, b.title, b.edition, b.year, c.available
FROM book b, bookcopy c
WHERE b.ISBN=c.ISBN AND b.title like '%Great%' AND c.available='true';

-- (6) List all book titles that contain the word ‘Brave’ and are available for loan.
SELECT b.ISBN, b.title, b.edition, b.year, c.available
FROM book b, bookcopy c
WHERE b.ISBN=c.ISBN AND b.title like '%Brave%' AND c.available='true';

-- (7) List the names of borrowers with overdue books.
SELECT borrowerName
From Borrower bw, BookLoan bl
WHERE bw.borrowerNo = bl.borrowerNo and dateDue < CURRENT_DATE;

-- (8) How many copies of each book title are there?
SELECT b.title, count (c.copyNo) AS numberOfcopies
FROM book b, bookcopy c
WHERE b.ISBN=c.ISBN
Group by b.title;

-- (9) How many copies of ISBN “9780060935467” are currently available?
SELECT COUNT(copyNo)
FROM BookCopy
WHERE available = true AND ISBN = '9780060935467';

-- (10) How many times has the book with ISBN “9780451524935” been borrowed?
SELECT COUNT(*)
FROM BookCopy bc, BookLoan bl
WHERE bc.copyNo = bl.copyNo AND ISBN = '9780451524935';

-- (11) Produce a report of book titles that have been borrowed by “John Smith”.
SELECT DISTINCT title
FROM Borrower bw, Book b, BookCopy bc, BookLoan bl
WHERE bw.borrowerNo = bl.borrowerNo AND bl.copyNo = bc.copyNo
AND bc.ISBN = b.ISBN AND borrowerName = 'John Smith';

-- (12) For each book title with 2 or more copies, list the names of library members who have borrowed them.
SELECT title, borrowerName
FROM Borrower bw, Book b, BookCopy bc, BookLoan bl
WHERE bw.borrowerNo = bl.borrowerNo AND bl.copyNo = bc.copyNo
AND bc.ISBN = b.ISBN AND EXISTS
(SELECT ISBN, COUNT(bc1.copyNo)
FROM BookCopy bc1
WHERE bc1.ISBN = bc.ISBN
GROUP BY bc1.ISBN
HAVING COUNT(bc1.copyNo) >=2 );

-- (13) Produce a report with the details of borrowers who currently have books overdue.
SELECT borrowerName, borrowerAddress
From Borrower bw, BookLoan bl
WHERE bw.borrowerNo = bl.borrowerNo and dateDue < CURRENT_DATE;

-- (14) Produce a report detailing how many times each book title has been borrowed.
SELECT ISBN, COUNT(*)
FROM BookCopy bc, BookLoan bl
WHERE bc.copyNo = bl.copyNo
GROUP BY ISBN;

-- (15) Remove all books published before 1930 from the database.
DELETE FROM book
WHERE year < 1930;

-- (16) Delete book with the ISBN number '9780060935467'.
DELETE FROM book
WHERE ISBN='9780060935467';


















