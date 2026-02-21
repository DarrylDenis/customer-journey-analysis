CREATE OR REPLACE VIEW `retail_customer_journey.vw_revenue_concentration` AS

SELECT
  revenue_tier,
  COUNT(household_key) AS customers_in_tier,
  SUM(revenue) AS tier_revenue,

  COUNT(*) / SUM(COUNT(*)) OVER() AS pct_customers,

  ROUND(
    SUM(revenue) / SUM(SUM(revenue)) OVER(),
    4
  ) AS pct_total_revenue

FROM `retail_customer_journey.vw_customer_clv_rfm`
GROUP BY revenue_tier
ORDER BY revenue_tier;