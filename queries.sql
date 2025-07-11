USE bank_data;
-- Q1 Liệt kê tên khách hàng và loại tài khoản mà họ đang sở hữu
 SELECT 
 cus.full_name,
 acc.account_type
 FROM
 Customers AS cus,
 Accounts AS acc
 WHERE
 cus.customer_id = acc.customer_id
 -- Q2 Cho biết mỗi khách hàng đã vay bao nhiêu tiền (tổng tiền các khoản vay)
 SELECT 
    cus.full_name,
    SUM(l.loan_amount)

FROM
    Customers AS cus,
    Loans AS l
WHERE
    cus.customer_id = l.customer_id
GROUP BY (cus.full_name);
-- Q3 Liệt kê mã tài khoản và tổng số tiền rút ra từ mỗi tài khoản
SELECT 
    t.account_id,
    SUM(t.amount)

FROM
    Transactions AS t
WHERE
    t.transaction_type LIKE 'Withdraw'
GROUP BY (t.account_id);
-- Q4 Liệt kê từng loại tài khoản và số lượng tài khoản đang hoạt động của từng loại
SELECT (
    acc.account_type
),
COUNT(*) AS SoLuongTaiKhoan
FROM 
    Accounts AS acc
WHERE 
    acc.status LIKE 'Active'
GROUP BY (
    acc.account_type
);
-- Q5 Liệt kê tên khách hàng và số tiền đã rút ra trong năm 2023
SELECT
    cus.full_name,
SUM(t.amount) AS TongTienRut
FROM 
    Customers AS cus,
    Accounts AS acc,
    Transactions AS t
WHERE 
    cus.customer_id = acc.customer_id
    AND acc.account_id = t.account_id
    AND t.transaction_type LIKE 'Withdraw'
    AND YEAR(t.transaction_date) = 2023
GROUP BY (
    cus.full_name
);
-- Q6 Liệt kê tên khách hàng có tổng tiền gửi (Deposit) lớn hơn 2500000 trong năm 2024
SELECT 
    cus.full_name,
SUM(t.amount) AS TongTienGui
FROM 
    Customers AS cus,
    Accounts AS acc,
    Transactions AS t
WHERE 
    cus.customer_id = acc.customer_id
    AND acc.account_id = t.account_id
    AND t.transaction_type LIKE 'Deposit'
    AND YEAR(t.transaction_date) = 2024
GROUP BY (
    cus.full_name
)
HAVING 
    SUM(t.amount) > 2500000;
-- Q7 Cho biết tên khách hàng và tổng số tiền họ đang gửi tiết kiệm, chỉ tính những khoản có kỳ hạn ≥ 12 tháng
SELECT (
    cus.full_name
),
SUM(s.amount) AS TongSoTienTietKiem
FROM 
    Customers AS cus,
    Accounts AS acc,
    Savings AS s
WHERE 
    cus.customer_id = acc.customer_id
    AND acc.account_id = s.account_id
    AND s.term_months >= 12
GROUP BY (
    cus.full_name
);
-- Q8 Cho biết mỗi loại giao dịch (Deposit, Withdraw...) có bao nhiêu lượt thực hiện
 SELECT (
    t.transaction_type
),
COUNT(*) AS SoLuot
FROM 
    Transactions AS t
GROUP BY (
    t.transaction_type
);
-- Q9 Cho biết những khách hàng có tổng tiền đang tiết kiệm > 3500000, sắp xếp theo tổng giảm dần
SELECT (
    cus.full_name
),
SUM(s.amount) AS TongGui
FROM 
    Customers AS cus,
    Accounts AS acc,
    Savings AS s
WHERE 
    cus.customer_id = acc.customer_id
    AND acc.account_id = s.account_id
GROUP BY (
    cus.full_name
)
HAVING 
    SUM(s.amount) > 3500000
ORDER BY 
    SUM(s.amount) DESC;
-- Q10 Cho biết mỗi khách hàng đang vay bao nhiêu tiền, và kỳ hạn trung bình là bao nhiêu tháng
SELECT 
    cus.full_name,
SUM(l.loan_amount) AS TongTienVay,
AVG(l.term_months) AS KyHanTrungBinh
FROM 
    Customers AS cus,
    Loans AS l 
WHERE 
    cus.customer_id = l.customer_id
GROUP BY (
    cus.full_name
);
-- Q11 Với mỗi tháng trong năm 2024, tổng số tiền giao dịch là bao nhiêu?
SELECT 
    MONTH(t.transaction_date),
SUM(t.amount) AS TongGiaoDich
FROM 
    Transactions AS t
WHERE 
    YEAR(t.transaction_date) = 2024
GROUP BY (
    MONTH(t.transaction_date)
);
-- Q12  Khách hàng nào đã thực hiện giao dịch trong tháng 3 năm 2024?
SELECT 
    c.full_name
FROM 
    Customers AS c,
    Accounts AS a,
    Transactions AS t
WHERE 
    c.customer_id = a.customer_id
    AND a.account_id = t.account_id
    AND MONTH(t.transaction_date) = 3
    AND YEAR(t.transaction_date) = 2024
GROUP BY (
    c.full_name
);
-- Q14 Liệt kê mã tài khoản có tổng tiền gửi (Deposit) nhiều hơn rút (Withdraw).
SELECT (
    t.account_id
)
FROM 
    Transactions AS t
GROUP BY (
    t.account_id
)
HAVING 
    SUM(t.transaction_type LIKE 'Deposit') > SUM(t.transaction_type LIKE 'Withdraw');
-- Q15 Cho biết trong mỗi tháng năm 2024 có bao nhiêu giao dịch đã được thực hiện
SELECT (
    MONTH(t.transaction_date)
),
COUNT(*) AS SoGiaoDich
FROM 
    Transactions AS t
WHERE 
    YEAR(t.transaction_date) = 2024
GROUP BY (
    MONTH(t.transaction_date)
);
-- Q16 Liệt kê tên khách hàng không thực hiện bất kỳ giao dịch nào trong năm 2023
SELECT (
    c.full_name
)
FROM 
    Customers AS c
WHERE NOT EXISTS (
    SELECT *
    FROM Accounts a, Transactions t
    WHERE 
        c.customer_id = a.customer_id
        AND a.account_id = t.account_id
        AND YEAR(t.transaction_date) = 2023
);
-- Q17 Liệt kê các tài khoản có tổng tiền rút thuộc top 3 tài khoản rút nhiều nhất.
SELECT (
    t.account_id
),
SUM(t.amount) AS TongRut
FROM 
    Transactions AS t
WHERE 
    t.transaction_type LIKE 'Withdraw'
GROUP BY (
    t.account_id
)
HAVING 
    SUM(t.amount) IN (
        SELECT DISTINCT
            total_rut
        FROM (
            SELECT 
                SUM(t2.amount) AS total_rut
            FROM 
                Transactions AS t2
            WHERE 
                t2.transaction_type LIKE 'Withdraw'
            GROUP BY (
                t2.account_id
            )
            ORDER BY total_rut DESC
            LIMIT 3
        ) AS TopRut
    );
-- Q18 Cho biết những tài khoản có tổng tiền giao dịch lớn hơn mọi tài khoản Checking khác
SELECT 
    t.account_id,
SUM(t.amount) AS TongTien
FROM 
    Transactions AS t,
    Accounts AS a
WHERE 
    t.account_id = a.account_id
GROUP BY (
    t.account_id
)
HAVING 
    SUM(t.amount) > ALL (
        SELECT 
            SUM(t2.amount)
        FROM 
            Transactions AS t2,
            Accounts AS a2
        WHERE 
            t2.account_id = a2.account_id
            AND a2.account_type LIKE 'Checking'
        GROUP BY (
            t2.account_id
        )
    );


-- Q19 Tìm 3 khách hàng có nhiều loại giao dịch nhất trong năm 2024.
SELECT 
    c.full_name,
COUNT(DISTINCT t.transaction_type) AS SoLoaiGiaoDich
FROM 
    Customers AS c,
    Accounts AS a,
    Transactions AS t
WHERE 
    c.customer_id = a.customer_id
    AND a.account_id = t.account_id
    AND YEAR(t.transaction_date) = 2024
GROUP BY (
    c.full_name
)
ORDER BY 
    COUNT(DISTINCT t.transaction_type) DESC
LIMIT 3;
-- Q20 Cho biết tên khách hàng đã có: hoặc tài khoản tiết kiệm (Savings) hoặc từng thực hiện giao dịch rút (Withdraw) trong năm 2024
SELECT 
    c.full_name

FROM 
    Customers AS c
WHERE 
    EXISTS (
        SELECT *
        FROM 
        Accounts AS a, 
        Savings AS s
        WHERE 
            c.customer_id = a.customer_id
            AND a.account_id = s.account_id
    )
    OR EXISTS (
        SELECT *
        FROM 
        Accounts AS a2, 
        Transactions AS t
        WHERE 
            c.customer_id = a2.customer_id
            AND a2.account_id = t.account_id
            AND t.transaction_type LIKE 'Withdraw'
            AND YEAR(t.transaction_date) = 2024
    );

