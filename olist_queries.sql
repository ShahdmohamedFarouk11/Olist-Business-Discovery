-- Check the total number of orders and customers
SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers
FROM orders;


-- Check the distribution of order statuses
SELECT
    order_status,
    COUNT(*) AS order_count
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;


-- Check the total order value and average item price
SELECT
    SUM(price) AS total_order_value,
    AVG(price) AS avg_item_price
FROM items;


-- Check the number of items and value for each order
SELECT
    order_id,
    COUNT(*) AS items_count,
    SUM(price) AS order_value,
    SUM(freight_value) AS freight_value
FROM items
GROUP BY order_id;
/*________________________________________________________________________*/

-- See which orders were late
SELECT
    CASE
        WHEN order_delivered_customer_date <= order_estimated_delivery_date
        THEN 'On Time'
        ELSE 'Late'
    END AS delivery_status,
    COUNT(*) AS order_count
FROM orders
WHERE order_status = 'delivered'
GROUP BY
    CASE
        WHEN order_delivered_customer_date <= order_estimated_delivery_date
        THEN 'On Time'
        ELSE 'Late'
    END;

    -- Check how many days late the orders were
SELECT
    AVG(DATEDIFF(day, order_estimated_delivery_date, order_delivered_customer_date)) As avg_delay_days
    ,max(DATEDIFF(day, order_estimated_delivery_date, order_delivered_customer_date))
        AS max_delay_days 
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date > order_estimated_delivery_date;


  -- Check delay by number of items
SELECT
    items_count,
    AVG(delay_days) AS average_delay
FROM (
    SELECT
        o.order_id,
        COUNT(i.order_item_id) AS items_count,
        DATEDIFF(day, o.order_estimated_delivery_date, o.order_delivered_customer_date) AS delay_days
    FROM orders o
    JOIN items i
        ON o.order_id = i.order_id
    WHERE o.order_status = 'delivered'
      AND o.order_delivered_customer_date > o.order_estimated_delivery_date
    GROUP BY
        o.order_id,
        o.order_estimated_delivery_date,
        o.order_delivered_customer_date
) AS late_orders
GROUP BY items_count
ORDER BY items_count;



-- Check if delay is related to order value
SELECT
    CASE
        WHEN order_value < 100 THEN 'Below 100'
        WHEN order_value < 300 THEN '100 - 299'
        WHEN order_value < 500 THEN '300 - 499'
        ELSE '500+'
    END AS value_range,
    COUNT(*) AS order_count,
    AVG(delay_days) AS average_delay
FROM (
    SELECT
        o.order_id,
        SUM(i.price) AS order_value,
        DATEDIFF(
            day,
            o.order_estimated_delivery_date,
            o.order_delivered_customer_date
        ) AS delay_days
    FROM orders o
    JOIN items i
        ON o.order_id = i.order_id
    WHERE o.order_status = 'delivered'
      AND o.order_delivered_customer_date > o.order_estimated_delivery_date
    GROUP BY
        o.order_id,
        o.order_estimated_delivery_date,
        o.order_delivered_customer_date
) AS late_orders
GROUP BY
    CASE
        WHEN order_value < 100 THEN 'Below 100'
        WHEN order_value < 300 THEN '100 - 299'
        WHEN order_value < 500 THEN '300 - 499'
        ELSE '500+'
    END
ORDER BY average_delay DESC;

-- Check delivery delay by month
SELECT
    YEAR(order_delivered_customer_date) AS delivery_year,
    MONTH(order_delivered_customer_date) AS delivery_month,
    COUNT(*) AS late_orders,
    AVG(
        DATEDIFF(
            day,
            order_estimated_delivery_date,
            order_delivered_customer_date
        )
    ) AS average_delay
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date > order_estimated_delivery_date
GROUP BY
    YEAR(order_delivered_customer_date),
    MONTH(order_delivered_customer_date)
ORDER BY
    delivery_year,
    delivery_month;

    -- Check the late delivery rate by month
SELECT
    YEAR(order_delivered_customer_date) AS delivery_year,
    MONTH(order_delivered_customer_date) AS delivery_month,
    COUNT(*) AS delivered_orders,
    SUM(
        CASE
            WHEN order_delivered_customer_date > order_estimated_delivery_date
            THEN 1
            ELSE 0
        END
 ) AS late_orders,
    CAST(
        100.0 * SUM(
            CASE
                WHEN order_delivered_customer_date > order_estimated_delivery_date
               THEN 1
               ELSE 0
            END
        ) / COUNT(*)
        AS DECIMAL(5,2)
    ) AS late_rate
FROM orders
WHERE order_status = 'delivered'
GROUP BY
    YEAR(order_delivered_customer_date),
    MONTH(order_delivered_customer_date)
ORDER BY
    delivery_year,
    delivery_month;


    -- Check review scores for delivered orders
SELECT
    r.review_score,
    COUNT(*) AS review_count
FROM reviews r
JOIN orders o
    ON r.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY r.review_score
ORDER BY r.review_score;

-- Compare review scores for late and on-time orders
-- and check when negative reviews started and ended

SELECT
    CASE
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
        THEN 'Late'
        ELSE 'On Time'
    END AS delivery_status,
    COUNT(DISTINCT r.order_id) AS reviewed_orders,
    AVG(CAST(r.review_score AS DECIMAL(10,2))) AS average_review_score,
    MIN(CASE
        WHEN r.review_score IN (1, 2)
        THEN r.review_creation_date
    END) AS first_negative_review,
    MAX(CASE
        WHEN r.review_score IN (1, 2)
        THEN r.review_creation_date
    END) AS last_negative_review
FROM orders o
JOIN reviews r
    ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY
    CASE
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
        THEN 'Late'
        ELSE 'On Time'
    END;