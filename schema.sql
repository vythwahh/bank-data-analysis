
CREATE DATABASE IF NOT exists bank_data;
 USE bank_data 

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    date_of_birth DATE,
    gender VARCHAR(10),
    phone VARCHAR(15),
    email VARCHAR(100),
    address VARCHAR(255)
);
CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(50),  -- Ví dụ: 'Thanh toán', 'Tiết kiệm'
    open_date DATE,
    balance DECIMAL(15, 2),
    status VARCHAR(20),        -- 'Hoạt động', 'Đóng'
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_date DATE,
    amount DECIMAL(15, 2),
    transaction_type VARCHAR(20), -- 'Rút', 'Nạp', 'Chuyển khoản'
    description VARCHAR(255),
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);
CREATE TABLE Savings (
    saving_id INT PRIMARY KEY,
    account_id INT,
    open_date DATE,
    amount DECIMAL(15, 2),
    interest_rate FLOAT,         -- Lãi suất phần trăm/năm
    term_months INT,             -- Kỳ hạn tính theo tháng
    status VARCHAR(20),          -- 'Đang gửi', 'Đáo hạn', 'Tất toán'
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);
CREATE TABLE Loans (
    loan_id INT PRIMARY KEY,
    customer_id INT,
    loan_date DATE,
    loan_amount DECIMAL(15, 2),
    interest_rate FLOAT,
    term_months INT,
    status VARCHAR(20),          -- 'Đang vay', 'Đã tất toán'
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
 SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE Savings;
TRUNCATE TABLE Loans;
TRUNCATE TABLE Transactions;
TRUNCATE TABLE Accounts;
TRUNCATE TABLE Customers;

SET FOREIGN_KEY_CHECKS = 1;
INSERT INTO Customers (customer_id, full_name, date_of_birth, gender, phone, email, address)
VALUES 
(383332, 'Robert Russell', '1985-04-23', 'Male', '0901234567', 'robert.russell@example.com', '123 Elm Street, District 1'),
(540832, 'George Smith', '1978-11-02', 'Male', '0902345678', 'george.smith@example.com', '456 Oak Avenue, District 3'),
(208333, 'Natalie Lewis', '1990-03-14', 'Female', '0903456789', 'natalie.lewis@example.com', '789 Pine Lane, District 5'),
(320083, 'Olivia Evans', '1992-08-07', 'Female', '0904567890', 'olivia.evans@example.com', '12 Maple Blvd, District 10'),
(970083, 'Henry Turner', '1987-01-19', 'Male', '0905678901', 'henry.turner@example.com', '34 Cedar St, District 4'),
(390836, 'Isabella Hill', '1995-10-31', 'Female', '0906789012', 'isabella.hill@example.com', '56 Birch Rd, District 6'),
(290837, 'Liam Davis', '1991-06-22', 'Male', '0907890123', 'liam.davis@example.com', '78 Ash Ave, District 7'),
(283878, 'Emily Moore', '1983-02-12', 'Female', '0908901234', 'emily.moore@example.com', '90 Spruce St, District 8'),
(308395, 'Daniel Clark', '1979-12-05', 'Male', '0909012345', 'daniel.clark@example.com', '21 Redwood Dr, District 9'),
(240810, 'Sophie Carter', '2001-04-01', 'Female', '0910123456', 'sophie.carter@example.com', '43 Fir Ct, District 11'),
(390081, 'Ethan Scott', '1988-07-15', 'Male', '0911234567', 'ethan.scott@example.com', '65 Poplar Ln, District 2'),
(490812, 'Grace Hall', '1996-11-23', 'Female', '0912345678', 'grace.hall@example.com', '87 Willow Way, District 12'),
(390813, 'Jack Adams', '1980-09-10', 'Male', '0913456789', 'jack.adams@example.com', '109 Cypress Blvd, District 1'),
(290814, 'Mia Thompson', '1994-03-30', 'Female', '0914567890', 'mia.thompson@example.com', '131 Dogwood Rd, District 3'),
(273081, 'Noah White', '1986-05-25', 'Male', '0915678901', 'noah.white@example.com', '153 Alder St, District 5'),
(870816, 'Lily Harris', '1993-01-07', 'Female', '0916789012', 'lily.harris@example.com', '175 Sequoia Ave, District 6'),
(380817, 'Benjamin Walker', '1982-08-18', 'Male', '0917890123', 'benjamin.walker@example.com', '197 Magnolia Ln, District 7'),
(280818, 'Chloe Young', '2000-06-14', 'Female', '0918901234', 'chloe.young@example.com', '219 Palm Ct, District 4'),
(488195, 'James Robinson', '1975-10-02', 'Male', '0919012345', 'james.robinson@example.com', '241 Cottonwood Dr, District 8'),
(440820, 'Abigail Parker', '1993-12-29', 'Female', '0920123456', 'abigail.parker@example.com', '263 Bamboo St, District 9');
INSERT INTO Accounts (account_id, customer_id, account_type, open_date, balance, status) VALUES
(10003451, 383332, 'Savings', '2020-01-15', 2839221.00, 'Active'),
(10093842, 540832, 'Checking', '2019-03-10', 10217207.00, 'Active'),
(10002493, 208333, 'Savings', '2021-07-05', 5619200.00, 'Active'),
(10049044, 320083, 'Checking', '2018-11-22', 2431000.00, 'Active'),
(10402205, 970083, 'Savings', '2022-02-28', 7745612.00, 'Active'),
(10040206, 390836, 'Checking', '2020-05-16', 3150000.00, 'Active'),
(10490247, 290837, 'Savings', '2021-09-12', 8800000.00, 'Active'),
(10048008, 283878, 'Checking', '2019-06-18', 4571200.00, 'Active'),
(10043729, 308395, 'Savings', '2023-01-03', 6600000.00, 'Active'),
(10004476, 240810, 'Checking', '2020-10-08', 3924000.00, 'Active'),
(10048011, 390081, 'Savings', '2019-12-19', 7281000.00, 'Active'),
(10044012, 490812, 'Checking', '2021-04-25', 2180000.00, 'Active'),
(10048313, 390813, 'Savings', '2020-08-30', 4533000.00, 'Active'),
(10048214, 290814, 'Checking', '2022-03-14', 3140000.00, 'Active'),
(10049215, 273081, 'Savings', '2018-07-09', 8990000.00, 'Active'),
(10048216, 870816, 'Checking', '2019-05-20', 2700000.00, 'Active'),
(10049917, 380817, 'Savings', '2023-02-11', 6999000.00, 'Active'),
(10004018, 280818, 'Checking', '2021-01-17', 3800000.00, 'Active'),
(10024019, 488195, 'Savings', '2020-09-23', 6400000.00, 'Active'),
(10040020, 440820, 'Checking', '2022-12-05', 4210000.00, 'Active');
INSERT INTO Transactions (transaction_id, account_id, transaction_date, amount, transaction_type, description) VALUES
(18731, 10003451, '2023-05-12', 1500000.00, 'Deposit', 'Initial deposit'),
(13832, 10003451, '2023-06-05', 500000.00, 'Withdraw', 'ATM withdrawal'),
(18383, 10093842, '2024-02-20', 3000000.00, 'Deposit', 'Salary deposit'),
(12834, 10093842, '2024-03-15', 1000000.00, 'Withdraw', 'Online shopping'),
(10935, 10002493, '2023-09-10', 2500000.00, 'Deposit', 'Savings top-up'),
(13876, 10049044, '2023-07-18', 700000.00, 'Withdraw', 'Bill payment'),
(19287, 10402205, '2024-01-03', 10000000.00, 'Deposit', 'Fixed-term deposit'),
(18398, 10040206, '2023-04-22', 1200000.00, 'Withdraw', 'Groceries payment'),
(13739, 10490247, '2023-11-05', 8000000.00, 'Deposit', 'Business income'),
(18210, 10048008, '2023-08-14', 2500000.00, 'Withdraw', 'Tuition fee'),
(13921, 10043729, '2024-05-01', 5000000.00, 'Deposit', 'Investment gain'),
(13232, 10004476, '2023-06-30', 1900000.00, 'Withdraw', 'Rent payment'),
(12323, 10048011, '2024-03-09', 2200000.00, 'Deposit', 'Side income'),
(18274, 10044012, '2023-12-20', 1100000.00, 'Withdraw', 'Shopping expense'),
(11375, 10048313, '2024-02-11', 3000000.00, 'Deposit', 'Bonus deposit'),
(13986, 10048214, '2023-10-25', 1500000.00, 'Withdraw', 'Holiday spending'),
(13797, 10049215, '2024-06-02', 5000000.00, 'Deposit', 'Freelance payment'),
(17228, 10048216, '2023-07-28', 1700000.00, 'Withdraw', 'Utility bills'),
(13389, 10049917, '2024-01-15', 4500000.00, 'Deposit', 'Commission income'),
(23710, 10004018, '2023-05-06', 800000.00, 'Withdraw', 'Mobile recharge'),
(23131, 10024019, '2024-03-28', 3500000.00, 'Deposit', 'Government support'),
(22832, 10040020, '2023-09-17', 1400000.00, 'Withdraw', 'Medical expense');
INSERT INTO Savings (saving_id, account_id, open_date, amount, interest_rate, term_months, status) VALUES
(560231, 10003451, '2023-05-15', 2000000.00, 5.5, 12, 'Ongoing'),
(572842, 10002493, '2023-09-12', 3000000.00, 6.2, 6, 'Ongoing'),
(583193, 10402205, '2024-01-05', 8000000.00, 6.8, 12, 'Ongoing'),
(594784, 10490247, '2023-11-07', 5000000.00, 5.9, 9, 'Ongoing'),
(565345, 10043729, '2024-05-03', 6000000.00, 6.0, 12, 'Ongoing'),
(576896, 10048313, '2024-02-13', 3500000.00, 5.7, 6, 'Ongoing'),
(587447, 10049215, '2024-06-05', 7000000.00, 6.5, 12, 'Ongoing'),
(598098, 10049917, '2024-01-17', 4000000.00, 6.1, 6, 'Ongoing'),
(534659, 10024019, '2024-03-30', 4500000.00, 6.3, 9, 'Ongoing');
INSERT INTO Loans (loan_id, customer_id, loan_date, loan_amount, interest_rate, term_months, status) VALUES
(200101, 383332, '2023-06-15', 50000000.00, 8.5, 24, 'Ongoing'),
(200102, 540832, '2022-09-10', 120000000.00, 7.8, 36, 'Ongoing'),
(200103, 208333, '2024-01-20', 35000000.00, 9.2, 12, 'Ongoing'),
(200104, 320083, '2023-03-05', 60000000.00, 8.0, 18, 'Ongoing'),
(200105, 970083, '2022-11-28', 90000000.00, 8.7, 30, 'Ongoing'),
(200106, 390836, '2023-08-12', 45000000.00, 9.0, 12, 'Ongoing'),
(200107, 290837, '2024-02-03', 70000000.00, 8.3, 24, 'Ongoing'),
(200108, 283878, '2023-07-22', 55000000.00, 8.9, 18, 'Ongoing'),
(200109, 308395, '2022-12-17', 80000000.00, 7.5, 36, 'Matured'),
(200110, 240810, '2023-10-09', 30000000.00, 9.5, 12, 'Ongoing'),
(200111, 390081, '2024-04-18', 65000000.00, 8.2, 24, 'Ongoing'),
(200112, 490812, '2023-09-27', 40000000.00, 9.1, 12, 'Ongoing'),
(200113, 390813, '2023-05-06', 52000000.00, 8.6, 18, 'Ongoing'),
(200114, 290814, '2024-03-15', 47000000.00, 8.4, 24, 'Ongoing'),
(200115, 273081, '2023-11-03', 100000000.00, 7.9, 36, 'Matured'),
(200116, 870816, '2023-07-11', 38000000.00, 9.3, 12, 'Ongoing'),
(200117, 380817, '2024-01-25', 75000000.00, 8.1, 24, 'Ongoing'),
(200118, 280818, '2023-06-28', 43000000.00, 9.0, 18, 'Ongoing'),
(200119, 488195, '2024-02-08', 68000000.00, 8.5, 24, 'Ongoing'),
(200120, 440820, '2023-12-05', 36000000.00, 9.2, 12, 'Ongoing');
SELECT * FROM Customers
SELECT * FROM Accounts
SELECT * FROM Transactions 
SELECT * FROM Savings
SELECT * FROM Loans 
