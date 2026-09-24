CREATE TABLE Seller (
    Seller_ID INT PRIMARY KEY,
    Seller_Name VARCHAR2(100) NOT NULL,
    Contact_Person VARCHAR2(50),
    Phone VARCHAR2(15),
    Email VARCHAR2(100),
    Address VARCHAR2(200),
    GST_Number VARCHAR2(20)
);

CREATE TABLE Inventory (
    Inventory_ID INT PRIMARY KEY,
    Product_ID INT NOT NULL,
    Seller_ID INT NOT NULL,
    Quantity INT NOT NULL,
    Warehouse VARCHAR2(100),
    Last_Updated DATE NOT NULL,
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    FOREIGN KEY (Seller_ID) REFERENCES Seller(Seller_ID)
);

INSERT INTO Seller
VALUES (301, 'Levis Suppliers', 'Arun Kumar',
        '9876543210', 'levis.suppliers@gmail.com',
        'Chennai', 'GSTIN3001');

INSERT INTO Seller
VALUES (302, 'Vero Moda Suppliers', 'Priya Sharma',
        '9876543211', 'veromoda@gmail.com',
        'Chennai', 'GSTIN3002');

INSERT INTO Seller
VALUES (303, 'Nike Sports Suppliers', 'Rahul Kumar',
        '9876543212', 'nikesports@gmail.com',
        'Coimbatore', 'GSTIN3003');

INSERT INTO Seller
VALUES (304, 'Fossil Watch Suppliers', 'Karthik Raj',
        '9876543213', 'fossilwatchsuppliers@gmail.com',
        'Bangalore', 'GSTIN3004');

INSERT INTO Seller
VALUES (305, 'Wildcraft Suppliers', 'Divya Ravi',
        '9876543214', 'wildcraftsuppliers@gmail.com',
        'Chennai', 'GSTIN3005');

INSERT INTO Seller
VALUES (306, 'Fashion Distributors', 'Meena Devi',
        '9876543215', 'fashiondistributors@gmail.com',
        'Madurai', 'GSTIN3006');

SELECT * FROM Seller;

INSERT INTO Inventory
VALUES (401, 201, 301, 50, 'Chennai Warehouse', '01-SEP-2026');

INSERT INTO Inventory
VALUES (402, 202, 302, 30, 'Chennai Warehouse', '01-SEP-2026');

INSERT INTO Inventory
VALUES (403, 203, 303, 40, 'Coimbatore Warehouse', '02-SEP-2026');

INSERT INTO Inventory
VALUES (404, 204, 304, 20, 'Bangalore Warehouse', '02-SEP-2026');

INSERT INTO Inventory
VALUES (405, 205, 305, 35, 'Chennai Warehouse', '03-SEP-2026');

INSERT INTO Inventory
VALUES (406, 201, 306, 15, 'Madurai Warehouse', '03-SEP-2026');

SELECT
    s.Seller_Name,
    p.Product_Name,
    i.Quantity,
    i.Warehouse,
    i.Last_Updated
FROM Seller s
JOIN Inventory i
ON s.Seller_ID = i.Seller_ID
JOIN Product p
ON i.Product_ID = p.Product_ID
ORDER BY s.Seller_Name;

SELECT
    p.Product_ID,
    p.Product_Name,
    i.Quantity,
    i.Warehouse
FROM Product p
JOIN Inventory i
ON p.Product_ID = i.Product_ID
WHERE i.Quantity > 0;

SELECT
    p.Product_ID,
    p.Product_Name,
    i.Quantity,
    i.Warehouse
FROM Product p
JOIN Inventory i
ON p.Product_ID = i.Product_ID
WHERE i.Quantity = 0;

UPDATE Inventory
SET Quantity = 30,
    Last_Updated = '05-SEP-2026'
WHERE Inventory_ID = 404;

SELECT *
FROM Inventory
WHERE Inventory_ID = 404;

SELECT
    i.Inventory_ID,
    s.Seller_Name,
    p.Product_Name,
    i.Quantity,
    i.Warehouse,
    i.Last_Updated
FROM Inventory i
JOIN Seller s
ON i.Seller_ID = s.Seller_ID
JOIN Product p
ON i.Product_ID = p.Product_ID
ORDER BY i.Inventory_ID;

SELECT
    CASE
        WHEN Quantity > 0 THEN 'Available'
        ELSE 'Unavailable'
    END AS Stock_Status,
    COUNT(*) AS Total_Products
FROM Inventory
GROUP BY
    CASE
        WHEN Quantity > 0 THEN 'Available'
        ELSE 'Unavailable'
    END;

SELECT
    s.Seller_Name,
    SUM(i.Quantity) AS Total_Stock
FROM Seller s
JOIN Inventory i
ON s.Seller_ID = i.Seller_ID
GROUP BY s.Seller_Name
ORDER BY s.Seller_Name;

SELECT
    p.Product_ID,
    p.Product_Name,
    s.Seller_Name,
    i.Quantity,
    i.Warehouse
FROM Product p
JOIN Inventory i
ON p.Product_ID = i.Product_ID
JOIN Seller s
ON i.Seller_ID = s.Seller_ID
WHERE i.Quantity = 0;

COMMIT;