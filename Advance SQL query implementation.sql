

SQL> SELECT Order_ID, Customer_ID, Total_Amount
  2  FROM Orders
  3  WHERE Total_Amount >
  4        (SELECT AVG(Total_Amount)
  5         FROM Orders);

  ORDER_ID CUSTOMER_ID TOTAL_AMOUNT
---------- ----------- ------------
       502         102       3398.3
       504         104      5699.05

SQL> SELECT Product_ID, Product_Name, Price
  2  FROM Product
  3  WHERE Price >
  4        (SELECT AVG(Price)
  5         FROM Product);

PRODUCT_ID
----------
PRODUCT_NAME
--------------------------------------------------------------------------------
     PRICE
----------
       203
Running Shoes
      3499

       204
Analog Watch
      5999

PRODUCT_ID
----------
PRODUCT_NAME
--------------------------------------------------------------------------------
     PRICE
----------


SQL> SELECT Product_ID, Product_Name, Price
  2  FROM Product
  3  WHERE Price <
  4        (SELECT AVG(Price)
  5         FROM Product);

PRODUCT_ID
----------
PRODUCT_NAME
--------------------------------------------------------------------------------
     PRICE
----------
       201
Cotton Shirt
      1399

       202
Floral Dress
      1999

PRODUCT_ID
----------
PRODUCT_NAME
--------------------------------------------------------------------------------
     PRICE
----------

       205
Backpack
      1799


SQL> SELECT Customer_ID,
  2         SUM(Total_Amount) AS Total_Purchase
  3  FROM Orders
  4  GROUP BY Customer_ID;

CUSTOMER_ID TOTAL_PURCHASE
----------- --------------
        101        1231.12
        102         3398.3
        103         2799.2
        104        5699.05
        105         1619.1
        106        2462.24

6 rows selected.

SQL> SELECT MAX(Total_Purchase)
  2  FROM (
  3      SELECT Customer_ID,
  4             SUM(Total_Amount) AS Total_Purchase
  5      FROM Orders
  6      GROUP BY Customer_ID
  7  );

MAX(TOTAL_PURCHASE)
-------------------
            5699.05

SQL> SELECT c.Customer_ID,
  2         c.First_Name || ' ' || c.Last_Name AS Customer_Name,
  3         SUM(o.Total_Amount) AS Total_Purchase
  4  FROM Customer c
  5  JOIN Orders o
  6      ON c.Customer_ID = o.Customer_ID
  7  GROUP BY c.Customer_ID, c.First_Name, c.Last_Name
  8  HAVING SUM(o.Total_Amount) = (
  9      SELECT MAX(Total_Purchase)
 10      FROM (
 11          SELECT SUM(Total_Amount) AS Total_Purchase
 12          FROM Orders
 13          GROUP BY Customer_ID
 14      ));

no rows selected

SQL> SELECT * FROM Customer WHERE Customer_ID = 104;

no rows selected

SQL>
SQL> SELECT o.Customer_ID
  2  FROM Orders o
  3  LEFT JOIN Customer c ON o.Customer_ID = c.Customer_ID
  4  WHERE c.Customer_ID IS NULL;

CUSTOMER_ID
-----------
        101
        102
        103
        104
        105
        106

6 rows selected.

SQL> INSERT INTO Customer VALUES
  2  (104,'Anitha','Suresh','Female','anitha@gmail.com','9876543213','anitha123','22 Tambaram','Chennai','Tamil Nadu',600045,TO_DATE('05-APR-2026','DD-MON-YYYY'));

1 row created.

SQL> COMMIT;

Commit complete.

SQL> SELECT c.Customer_ID,
  2         c.First_Name || ' ' || c.Last_Name AS Customer_Name,
  3         SUM(o.Total_Amount) AS Total_Purchase
  4  FROM Customer c
  5  JOIN Orders o
  6      ON c.Customer_ID = o.Customer_ID
  7  GROUP BY c.Customer_ID, c.First_Name, c.Last_Name
  8  HAVING SUM(o.Total_Amount) = (
  9      SELECT MAX(Total_Purchase)
 10      FROM (
 11          SELECT SUM(Total_Amount) AS Total_Purchase
 12          FROM Orders
 13          GROUP BY Customer_ID
 14      ));

CUSTOMER_ID
-----------
CUSTOMER_NAME
--------------------------------------------------------------------------------
TOTAL_PURCHASE
--------------
        104
Anitha Suresh
       5699.05


SQL> SELECT c.Customer_ID,
  2         c.First_Name || ' ' || c.Last_Name AS Customer_Name,
  3         o.Order_ID,
  4         o.Total_Amount
  5  FROM Customer c
  6  JOIN Orders o
  7      ON c.Customer_ID = o.Customer_ID
  8  WHERE o.Total_Amount >
  9  (
 10      SELECT AVG(Total_Amount)
 11      FROM Orders
 12  )
 13  ORDER BY o.Total_Amount DESC, o.Order_ID;

CUSTOMER_ID
-----------
CUSTOMER_NAME
--------------------------------------------------------------------------------
  ORDER_ID TOTAL_AMOUNT
---------- ------------
        104
Anitha Suresh
       504      5699.05


SQL> DESC Orders;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 ORDER_ID                                  NOT NULL NUMBER(38)
 CUSTOMER_ID                                        NUMBER(38)
 ORDER_DATE                                         DATE
 TOTAL_AMOUNT                                       NUMBER(10,2)
 ORDER_STATUS                                       VARCHAR2(30)
 SHIPPING_ADDRESS                                   VARCHAR2(255)
 DELIVERY_DATE                                      DATE

SQL> SET LINESIZE 200
SQL> SET PAGESIZE 50
SQL> DESC Order_Items;
 Name                                                                                                              Null?    Type
 ----------------------------------------------------------------------------------------------------------------- -------- ----------------------------------------------------------------------------
 ORDER_ITEM_ID                                                                                                     NOT NULL NUMBER(38)
 ORDER_ID                                                                                                                   NUMBER(38)
 PRODUCT_ID                                                                                                                 NUMBER(38)
 QUANTITY                                                                                                                   NUMBER(38)
 UNIT_PRICE                                                                                                                 NUMBER(10,2)
 DISCOUNT                                                                                                                   NUMBER(5,2)
 TOTAL_PRICE                                                                                                                NUMBER(10,2)

SQL> SELECT * FROM Order_Items;

ORDER_ITEM_ID   ORDER_ID PRODUCT_ID   QUANTITY UNIT_PRICE   DISCOUNT TOTAL_PRICE
------------- ---------- ---------- ---------- ---------- ---------- -----------
          601        501        201          1       1399         12     1231.12
          602        502        202          2       1999         15      3398.3
          603        503        203          1       3499         20      2799.2
          604        504        204          1       5999          5     5699.05
          605        505        205          1       1799         10      1619.1
          606        506        201          2       1399         12     2462.24

6 rows selected.

SQL> SELECT Order_ID, Customer_ID, Total_Amount FROM Orders ORDER BY Order_ID;

  ORDER_ID CUSTOMER_ID TOTAL_AMOUNT
---------- ----------- ------------
       501         101      1231.12
       502         102       3398.3
       503         103       2799.2
       504         104      5699.05
       505         105       1619.1
       506         106      2462.24

6 rows selected.

SQL> SELECT p.Product_ID,
  2         p.Product_Name,
  3         SUM(oi.Total_Price) AS Total_Sales
  4  FROM Product p
  5  JOIN Order_Items oi
  6      ON p.Product_ID = oi.Product_ID
  7  GROUP BY p.Product_ID, p.Product_Name
  8  HAVING SUM(oi.Total_Price) > (
  9      SELECT AVG(Product_Sales)
 10      FROM (
 11          SELECT SUM(Total_Price) AS Product_Sales
 12          FROM Order_Items
 13          GROUP BY Product_ID
 14      ))
 15  ORDER BY Total_Sales DESC;

PRODUCT_ID PRODUCT_NAME                                                                                         TOTAL_SALES
---------- ---------------------------------------------------------------------------------------------------- -----------
       204 Analog Watch                                                                                             5699.05
       201 Cotton Shirt                                                                                             3693.36

SQL> SELECT c.Customer_ID,
  2         c.First_Name || ' ' || c.Last_Name AS Customer_Name,
  3         COUNT(o.Order_ID)   AS Total_Orders,
  4         SUM(o.Total_Amount) AS Total_Purchase,
  5         AVG(o.Total_Amount) AS Average_Order_Value
  6  FROM Customer c
  7  JOIN Orders o
  8      ON c.Customer_ID = o.Customer_ID
  9  GROUP BY c.Customer_ID, c.First_Name, c.Last_Name
 10  ORDER BY Total_Purchase DESC;

CUSTOMER_ID CUSTOMER_NAME                                                                                         TOTAL_ORDERS TOTAL_PURCHASE AVERAGE_ORDER_VALUE
----------- ----------------------------------------------------------------------------------------------------- ------------ -------------- -------------------
        104 Anitha Suresh                                                                                                    1        5699.05             5699.05




SQL> You ran the old version. `Order_Details` doesn't exist in your database, so swap in `Order_Items` and `Total_Price`. Copy this one:
SP2-0734: unknown command beginning "You ran th..." - rest of line ignored.
SQL>
SQL> ```sql
SP2-0042: unknown command "```sql" - rest of line ignored.
SQL> SELECT p.Product_ID,
  2         p.Product_Name,
  3         COUNT(oi.Order_ID)   AS Number_of_Orders,
  4         SUM(oi.Quantity)     AS Total_Quantity_Sold,
  5         SUM(oi.Total_Price)  AS Total_Sales,
  6         AVG(oi.Unit_Price)   AS Average_Price
  7  FROM Product p
  8  JOIN Order_Items oi
  9      ON p.Product_ID = oi.Product_ID
 10  GROUP BY p.Product_ID, p.Product_Name
 11  ORDER BY Total_Sales DESC;

PRODUCT_ID PRODUCT_NAME                                                                                         NUMBER_OF_ORDERS TOTAL_QUANTITY_SOLD TOTAL_SALES AVERAGE_PRICE
---------- ---------------------------------------------------------------------------------------------------- ---------------- ------------------- ----------- -------------
       204 Analog Watch                                                                                                        1                   1     5699.05  5999
       201 Cotton Shirt                                                                                                        2                   3     3693.36  1399
       202 Floral Dress                                                                                                        1                   2      3398.3  1999
       203 Running Shoes                                                                                                       1                   1      2799.2  3499
       205 Backpack                                                                                                            1                   1      1619.1  1799


SQL> SELECT cat.Category_ID,
  2         cat.Category_Name,
  3         COUNT(DISTINCT oi.Order_ID) AS Total_Orders,
  4         SUM(oi.Quantity)            AS Total_Quantity_Sold,
  5         SUM(oi.Total_Price)         AS Total_Sales,
  6         AVG(oi.Unit_Price)          AS Average_Price
  7  FROM Category cat
  8  JOIN Product p
  9      ON cat.Category_ID = p.Category_ID
 10  JOIN Order_Items oi
 11      ON p.Product_ID = oi.Product_ID
 12  GROUP BY cat.Category_ID, cat.Category_Name
 13  ORDER BY Total_Sales DESC;

CATEGORY_ID CATEGORY_NAME        TOTAL_ORDERS TOTAL_QUANTITY_SOLD TOTAL_SALES AVERAGE_PRICE
----------- -------------------- ------------ ------------------- ----------- -------------
        104 Watches                         1                   1     5699.05          5999
        101 Men Clothing                    2                   3     3693.36          1399
        102 Women Clothing                  1                   2      3398.3          1999
        103 Footwear                        1                   1      2799.2          3499
        105 Bags                            1                   1      1619.1          1799

SQL> SELECT p.Product_ID,
  2         p.Product_Name,
  3         SUM(oi.Total_Price) AS Total_Sales
  4  FROM Product p
  5  JOIN Order_Items oi
  6      ON p.Product_ID = oi.Product_ID
  7  GROUP BY p.Product_ID, p.Product_Name
  8  HAVING SUM(oi.Total_Price) > (
  9      SELECT AVG(Product_Sales)
 10      FROM (
 11          SELECT SUM(Total_Price) AS Product_Sales
 12          FROM Order_Items
 13          GROUP BY Product_ID
 14      ))
 15  ORDER BY Total_Sales DESC;

PRODUCT_ID PRODUCT_NAME         TOTAL_SALES
---------- -------------------- -----------
       204 Analog Watch             5699.05
       201 Cotton Shirt             3693.36

SQL> SELECT p.Product_ID,
  2         p.Product_Name,
  3         COUNT(oi.Order_ID)   AS Number_of_Orders,
  4         SUM(oi.Quantity)     AS Total_Quantity_Sold,
  5         SUM(oi.Total_Price)  AS Total_Sales,
  6         AVG(oi.Unit_Price)   AS Average_Price
  7  FROM Product p
  8  JOIN Order_Items oi
  9      ON p.Product_ID = oi.Product_ID
 10  GROUP BY p.Product_ID, p.Product_Name
 11  ORDER BY Total_Sales DESC;

PRODUCT_ID PRODUCT_NAME         NUMBER_OF_ORDERS TOTAL_QUANTITY_SOLD TOTAL_SALES AVERAGE_PRICE
---------- -------------------- ---------------- ------------------- ----------- -------------
       204 Analog Watch                        1                   1     5699.05          5999
       201 Cotton Shirt                        2                   3     3693.36          1399
       202 Floral Dress                        1                   2      3398.3          1999
       203 Running Shoes                       1                   1      2799.2          3499
       205 Backpack                            1                   1      1619.1          1799

SQL> SELECT cat.Category_ID,
  2         cat.Category_Name,
  3         COUNT(DISTINCT oi.Order_ID) AS Total_Orders,
  4         SUM(oi.Quantity)            AS Total_Quantity_Sold,
  5         SUM(oi.Total_Price)         AS Total_Sales,
  6         AVG(oi.Unit_Price)          AS Average_Price
  7  FROM Category cat
  8  JOIN Product p
  9      ON cat.Category_ID = p.Category_ID
 10  JOIN Order_Items oi
 11      ON p.Product_ID = oi.Product_ID
 12  GROUP BY cat.Category_ID, cat.Category_Name
 13  ORDER BY Total_Sales DESC;

CATEGORY_ID CATEGORY_NAME        TOTAL_ORDERS TOTAL_QUANTITY_SOLD TOTAL_SALES AVERAGE_PRICE
----------- -------------------- ------------ ------------------- ----------- -------------
        104 Watches                         1                   1     5699.05          5999
        101 Men Clothing                    2                   3     3693.36          1399
        102 Women Clothing                  1                   2      3398.3          1999
        103 Footwear                        1                   1      2799.2          3499
        105 Bags                            1                   1      1619.1          1799