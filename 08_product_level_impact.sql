CREATE OR REPLACE VIEW `retail_customer_journey.vw_product_level_impact` AS

SELECT 
    p.department,
    ROUND(SUM(t.sales_value),2) AS total_revenue
FROM `retail_customer_journey.transaction_data` t
JOIN `retail_customer_journey.coupons` c 
    ON t.product_id = c.product_id
JOIN `retail_customer_journey.product` p 
    ON p.product_id = t.product_id
GROUP BY p.department
ORDER BY total_revenue DESC;
