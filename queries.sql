-- Total Revenue Generated

SELECT ROUND(SUM(p.price * o.quantity),2) AS TotalRevenue
FROM Orders o
JOIN Products p
ON o.product_id = p.product_id;
SELECT COUNT(*) AS TotalOrders
FROM Orders;

SELECT
ROUND(SUM(p.price*o.quantity)/COUNT(order_id),2)
AS AverageOrderValue
FROM Orders o
JOIN Products p
ON o.product_id=p.product_id;

SELECT
MONTH(order_date) AS Month,
ROUND(SUM(price*quantity),2) AS Revenue
FROM Orders o
JOIN Products p
ON o.product_id=p.product_id
GROUP BY MONTH(order_date)
ORDER BY Month;

SELECT
customer_name,
ROUND(SUM(price*quantity),2) AS Revenue
FROM Orders o
JOIN Customers c
ON o.customer_id=c.customer_id
JOIN Products p
ON o.product_id=p.product_id
GROUP BY customer_name
ORDER BY Revenue DESC
LIMIT 5;

SELECT
product_name,
SUM(quantity) AS UnitsSold
FROM Orders o
JOIN Products p
ON o.product_id=p.product_id
GROUP BY product_name
ORDER BY UnitsSold DESC;

SELECT
category,
ROUND(SUM(price*quantity),2) AS Revenue
FROM Orders o
JOIN Products p
ON o.product_id=p.product_id
GROUP BY category;

SELECT
city,
ROUND(SUM(price*quantity),2) AS Revenue
FROM Orders o
JOIN Customers c
ON o.customer_id=c.customer_id
JOIN Products p
ON o.product_id=p.product_id
GROUP BY city
ORDER BY Revenue DESC;

SELECT
MONTH(order_date) AS Month,
ROUND(SUM(price*quantity),2) Revenue
FROM Orders o
JOIN Products p
ON o.product_id=p.product_id
GROUP BY MONTH(order_date)
ORDER BY Revenue DESC
LIMIT 1;

SELECT
customer_name,
COUNT(*) TotalOrders
FROM Orders o
JOIN Customers c
ON o.customer_id=c.customer_id
GROUP BY customer_name
HAVING COUNT(*)>5;

/*=========================================
ADVANCED SQL QUERIES
=========================================*/

SELECT customer_name,
       Revenue,
       RANK() OVER(ORDER BY Revenue DESC) AS CustomerRank
FROM(
    SELECT c.customer_name,
           SUM(p.price*o.quantity) AS Revenue
    FROM Orders o
    JOIN Customers c
    ON o.customer_id=c.customer_id
    JOIN Products p
    ON o.product_id=p.product_id
    GROUP BY c.customer_name
) x;

SELECT
order_date,
SUM(price*quantity) AS DailyRevenue,
SUM(SUM(price*quantity))
OVER(ORDER BY order_date)
AS RunningRevenue
FROM Orders o
JOIN Products p
ON o.product_id=p.product_id
GROUP BY order_date;

SELECT
product_name,
SUM(price*quantity) Revenue
FROM Orders o
JOIN Products p
ON o.product_id=p.product_id
GROUP BY product_name
ORDER BY Revenue DESC
LIMIT 1;

SELECT
product_name,
SUM(quantity) UnitsSold
FROM Orders o
JOIN Products p
ON o.product_id=p.product_id
GROUP BY product_name
ORDER BY UnitsSold
LIMIT 1;

SELECT
customer_name,
COUNT(order_id) OrdersPlaced
FROM Orders o
JOIN Customers c
ON o.customer_id=c.customer_id
GROUP BY customer_name
HAVING COUNT(order_id)>1;

SELECT
category,
ROUND(AVG(price*quantity),2)
AS AverageRevenue
FROM Orders o
JOIN Products p
ON o.product_id=p.product_id
GROUP BY category;

SELECT customer_name,
Revenue
FROM(
SELECT
c.customer_name,
SUM(price*quantity) Revenue
FROM Orders o
JOIN Customers c
ON o.customer_id=c.customer_id
JOIN Products p
ON o.product_id=p.product_id
GROUP BY customer_name
)x
WHERE Revenue>(
SELECT AVG(Revenue)
FROM(
SELECT SUM(price*quantity) Revenue
FROM Orders o
JOIN Products p
ON o.product_id=p.product_id
GROUP BY customer_id
)y
);

SELECT
city,
SUM(price*quantity) Revenue
FROM Orders o
JOIN Customers c
ON o.customer_id=c.customer_id
JOIN Products p
ON o.product_id=p.product_id
GROUP BY city
ORDER BY Revenue DESC
LIMIT 1;

SELECT
category,
COUNT(order_id) TotalOrders,
SUM(price*quantity) Revenue
FROM Orders o
JOIN Products p
ON o.product_id=p.product_id
GROUP BY category;

SELECT
MONTH(order_date) Month,
COUNT(*) Orders
FROM Orders
GROUP BY MONTH(order_date)
ORDER BY Month;

CREATE INDEX idx_customer
ON Orders(customer_id);

CREATE INDEX idx_product
ON Orders(product_id);

CREATE INDEX idx_order_date
ON Orders(order_date);

CREATE VIEW MonthlySales AS
SELECT
MONTH(order_date) Month,
SUM(price*quantity) Revenue
FROM Orders o
JOIN Products p
ON o.product_id=p.product_id
GROUP BY MONTH(order_date);