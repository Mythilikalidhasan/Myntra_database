SQL> -- 2.1 INNER JOIN: Customer and Orders
SQL> SELECT c.Customer_ID,
  2         c.First_Name || ' ' || c.Last_Name AS Customer_Name,
  3         o.Order_ID, o.Order_Date, o.Total_Amount
  4  FROM Customer c
  5  INNER JOIN Orders o ON c.Customer_ID = o.Customer_ID;

CUSTOMER_ID CUSTOMER_NAME          ORDER_ID ORDER_DAT TOTAL_AMOUNT
----------- -------------------- ---------- --------- ------------
        101 Rahul Sharma                501 10-SEP-26      1231.12
        102 Priya Ravi                  502 11-SEP-26       3398.3
        103 Karthik Kumar               503 12-SEP-26       2799.2
        104 Anitha Suresh               504 13-SEP-26      5699.05
        105 Arun Prakash                505 14-SEP-26       1619.1
        106 Divya Lakshmi               506 15-SEP-26      2462.24

6 rows selected.

SQL> SELECT o.Order_ID, o.Order_Date, o.Total_Amount,
  2         p.Payment_Method, p.Amount AS Payment_Amount, p.Payment_Status
  3  FROM Orders o
  4  INNER JOIN Payment p ON o.Order_ID = p.Order_ID;

  ORDER_ID ORDER_DAT TOTAL_AMOUNT PAYMENT_METHOD  PAYMENT_AMOUNT PAYMENT_STAT
---------- --------- ------------ --------------- -------------- ------------
       501 10-SEP-26      1231.12 UPI                       1300 Successful
       503 12-SEP-26       2799.2 UPI                     2799.2 Successful
       502 11-SEP-26       3398.3 Card                    3398.3 Successful
       504 13-SEP-26      5699.05 Card                   5699.05 Successful
       505 14-SEP-26       1619.1 COD                     1619.1 Successful
       506 15-SEP-26      2462.24 UPI                    2462.24 Successful

6 rows selected.

SQL> SELECT pr.Product_ID, pr.Product_Name, oi.Order_ID,
  2         oi.Quantity, pr.Price AS Unit_Price,
  3         oi.Quantity * pr.Price AS Subtotal
  4  FROM Product pr
  5  INNER JOIN Order_Items oi ON pr.Product_ID = oi.Product_ID;

PRODUCT_ID PRODUCT_NAME           ORDER_ID   QUANTITY UNIT_PRICE   SUBTOTAL
---------- -------------------- ---------- ---------- ---------- ----------
       201 Cotton Shirt                501          1       1399       1399
       202 Floral Dress                502          2       1999       3998
       203 Running Shoes               503          1       3499       3499
       204 Analog Watch                504          1       5999       5999
       205 Backpack                    505          1       1799       1799
       201 Cotton Shirt                506          2       1399       2798

6 rows selected.

SQL> SELECT c.Customer_ID,
  2         c.First_Name || ' ' || c.Last_Name AS Customer_Name,
  3         o.Order_ID, o.Order_Date, o.Total_Amount
  4  FROM Customer c
  5  LEFT JOIN Orders o ON c.Customer_ID = o.Customer_ID;

CUSTOMER_ID CUSTOMER_NAME          ORDER_ID ORDER_DAT TOTAL_AMOUNT
----------- -------------------- ---------- --------- ------------
        101 Rahul Sharma                501 10-SEP-26      1231.12
        102 Priya Ravi                  502 11-SEP-26       3398.3
        103 Karthik Kumar               503 12-SEP-26       2799.2
        104 Anitha Suresh               504 13-SEP-26      5699.05
        105 Arun Prakash                505 14-SEP-26       1619.1
        106 Divya Lakshmi               506 15-SEP-26      2462.24
        107 Vignesh Raj
        108 Meena Krishnan

8 rows selected.

SQL> SELECT c.Customer_ID,
  2         c.First_Name || ' ' || c.Last_Name AS Customer_Name,
  3         o.Order_ID, o.Order_Date, o.Total_Amount
  4  FROM Customer c
  5  RIGHT JOIN Orders o ON c.Customer_ID = o.Customer_ID;

CUSTOMER_ID CUSTOMER_NAME          ORDER_ID ORDER_DAT TOTAL_AMOUNT
----------- -------------------- ---------- --------- ------------
        101 Rahul Sharma                501 10-SEP-26      1231.12
        102 Priya Ravi                  502 11-SEP-26       3398.3
        103 Karthik Kumar               503 12-SEP-26       2799.2
        104 Anitha Suresh               504 13-SEP-26      5699.05
        105 Arun Prakash                505 14-SEP-26       1619.1
        106 Divya Lakshmi               506 15-SEP-26      2462.24

6 rows selected.

SQL> SELECT c.Customer_ID,
  2         c.First_Name || ' ' || c.Last_Name AS Customer_Name,
  3         o.Order_ID, o.Order_Date,
  4         pr.Product_ID, pr.Product_Name,
  5         oi.Quantity, pr.Price AS Unit_Price,
  6         oi.Quantity * pr.Price AS Subtotal,
  7         py.Payment_Method, py.Amount AS Payment_Amount, py.Payment_Status
  8  FROM Customer c
  9  INNER JOIN Orders o ON c.Customer_ID = o.Customer_ID
 10  INNER JOIN Order_Items oi ON o.Order_ID = oi.Order_ID
 11  INNER JOIN Product pr ON oi.Product_ID = pr.Product_ID
 12  INNER JOIN Payment py ON o.Order_ID = py.Order_ID
 13  ORDER BY o.Order_Date DESC;

CUSTOMER_ID CUSTOMER_NAME          ORDER_ID ORDER_DAT PRODUCT_ID PRODUCT_NAME           QUANTITY UNIT_PRICE   SUBTOTAL PAYMENT_METHOD  PAYMENT_AMOUNT PAYMENT_STAT
----------- -------------------- ---------- --------- ---------- -------------------- ---------- ---------- ---------- --------------- -------------- ------------
        106 Divya Lakshmi               506 15-SEP-26        201 Cotton Shirt                  2       1399       2798 UPI              2462.24 Successful
        105 Arun Prakash                505 14-SEP-26        205 Backpack                      1       1799       1799 COD               1619.1 Successful
        104 Anitha Suresh               504 13-SEP-26        204 Analog Watch                  1       5999       5999 Card             5699.05 Successful
        103 Karthik Kumar               503 12-SEP-26        203 Running Shoes                 1       3499       3499 UPI               2799.2 Successful
        102 Priya Ravi                  502 11-SEP-26        202 Floral Dress                  2       1999       3998 Card              3398.3 Successful
        101 Rahul Sharma                501 10-SEP-26        201 Cotton Shirt                  1       1399       1399 UPI         1300 Successful

6 rows selected.

SQL> SELECT c.Customer_ID, c.First_Name || ' ' || c.Last_Name AS Customer_Name, o.Order_ID, o.Order_Date, pr.Product_Name, oi.Quantity, oi.Quantity * pr.Price AS Subtotal FROM Customer c INNER JOIN Orders o ON c.Customer_ID = o.Customer_ID INNER JOIN Order_Items oi ON o.Order_ID = oi.Order_ID INNER JOIN Product pr ON oi.Product_ID = pr.Product_ID ORDER BY c.Customer_ID, o.Order_Date;

CUSTOMER_ID CUSTOMER_NAME          ORDER_ID ORDER_DAT PRODUCT_NAME           QUANTITY   SUBTOTAL
----------- -------------------- ---------- --------- -------------------- ---------- ----------
        101 Rahul Sharma                501 10-SEP-26 Cotton Shirt                  1       1399
        102 Priya Ravi                  502 11-SEP-26 Floral Dress                  2       3998
        103 Karthik Kumar               503 12-SEP-26 Running Shoes                 1       3499
        104 Anitha Suresh               504 13-SEP-26 Analog Watch                  1       5999
        105 Arun Prakash                505 14-SEP-26 Backpack                      1       1799
        106 Divya Lakshmi               506 15-SEP-26 Cotton Shirt                  2       2798

6 rows selected.

SQL> SELECT c.Customer_ID,
  2         c.First_Name || ' ' || c.Last_Name AS Customer_Name,
  3         o.Order_ID, o.Order_Date,
  4         pr.Product_Name, oi.Quantity,
  5         oi.Quantity * pr.Price AS Subtotal,
  6         py.Payment_Method, py.Payment_Status
  7  FROM Customer c
  8  INNER JOIN Orders o ON c.Customer_ID = o.Customer_ID
  9  INNER JOIN Order_Items oi ON o.Order_ID = oi.Order_ID
 10  INNER JOIN Product pr ON oi.Product_ID = pr.Product_ID
 11  INNER JOIN Payment py ON o.Order_ID = py.Order_ID
 12  ORDER BY c.Customer_ID;

CUSTOMER_ID CUSTOMER_NAME          ORDER_ID ORDER_DAT PRODUCT_NAME           QUANTITY   SUBTOTAL PAYMENT_METHOD  PAYMENT_STAT
----------- -------------------- ---------- --------- -------------------- ---------- ---------- --------------- ------------
        101 Rahul Sharma                501 10-SEP-26 Cotton Shirt                  1       1399 UPI             Successful
        102 Priya Ravi                  502 11-SEP-26 Floral Dress                  2       3998 Card            Successful
        103 Karthik Kumar               503 12-SEP-26 Running Shoes                 1       3499 UPI             Successful
        104 Anitha Suresh               504 13-SEP-26 Analog Watch                  1       5999 Card            Successful
        105 Arun Prakash                505 14-SEP-26 Backpack                      1       1799 COD             Successful
        106 Divya Lakshmi               506 15-SEP-26 Cotton Shirt                  2       2798 UPI             Successful

6 rows selected.

SQL> SELECT c.First_Name || ' ' || c.Last_Name AS Customer_Name,
  2         COUNT(DISTINCT o.Order_ID) AS Total_Orders,
  3         SUM(oi.Quantity * pr.Price) AS Total_Purchase,
  4         SUM(oi.Quantity) AS Total_Products
  5  FROM Customer c
  6  INNER JOIN Orders o ON c.Customer_ID = o.Customer_ID
  7  INNER JOIN Order_Items oi ON o.Order_ID = oi.Order_ID
  8  INNER JOIN Product pr ON oi.Product_ID = pr.Product_ID
  9  GROUP BY c.First_Name, c.Last_Name
 10  ORDER BY Total_Purchase DESC;

CUSTOMER_NAME        TOTAL_ORDERS TOTAL_PURCHASE TOTAL_PRODUCTS
-------------------- ------------ -------------- --------------
Anitha Suresh                   1           5999              1
Priya Ravi                      1           3998              2
Karthik Kumar                   1           3499              1
Divya Lakshmi                   1           2798              2
Arun Prakash                    1           1799              1
Rahul Sharma                    1           1399              1

6 rows selected.

SQL>
SQL> SELECT c.First_Name || ' ' || c.Last_Name AS Customer_Name,
  2         o.Order_ID, o.Order_Date, o.Total_Amount,
  3         py.Payment_Method, py.Amount AS Payment_Amount, py.Payment_Status
  4  FROM Customer c
  5  INNER JOIN Orders o ON c.Customer_ID = o.Customer_ID
  6  INNER JOIN Payment py ON o.Order_ID = py.Order_ID
  7  ORDER BY o.Order_Date DESC;

CUSTOMER_NAME          ORDER_ID ORDER_DAT TOTAL_AMOUNT PAYMENT_METHOD  PAYMENT_AMOUNT PAYMENT_STAT
-------------------- ---------- --------- ------------ --------------- -------------- ------------
Divya Lakshmi               506 15-SEP-26      2462.24 UPI                    2462.24 Successful
Arun Prakash                505 14-SEP-26       1619.1 COD                     1619.1 Successful
Anitha Suresh               504 13-SEP-26      5699.05 Card                   5699.05 Successful
Karthik Kumar               503 12-SEP-26       2799.2 UPI                     2799.2 Successful
Priya Ravi                  502 11-SEP-26       3398.3 Card                    3398.3 Successful
Rahul Sharma                501 10-SEP-26      1231.12 UPI                       1300 Successful

6 rows selected.

SQL>