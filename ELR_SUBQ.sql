-- QUERIES/SUBQ

-- Find the customer id and total order amount for customers who ordered product SKU '1112'

USE elr_project;

SELECT
    order_amount, order_customer_id
FROM
    elr_project.orders ord
WHERE
    ord.order_id IN (SELECT
            ors.order_id
        FROM
            elr_project.order_details ors
        WHERE
            ors.product_id = '1112');
            
-- For SKU '1111'?            
SELECT
    order_amount, order_customer_id
FROM
    elr_project.orders ord
WHERE
    ord.order_id IN (SELECT
            ors.order_id
        FROM
            elr_project.order_details ors
        WHERE
            ors.product_id = '1111');

-- How many orders have been shipped and what date were they ordered? Was there a promo code used?            
SELECT order_shipped, order_date, order_promo
FROM 
	elr_project.orders ord
WHERE 
	ord.order_id IN (SELECT
			orp.order_id
		FROM
            elr_project.order_details orp
		WHERE 
			ord.order_shipped = 1)
		ORDER BY 
			ord.order_promo;

-- How many orders have been shipped and what is the total value to 1 d.p. of all shipped orders?
SELECT COUNT(order_shipped) AS orders_sent, ROUND(SUM(order_amount), 1) AS sent_orders_total
FROM orders
WHERE orders.order_shipped = 1
GROUP BY order_shipped;
            
-- What is the average sales amount (to 1 d.p.) for customers who used promo code 'FS1122' and how many orders used this code?
SELECT
COUNT(ors.order_promo) AS order_count, ROUND(AVG(ors.order_amount), 1) AS Avg_Sales_FS1122
	FROM 
		elr_project.orders ors
    WHERE 
		ors.order_id IN (SELECT
				ord.order_id
			FROM
				elr_project.order_details ord
			WHERE ord.promotion_id = 'FS1122' AND ors.order_promo = 1);
    
-- How many orders still need to be shipped that have who used a discount code, what is the order date?

SELECT DISTINCT order_details.promotion_id, orders.order_id, orders.order_date, orders.order_shipped
FROM orders
RIGHT JOIN order_details ON orders.order_id = order_details.order_id
ORDER BY orders.order_shipped;

-- How many customers used the credit payment method?
SELECT COUNT(c_payment_type)
FROM 
customer_payment
WHERE c_payment_type = "CREDIT";