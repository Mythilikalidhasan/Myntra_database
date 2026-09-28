CREATE TABLE Payment (
    Payment_ID NUMBER(5) PRIMARY KEY,
    Order_ID NUMBER(5) NOT NULL,
    Payment_Method VARCHAR2(30) NOT NULL,
    Transaction_ID VARCHAR2(100) NOT NULL,
    Payment_Status VARCHAR2(20) NOT NULL,
    Payment_Date DATE NOT NULL,
    Amount NUMBER(10,2) NOT NULL,
    CONSTRAINT fk_payment_order
        FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID)
);

INSERT INTO Payment
(Payment_ID, Order_ID, Payment_Method, Transaction_ID,
 Payment_Status, Payment_Date, Amount)
VALUES
(701, 501, 'UPI', 'UPI5012026',
 'Successful', TO_DATE('10-SEP-2026','DD-MON-YYYY'), 1300.00);

INSERT INTO Payment
(Payment_ID, Order_ID, Payment_Method, Transaction_ID,
 Payment_Status, Payment_Date, Amount)
VALUES
(702, 502, 'Card', 'CARD5022026',
 'Successful', TO_DATE('16-SEP-2026','DD-MON-YYYY'), 3398.30);

INSERT INTO Payment
(Payment_ID, Order_ID, Payment_Method, Transaction_ID,
 Payment_Status, Payment_Date, Amount)
VALUES
(703, 503, 'UPI', 'UPI5032026',
 'Successful', TO_DATE('12-SEP-2026','DD-MON-YYYY'), 2799.20);

INSERT INTO Payment
(Payment_ID, Order_ID, Payment_Method, Transaction_ID,
 Payment_Status, Payment_Date, Amount)
VALUES
(704, 504, 'Card', 'CARD5042026',
 'Successful', TO_DATE('13-SEP-2026','DD-MON-YYYY'), 5699.05);

INSERT INTO Payment
(Payment_ID, Order_ID, Payment_Method, Transaction_ID,
 Payment_Status, Payment_Date, Amount)
VALUES
(705, 505, 'COD', 'COD5052026',
 'Successful', TO_DATE('14-SEP-2026','DD-MON-YYYY'), 1619.10);

INSERT INTO Payment
(Payment_ID, Order_ID, Payment_Method, Transaction_ID,
 Payment_Status, Payment_Date, Amount)
VALUES
(706, 506, 'UPI', 'UPI5062026',
 'Failed', TO_DATE('15-SEP-2026','DD-MON-YYYY'), 2462.24);

COMMIT;

SELECT *
FROM Payment
WHERE Payment_Status = 'Successful';

SELECT *
FROM Payment
WHERE Payment_Status = 'Failed';

UPDATE Payment
SET Payment_Status = 'Successful'
WHERE Payment_ID = 706;

COMMIT;

SELECT *
FROM Payment
WHERE Payment_ID = 706;

SELECT
    Payment_Method,
    COUNT(*) AS Total_Transactions
FROM Payment
GROUP BY Payment_Method
ORDER BY Payment_Method;

SELECT
    Payment_Method,
    SUM(Amount) AS Total_Amount
FROM Payment
WHERE Payment_Status = 'Successful'
GROUP BY Payment_Method
ORDER BY Payment_Method;

SELECT
    p.Payment_ID,
    o.Order_ID,
    c.Customer_ID,
    c.First_Name || ' ' || c.Last_Name AS Customer_Name,
    pr.Product_ID,
    pr.Product_Name,
    cat.Category_ID,
    cat.Category_Name,
    p.Payment_Method,
    p.Transaction_ID,
    p.Payment_Date,
    p.Amount,
    p.Payment_Status
FROM Payment p
JOIN Orders o
    ON p.Order_ID = o.Order_ID
JOIN Customer c
    ON o.Customer_ID = c.Customer_ID
JOIN Order_Items oi
    ON o.Order_ID = oi.Order_ID
JOIN Product pr
    ON oi.Product_ID = pr.Product_ID
JOIN Category cat
    ON pr.Category_ID = cat.Category_ID
ORDER BY p.Payment_Date DESC;