-- 1.Creating Database --
create database Library;
use library;

-- 2.Creating table branch --
drop table if exists branch;
CREATE TABLE branch (
    branch_id VARCHAR(10) primary key,
    manager_id VARCHAR(10),
    branch_address VARCHAR(50),
    contact_no VARCHAR(10)
);
alter table branch modify column contact_no  VARCHAR(25);

-- 3.Creating table employees
drop table if exists employees;
CREATE TABLE employees (
    emp_id VARCHAR(10) primary key,
    emp_name VARCHAR(30),
    position VARCHAR(10),
    salary INT,
    branch_id VARCHAR(10));

-- 4.Creating table issued_status --
drop table if exists issued_status;
CREATE TABLE issued_status (
    issued_id VARCHAR(10) Primary key,
    issued_member_id VARCHAR(10),
    issued_book_name VARCHAR(75),
    issued_date DATE,
    issued_book_isbn VARCHAR(30),
    issued_emp_id VARCHAR(10)
);

-- 5.Creating table books --
drop table if exists books;
CREATE TABLE books (
    isbn VARCHAR(25) primary key,
    book_title VARCHAR(75),
    category VARCHAR(25),
    rental_price FLOAT(10),
    status VARCHAR(10),
    author VARCHAR(30),
    publisher VARCHAR(30)
);

-- 6.Creating table return_status --
drop table if exists return_status;
CREATE TABLE return_status (
    return_id VARCHAR(10) primary key,
    issued_id VARCHAR(10),
    return_book_name VARCHAR(75),
    return_date DATE,
    return_book_isbn VARCHAR(25)
);

-- 7.Creating table members --
drop table if exists members;
CREATE TABLE members (
    member_id VARCHAR(10) primary key,
    member_name VARCHAR(25),
    member_address VARCHAR(25),
    reg_date DATE
);

-- 8.Add constraints --
alter table employees add constraint fk_branchid foreign key(branch_id) references branch(branch_id);
alter table issued_status add constraint fk_issued_book_isbn foreign key(issued_book_isbn) references books(isbn);
alter table issued_status add constraint fk_issued_member_id foreign key(issued_member_id) references members(member_id);
alter table return_status add constraint fk_issued_id foreign key(issued_id) references issued_status(issued_id);
alter table issued_status add constraint fk_issued_emp_id foreign key(issued_emp_id) references employees(emp_id);
alter table return_status add constraint fk_return_book_isbn foreign key(return_book_isbn) references books(isbn);

-- 9.Inserting values --

INSERT INTO members(member_id, member_name, member_address, reg_date) 
VALUES
('C101', 'Alice Johnson', '123 Main St', '2021-05-15'),
('C102', 'Bob Smith', '456 Elm St', '2021-06-20'),
('C103', 'Carol Davis', '789 Oak St', '2021-07-10'),
('C104', 'Dave Wilson', '567 Pine St', '2021-08-05'),
('C105', 'Eve Brown', '890 Maple St', '2021-09-25'),
('C106', 'Frank Thomas', '234 Cedar St', '2021-10-15'),
('C107', 'Grace Taylor', '345 Walnut St', '2021-11-20'),
('C108', 'Henry Anderson', '456 Birch St', '2021-12-10'),
('C109', 'Ivy Martinez', '567 Oak St', '2022-01-05'),
('C110', 'Jack Wilson', '678 Pine St', '2022-02-25'),
('C118', 'Sam', '133 Pine St', '2024-06-01'),    
('C119', 'John', '143 Main St', '2024-05-01');
SELECT * FROM members;


-- Insert values into each branch table
INSERT INTO branch(branch_id, manager_id, branch_address, contact_no) 
VALUES
('B001', 'E109', '123 Main St', '+919099988676'),
('B002', 'E109', '456 Elm St', '+919099988677'),
('B003', 'E109', '789 Oak St', '+919099988678'),
('B004', 'E110', '567 Pine St', '+919099988679'),
('B005', 'E110', '890 Maple St', '+919099988680');
SELECT * FROM branch;


-- Insert values into each employees table
INSERT INTO employees(emp_id, emp_name, position, salary, branch_id) 
VALUES
('E101', 'John Doe', 'Clerk', 60000.00, 'B001'),
('E102', 'Jane Smith', 'Clerk', 45000.00, 'B002'),
('E103', 'Mike Johnson', 'Librarian', 55000.00, 'B001'),
('E104', 'Emily Davis', 'Assistant', 40000.00, 'B001'),
('E105', 'Sarah Brown', 'Assistant', 42000.00, 'B001'),
('E106', 'Michelle Ramirez', 'Assistant', 43000.00, 'B001'),
('E107', 'Michael Thompson', 'Clerk', 62000.00, 'B005'),
('E108', 'Jessica Taylor', 'Clerk', 46000.00, 'B004'),
('E109', 'Daniel Anderson', 'Manager', 57000.00, 'B003'),
('E110', 'Laura Martinez', 'Manager', 41000.00, 'B005'),
('E111', 'Christopher Lee', 'Assistant', 65000.00, 'B005');
SELECT * FROM employees;


-- Inserting into books table 
INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher) 
VALUES
('978-0-553-29698-2', 'The Catcher in the Rye', 'Classic', 7.00, 'yes', 'J.D. Salinger', 'Little, Brown and Company'),
('978-0-330-25864-8', 'Animal Farm', 'Classic', 5.50, 'yes', 'George Orwell', 'Penguin Books'),
('978-0-14-118776-1', 'One Hundred Years of Solitude', 'Literary Fiction', 6.50, 'yes', 'Gabriel Garcia Marquez', 'Penguin Books'),
('978-0-525-47535-5', 'The Great Gatsby', 'Classic', 8.00, 'yes', 'F. Scott Fitzgerald', 'Scribner'),
('978-0-141-44171-6', 'Jane Eyre', 'Classic', 4.00, 'yes', 'Charlotte Bronte', 'Penguin Classics'),
('978-0-307-37840-1', 'The Alchemist', 'Fiction', 2.50, 'yes', 'Paulo Coelho', 'HarperOne'),
('978-0-679-76489-8', 'Harry Potter and the Sorcerers Stone', 'Fantasy', 7.00, 'yes', 'J.K. Rowling', 'Scholastic'),
('978-0-7432-4722-4', 'The Da Vinci Code', 'Mystery', 8.00, 'yes', 'Dan Brown', 'Doubleday'),
('978-0-09-957807-9', 'A Game of Thrones', 'Fantasy', 7.50, 'yes', 'George R.R. Martin', 'Bantam'),
('978-0-393-05081-8', 'A Peoples History of the United States', 'History', 9.00, 'yes', 'Howard Zinn', 'Harper Perennial'),
('978-0-19-280551-1', 'The Guns of August', 'History', 7.00, 'yes', 'Barbara W. Tuchman', 'Oxford University Press'),
('978-0-307-58837-1', 'Sapiens: A Brief History of Humankind', 'History', 8.00, 'no', 'Yuval Noah Harari', 'Harper Perennial'),
('978-0-375-41398-8', 'The Diary of a Young Girl', 'History', 6.50, 'no', 'Anne Frank', 'Bantam'),
('978-0-14-044930-3', 'The Histories', 'History', 5.50, 'yes', 'Herodotus', 'Penguin Classics'),
('978-0-393-91257-8', 'Guns, Germs, and Steel: The Fates of Human Societies', 'History', 7.00, 'yes', 'Jared Diamond', 'W. W. Norton & Company'),
('978-0-7432-7357-1', '1491: New Revelations of the Americas Before Columbus', 'History', 6.50, 'no', 'Charles C. Mann', 'Vintage Books'),
('978-0-679-64115-3', '1984', 'Dystopian', 6.50, 'yes', 'George Orwell', 'Penguin Books'),
('978-0-14-143951-8', 'Pride and Prejudice', 'Classic', 5.00, 'yes', 'Jane Austen', 'Penguin Classics'),
('978-0-452-28240-7', 'Brave New World', 'Dystopian', 6.50, 'yes', 'Aldous Huxley', 'Harper Perennial'),
('978-0-670-81302-4', 'The Road', 'Dystopian', 7.00, 'yes', 'Cormac McCarthy', 'Knopf'),
('978-0-385-33312-0', 'The Shining', 'Horror', 6.00, 'yes', 'Stephen King', 'Doubleday'),
('978-0-451-52993-5', 'Fahrenheit 451', 'Dystopian', 5.50, 'yes', 'Ray Bradbury', 'Ballantine Books'),
('978-0-345-39180-3', 'Dune', 'Science Fiction', 8.50, 'yes', 'Frank Herbert', 'Ace'),
('978-0-375-50167-0', 'The Road', 'Dystopian', 7.00, 'yes', 'Cormac McCarthy', 'Vintage'),
('978-0-06-025492-6', 'Where the Wild Things Are', 'Children', 3.50, 'yes', 'Maurice Sendak', 'HarperCollins'),
('978-0-06-112241-5', 'The Kite Runner', 'Fiction', 5.50, 'yes', 'Khaled Hosseini', 'Riverhead Books'),
('978-0-06-440055-8', 'Charlotte''s Web', 'Children', 4.00, 'yes', 'E.B. White', 'Harper & Row'),
('978-0-679-77644-3', 'Beloved', 'Fiction', 6.50, 'yes', 'Toni Morrison', 'Knopf'),
('978-0-14-027526-3', 'A Tale of Two Cities', 'Classic', 4.50, 'yes', 'Charles Dickens', 'Penguin Books'),
('978-0-7434-7679-3', 'The Stand', 'Horror', 7.00, 'yes', 'Stephen King', 'Doubleday'),
('978-0-451-52994-2', 'Moby Dick', 'Classic', 6.50, 'yes', 'Herman Melville', 'Penguin Books'),
('978-0-06-112008-4', 'To Kill a Mockingbird', 'Classic', 5.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.'),
('978-0-553-57340-1', '1984', 'Dystopian', 6.50, 'yes', 'George Orwell', 'Penguin Books'),
('978-0-7432-4722-5', 'Angels & Demons', 'Mystery', 7.50, 'yes', 'Dan Brown', 'Doubleday'),
('978-0-7432-7356-4', 'The Hobbit', 'Fantasy', 7.00, 'yes', 'J.R.R. Tolkien', 'Houghton Mifflin Harcourt');


-- inserting into issued table
INSERT INTO issued_status(issued_id, issued_member_id, issued_book_name, issued_date, issued_book_isbn, issued_emp_id) 
VALUES
('IS106', 'C106', 'Animal Farm', '2024-03-10', '978-0-330-25864-8', 'E104'),
('IS107', 'C107', 'One Hundred Years of Solitude', '2024-03-11', '978-0-14-118776-1', 'E104'),
('IS108', 'C108', 'The Great Gatsby', '2024-03-12', '978-0-525-47535-5', 'E104'),
('IS109', 'C109', 'Jane Eyre', '2024-03-13', '978-0-141-44171-6', 'E105'),
('IS110', 'C110', 'The Alchemist', '2024-03-14', '978-0-307-37840-1', 'E105'),
('IS111', 'C109', 'Harry Potter and the Sorcerers Stone', '2024-03-15', '978-0-679-76489-8', 'E105'),
('IS112', 'C109', 'A Game of Thrones', '2024-03-16', '978-0-09-957807-9', 'E106'),
('IS113', 'C109', 'A Peoples History of the United States', '2024-03-17', '978-0-393-05081-8', 'E106'),
('IS114', 'C109', 'The Guns of August', '2024-03-18', '978-0-19-280551-1', 'E106'),
('IS115', 'C109', 'The Histories', '2024-03-19', '978-0-14-044930-3', 'E107'),
('IS116', 'C110', 'Guns, Germs, and Steel: The Fates of Human Societies', '2024-03-20', '978-0-393-91257-8', 'E107'),
('IS117', 'C110', '1984', '2024-03-21', '978-0-679-64115-3', 'E107'),
('IS118', 'C101', 'Pride and Prejudice', '2024-03-22', '978-0-14-143951-8', 'E108'),
('IS119', 'C110', 'Brave New World', '2024-03-23', '978-0-452-28240-7', 'E108'),
('IS120', 'C110', 'The Road', '2024-03-24', '978-0-670-81302-4', 'E108'),
('IS121', 'C102', 'The Shining', '2024-03-25', '978-0-385-33312-0', 'E109'),
('IS122', 'C102', 'Fahrenheit 451', '2024-03-26', '978-0-451-52993-5', 'E109'),
('IS123', 'C103', 'Dune', '2024-03-27', '978-0-345-39180-3', 'E109'),
('IS124', 'C104', 'Where the Wild Things Are', '2024-03-28', '978-0-06-025492-6', 'E110'),
('IS125', 'C105', 'The Kite Runner', '2024-03-29', '978-0-06-112241-5', 'E110'),
('IS126', 'C105', 'Charlotte''s Web', '2024-03-30', '978-0-06-440055-8', 'E110'),
('IS127', 'C105', 'Beloved', '2024-03-31', '978-0-679-77644-3', 'E110'),
('IS128', 'C105', 'A Tale of Two Cities', '2024-04-01', '978-0-14-027526-3', 'E110'),
('IS129', 'C105', 'The Stand', '2024-04-02', '978-0-7434-7679-3', 'E110'),
('IS130', 'C106', 'Moby Dick', '2024-04-03', '978-0-451-52994-2', 'E101'),
('IS131', 'C106', 'To Kill a Mockingbird', '2024-04-04', '978-0-06-112008-4', 'E101'),
('IS132', 'C106', 'The Hobbit', '2024-04-05', '978-0-7432-7356-4', 'E106'),
('IS133', 'C107', 'Angels & Demons', '2024-04-06', '978-0-7432-4722-5', 'E106'),
('IS134', 'C107', 'The Diary of a Young Girl', '2024-04-07', '978-0-375-41398-8', 'E106'),
('IS135', 'C107', 'Sapiens: A Brief History of Humankind', '2024-04-08', '978-0-307-58837-1', 'E108'),
('IS136', 'C107', '1491: New Revelations of the Americas Before Columbus', '2024-04-09', '978-0-7432-7357-1', 'E102'),
('IS137', 'C107', 'The Catcher in the Rye', '2024-04-10', '978-0-553-29698-2', 'E103'),
('IS138', 'C108', 'The Great Gatsby', '2024-04-11', '978-0-525-47535-5', 'E104'),
('IS139', 'C109', 'Harry Potter and the Sorcerers Stone', '2024-04-12', '978-0-679-76489-8', 'E105'),
('IS140', 'C110', 'Animal Farm', '2024-04-13', '978-0-330-25864-8', 'E102');


-- inserting into return table
INSERT INTO return_status(return_id, issued_id, return_date) 
VALUES
('RS106', 'IS108', '2024-05-05'),
('RS107', 'IS109', '2024-05-07'),
('RS108', 'IS110', '2024-05-09'),
('RS109', 'IS111', '2024-05-11'),
('RS110', 'IS112', '2024-05-13'),
('RS111', 'IS113', '2024-05-15'),
('RS112', 'IS114', '2024-05-17'),
('RS113', 'IS115', '2024-05-19'),
('RS114', 'IS116', '2024-05-21'),
('RS115', 'IS117', '2024-05-23'),
('RS116', 'IS118', '2024-05-25'),
('RS117', 'IS119', '2024-05-27'),
('RS118', 'IS120', '2024-05-29');
SELECT * FROM return_status;

-- 10.Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"
insert into books values ('978-1-60129-456-2','To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

-- 11.Update an Existing Member's Address = '125 Oak St' for member_id = 'C103'--
UPDATE members 
SET 
    member_address = '125 Oak St'
WHERE
    member_id = 'C103';

-- 11.Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
DELETE FROM issued_status 
WHERE
    issued_id = 'IS121';

-- 12.Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.
SELECT 
    *
FROM
    issued_status
WHERE
    issued_emp_id = 'E101';

-- 13.List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.
SELECT 
    issued_emp_id, COUNT(*)
FROM
    issued_status
GROUP BY issued_emp_id
HAVING COUNT(*) > 1;

-- 14.Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**
CREATE TABLE `Book Issued count` AS SELECT isbn, book_title, COUNT(issued_id) FROM
    books
        JOIN
    issued_status ON isbn = issued_book_isbn
GROUP BY 1 , 2; 

-- 15.Retrieve All Books in a Specific Category:
-- When using " = " operator the caomparing value should be exact ,but "like" operator is case insensitive --
SELECT 
    *
FROM
    books
WHERE
    category LIKE 'cla%';
    
-- 16.Find Total Rental Income by Category:
SELECT 
    category, SUM(rental_price)
FROM
    books b,
    issued_status i
WHERE
    b.isbn = i.issued_book_isbn
GROUP BY 1;

-- 17.List Members Who Registered in the Last 180 Days:
select * from members where reg_date >=(select date_sub((select max(reg_date) from members),interval 180 day));

-- 18.List Employees with Their Branch Manager's Name and their branch details:
SELECT 
    e.emp_id,
    e.emp_name,
    e.position,
    e.salary,
    b.*,
    em.emp_name AS manager_name
FROM
    branch b
        JOIN
    employees e USING (branch_id)
        JOIN
    employees em ON b.manager_id = em.emp_id;

-- Create a Table of Books with Rental Price Above a Certain Threshold:
CREATE TABLE expensive_books AS (SELECT * FROM
    books
WHERE
    rental_price > 7);

-- Retrieve the List of Books Not Yet Returned:
SELECT 
    COUNT(*)
FROM
    issued_status
WHERE
    issued_id NOT IN (SELECT 
            issued_id
        FROM
            return_status);

-- query to identify members who have overdue books (assume a 30-day return period). Display the member's_id, member's name, book title, issue date, and days overdue.
SELECT 
    m.member_id,
    m.member_name,
    i.issued_book_name,
    i.issued_date,
    DATEDIFF(CURDATE(), i.issued_date) AS Days_overdue
FROM
    issued_status i
        LEFT JOIN
    return_status r USING (issued_id)
        JOIN
    members m ON i.issued_member_id = m.member_id
WHERE
    return_id IS NULL
        AND (SELECT 
            DATEDIFF(CURDATE(), i.issued_date)
        FROM
            issued_status i_s
        WHERE
            i_s.issued_id = i.issued_id) > 30 order by 1;
            
-- Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, 
-- and the total revenue generated from book rentals.            
CREATE VIEW mai AS
    SELECT 
        branch_id,
        i.issued_id AS issued_id,
        issued_member_id,
        issued_book_name,
        issued_date,
        issued_book_isbn,
        issued_emp_id,
        emp_id,
        emp_name,
        position,
        salary,
        manager_id,
        branch_address,
        contact_no,
        isbn,
        book_title,
        category,
        rental_price,
        status,
        author,
        publisher,
        return_id,
        return_book_name,
        return_date,
        return_book_isbn
    FROM
        issued_status i
            JOIN
        employees e ON e.emp_id = i.issued_emp_id
            JOIN
        branch br USING (branch_id)
            JOIN
        books bo ON bo.isbn = i.issued_book_isbn
            LEFT JOIN
        return_status r ON i.issued_id = r.issued_id;
        -- Checking --
 SELECT 
    branch_id,
    COUNT(issued_id),
    COUNT(return_id),
    SUM(rental_price)
FROM
    mai
GROUP BY 1;


-- Create a Table of Active Members
-- Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued at least one book in the last 2 months.
CREATE TABLE Active_members AS SELECT DISTINCT (member_id), member_name, member_address, reg_date FROM
    members m
        JOIN
    issued_status i ON m.member_id = i.issued_member_id
WHERE
    issued_date >= (SELECT DATE_SUB('2024-04-13', INTERVAL 2 MONTH));
    -- Checking--
SELECT 
    *
FROM
    Active_members
ORDER BY member_id;

-- Find Employees with the Most Book Issues Processed
-- Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.
SELECT 
    Issued_emp_id,
    cnt,
    cntb,
    branch_id,
    rank1
FROM 
    (
        SELECT 
            Issued_emp_id,
            COUNT(Issued_emp_id) AS cnt,
            COUNT(issued_book_name) AS cntb,
            DENSE_RANK() OVER (ORDER BY COUNT(Issued_emp_id) DESC) AS rank1
        FROM 
            issued_status
        GROUP BY 
            Issued_emp_id
    ) AS a
JOIN 
    employees 
    ON emp_id = Issued_emp_id
WHERE 
    rank1 IN (1, 2, 3);
    
-- Create a stored procedure to manage the status of books in a library system. Description: Write a stored procedure that updates the status of a book in the library 
-- based on its issuance. The procedure should function as follows: The stored procedure should take the book_id as an input parameter. 
-- The procedure should first check if the book is available (status = 'yes'). 
-- If the book is available, it should be issued, and the status in the books table should be updated to 'no'. 
-- If the book is not available (status = 'no'), the procedure should return an error message indicating that the book is currently not available.
-- Answer!!!!!!
-- CREATE DEFINER=`root`@`localhost` PROCEDURE `Bookiss`(p_issued_id varchar(10),p_member_id varchar(10),p_issued_book_isbn varchar(25),p_issued_emp_id varchar(10))
-- BEGIN
--  declare v_status varchar(10);
--  select status into v_status from books where p_issued_book_isbn=isbn;
--  if v_status ='yes'then
-- 	insert into issued_status(issued_id,issued_member_id,issued_date,issued_book_isbn,issued_emp_id)values(p_issued_id,p_member_id,curdate(),p_issued_book_isbn,p_issued_emp_id);
--     update books set status='no' where isbn=p_issued_book_isbn;
--     select "Book Provided Successfully";
--  else 
-- 	select "Requested Book is Not Available";
--  end if;
-- END

-- Write a query to update the status of books in the books table to "Yes" when they are returned (based on entries in the return_status table).
-- Answer!!!!
-- CREATE DEFINER=`root`@`localhost` PROCEDURE `returnup`(in p_return_id VARCHAR(10), in p_issued_id VARCHAR(10))
-- BEGIN
-- 	declare v_isbn VARCHAR(50);
--     declare v_book_name VARCHAR(80);
--     
-- 	select issued_book_name,issued_book_isbn into v_book_name,v_isbn from issued_status where issued_id=p_issued_id;
-- 	insert into return_status(return_id,issued_id,return_book_name,return_date,return_book_isbn) values (p_return_id,p_issued_id,v_book_name,curdate(),v_isbn);
--     update books set status = 'yes' where isbn=v_isbn;
--     select concat('Thank You For Returning'," ",v_book_name);
-- END

