CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT,
    Order_Date DATE,
    Total_Amount DECIMAL(10,2),
    Order_Status VARCHAR2(30),
    Shipping_Address VARCHAR2(255),
    Delivery_Date DATE,
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (Customer_ID)
        REFERENCES Customer(Customer_ID)
);

CREATE TABLE Order_Items (
    Order_Item_ID INT PRIMARY KEY,
    Order_ID INT,
    Product_ID INT,
    Quantity INT,
    Unit_Price DECIMAL(10,2),
    Discount DECIMAL(5,2),
    Total_Price DECIMAL(10,2),
    CONSTRAINT fk_orderitems_order
        FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID),
    CONSTRAINT fk_orderitems_product
        FOREIGN KEY (Product_ID)
        REFERENCES Product(Product_ID)
);

INSERT INTO Orders
VALUES (501, 101, TO_DATE('10-SEP-2026','DD-MON-YYYY'),
        1231.12, 'Delivered', '12 Anna Nagar, Chennai',
        TO_DATE('14-SEP-2026','DD-MON-YYYY'));

INSERT INTO Orders
VALUES (502, 102, TO_DATE('11-SEP-2026','DD-MON-YYYY'),
        3398.30, 'Shipped', 'Chennai',
        TO_DATE('16-SEP-2026','DD-MON-YYYY'));

INSERT INTO Orders
VALUES (503, 103, TO_DATE('12-SEP-2026','DD-MON-YYYY'),
        2799.20, 'Delivered', 'Coimbatore',
        TO_DATE('17-SEP-2026','DD-MON-YYYY'));

INSERT INTO Orders
VALUES (504, 104, TO_DATE('13-SEP-2026','DD-MON-YYYY'),
        5699.05, 'Shipped', 'Bangalore',
        TO_DATE('18-SEP-2026','DD-MON-YYYY'));

INSERT INTO Orders
VALUES (505, 105, TO_DATE('14-SEP-2026','DD-MON-YYYY'),
        1619.10, 'Delivered', 'Coimbatore',
        TO_DATE('19-SEP-2026','DD-MON-YYYY'));

INSERT INTO Orders
VALUES (506, 106, TO_DATE('15-SEP-2026','DD-MON-YYYY'),
        2462.24, 'Placed', 'Madurai',
        NULL);

COMMIT;

SELECT * FROM Orders;

INSERT INTO Order_Items
VALUES (601, 501, 201, 1, 1399.00, 12.00, 1231.12);

INSERT INTO Order_Items
VALUES (602, 502, 202, 2, 1999.00, 15.00, 3398.30);

INSERT INTO Order_Items
VALUES (603, 503, 203, 1, 3499.00, 20.00, 2799.20);

INSERT INTO Order_Items
VALUES (604, 504, 204, 1, 5999.00, 5.00, 5699.05);

INSERT INTO Order_Items
VALUES (605, 505, 205, 1, 1799.00, 10.00, 1619.10);

INSERT INTO Order_Items
VALUES (606, 506, 201, 2, 1399.00, 12.00, 2462.24);

COMMIT;

SELECT * FROM Order_Items;

UPDATE Orders
SET Total_Amount = 1300.00
WHERE Order_ID = 501;

SELECT * FROM Orders
WHERE Order_ID = 501;

UPDATE Orders
SET Order_Date = TO_DATE('16-SEP-2026','DD-MON-YYYY')
WHERE Order_ID = 502;

SELECT * FROM Orders
WHERE Order_ID = 502;

UPDATE Order_Items
SET Quantity = 2,
    Total_Price = 2462.24
WHERE Order_Item_ID = 601;

SELECT * FROM Order_Items
WHERE Order_Item_ID = 601;

COMMIT;

SELECT o.Order_ID,
       o.Customer_ID,
       o.Order_Date,
       o.Total_Amount,
       o.Order_Status,
       oi.Product_ID,
       oi.Quantity,
       oi.Unit_Price,
       oi.Discount,
       oi.Total_Price
FROM Orders o
JOIN Order_Items oi
ON o.Order_ID = oi.Order_ID
ORDER BY o.Order_ID;

SELECT c.Customer_ID,
       c.First_Name,
       c.Last_Name,
       COUNT(o.Order_ID) AS Total_Orders,
       SUM(o.Total_Amount) AS Total_Amount
FROM Customer c
JOIN Orders o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID,
         c.First_Name,
         c.Last_Name
ORDER BY c.Customer_ID;