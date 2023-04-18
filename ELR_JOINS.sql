SELECT * FROM ORDERS;
SELECT * FROM CUSTOMER;

 -- INNER JOIN -- Find the order id, customer id for all orders and see which customers used promo code
SELECT Orders.Order_ID, Customer.Customer_ID, Orders.ORDER_PROMO
FROM Orders
INNER JOIN Customer ON Orders.ORDER_Customer_ID = Customer.Customer_ID
ORDER BY ORDERS.ORDER_PROMO;


-- RIGHT JOIN MULTIPLE -- What is the order amount for each order, was there a promo code used?

SELECT DISTINCT ORDERS.ORDER_ID, ORDERS.ORDER_AMOUNT, CUSTOMER.FIRST_NAME, ORDER_DETAILS.PROMOTION_ID
FROM ((ORDERS
RIGHT JOIN CUSTOMER ON ORDERS.ORDER_CUSTOMER_ID = CUSTOMER.CUSTOMER_ID)
RIGHT JOIN ORDER_DETAILS ON ORDERS.ORDER_ID = ORDER_DETAILS.ORDER_ID)
ORDER BY ORDERS.ORDER_ID;

-- RIGHT JOIN -- How many orders still need to be shipped that have who used a discount code?

SELECT DISTINCT order_details.promotion_id, orders.order_id, orders.order_date, orders.order_shipped
FROM orders
RIGHT JOIN order_details ON orders.order_id = order_details.order_id
ORDER BY orders.order_shipped;

