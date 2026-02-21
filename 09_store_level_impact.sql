CREATE OR REPLACE VIEW `retail_customer_journey.vw_store_level_impact` AS

WITH weekly_sales AS (
  SELECT
    store_id,
    product_id,
    week_no,
    SUM(sales_value) AS weekly_sales
  FROM `retail_customer_journey.transaction_data`
  GROUP BY store_id, product_id, week_no
)

SELECT
  cd.display,
  ROUND(AVG(ws.weekly_sales),2) AS avg_weekly_sales
FROM weekly_sales ws
JOIN `retail_customer_journey.casual_data` cd
  ON ws.store_id = cd.store_id
  AND ws.product_id = cd.product_id
  AND ws.week_no = cd.week_no
GROUP BY cd.display;