create database oe;

use oe;

-- Таблица - customers

-- Вывести максимальный и минимальный credit_limit.

SELECT max(credit_limit), min(credit_limit)
FROM customers;

-- Вывести покупателей у которых creditlimit выше среднего creditlimit.

SELECT CUST_FIRST_NAME, CUST_LAST_NAME, CREDIT_LIMIT
FROM customers
WHERE CREDIT_LIMIT > (SELECT avg(CREDIT_LIMIT) FROM customers);

-- Найти кол/во покупателей имя которых начинается на букву 'D' и credit_limit больше 500.

SELECT CUST_FIRST_NAME, CUST_LAST_NAME, CREDIT_LIMIT
FROM customers
WHERE CREDIT_LIMIT > 500 AND CUST_FIRST_NAME like 'D%';

-- Таблица - order_items

-- Найти среднее значение unit_price

SELECT avg(unit_price)
FROM order_items;

-- Таблицы - orderitems, productinformation

-- Вывести имена продуктов(PRODUCT_NAME), кол/во(QUANTITY) которых меньше среднего.

SELECT PRODUCT_NAME, QUANTITY
FROM product_information t1
JOIN order_items t2
ON t1.PRODUCT_ID = t2.PRODUCT_ID
WHERE QUANTITY < (SELECT avg(QUANTITY) FROM order_items);

-- Таблицы - orders, customers

-- Вывести имя и фамилию покупателя с максимальной общей суммой покупки(ORDER_TOTAL).

SELECT c.CUST_FIRST_NAME, c.CUST_LAST_NAME, SUM(o.ORDER_TOTAL) AS total_sales
FROM orders o
JOIN customers c ON o.CUSTOMER_ID = c.CUSTOMER_ID
GROUP BY c.CUST_FIRST_NAME, c.CUST_LAST_NAME
ORDER BY total_sales DESC
LIMIT 1;

-- Найти сумму общей суммы покупок(ORDER_TOTAL) всех мужчин покупателей.

SELECT SUM(o.ORDER_TOTAL) AS total_sales_men
FROM orders o
JOIN customers c ON o.CUSTOMER_ID = c.CUSTOMER_ID
WHERE c.GENDER = 'M';

