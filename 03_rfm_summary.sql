CREATE OR REPLACE VIEW `retail_customer_journey.vw_rfm_summary` AS

SELECT
  rfm_segment,
  COUNT(*) AS customer_count,
  SUM(monetary) AS total_revenue,

  ROUND(
    COUNT(*) / SUM(COUNT(*)) OVER(),
    4
  ) AS pct_customers,

  ROUND(
    SUM(monetary) / SUM(SUM(monetary)) OVER(),
    4
  ) AS pct_revenue

FROM `retail_customer_journey.vw_customer_clv_rfm`
GROUP BY rfm_segment
ORDER BY total_revenue DESC;