
-- 1. SELECT
SELECT * FROM customers LIMIT 10;

-- 2. WHERE
SELECT * FROM customers
WHERE customer_state = 'SP'
LIMIT 10;

-- 3. ORDER BY
SELECT order_id, product_id, price, freight_value
FROM order_items
ORDER BY price DESC
LIMIT 10;

-- 4. GROUP BY
SELECT order_status, COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- 5. INNER JOIN
SELECT c.customer_id, c.customer_city,
       o.order_id, o.order_status
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
LIMIT 10;

-- 6. LEFT JOIN
SELECT c.customer_id, c.customer_city,
       o.order_id, o.order_status
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
LIMIT 10;

-- 7. RIGHT JOIN
SELECT o.order_id, o.customer_id, o.order_status,
       c.customer_city, c.customer_state
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id
LIMIT 10;

-- 8. SUM and AVG
SELECT SUM(price) AS total_revenue,
       AVG(price) AS average_product_price
FROM order_items;

-- 9. SUBQUERY
SELECT order_id, product_id, price
FROM order_items
WHERE price > (SELECT AVG(price) FROM order_items)
ORDER BY price DESC
LIMIT 10;

-- 10. VIEW
CREATE VIEW IF NOT EXISTS order_summary AS
SELECT order_status, COUNT(*) AS total_orders
FROM orders
GROUP BY order_status;

SELECT * FROM order_summary;

-- 11. INDEX
CREATE INDEX IF NOT EXISTS idx_orders_customer
ON orders(customer_id);

-- 12. AVERAGE REVENUE PER UNIQUE CUSTOMER
SELECT
    1.0 * SUM(oi.price) / COUNT(DISTINCT c.customer_unique_id)
    AS average_revenue_per_customer
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered';
