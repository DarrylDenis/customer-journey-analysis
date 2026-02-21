CREATE OR REPLACE VIEW `retail_customer_journey.vw_customer_clv_rfm` AS

WITH max_day_cte AS (
  SELECT MAX(day) AS max_day
  FROM `retail_customer_journey.transaction_data`
),

customer_base AS (
  SELECT
    t.household_key,
    SUM(t.sales_value) AS revenue,              
    COUNT(*) AS frequency,
    SUM(t.sales_value) AS monetary,
    MIN(t.day) AS first_purchase_day,
    MAX(t.day) AS last_purchase_day,
    MAX(t.day) - MIN(t.day) AS tenure_days
  FROM `retail_customer_journey.transaction_data` t
  GROUP BY t.household_key
),

rfm_calculated AS (
  SELECT
    cb.*,
    (m.max_day - cb.last_purchase_day) AS recency_days
  FROM customer_base cb
  CROSS JOIN max_day_cte m
),

rfm_scored AS (
  SELECT
    *,
    NTILE(5) OVER (ORDER BY recency_days DESC) AS r_score,

    NTILE(5) OVER (ORDER BY frequency DESC) AS f_score,

    NTILE(5) OVER (ORDER BY monetary DESC) AS m_score,
    
    NTILE(5) OVER (ORDER BY revenue DESC) AS revenue_tier

  FROM rfm_calculated
)

SELECT
  *,
  (r_score + f_score + m_score) AS rfm_score,

  CASE
    WHEN (r_score + f_score + m_score) BETWEEN 13 AND 15 THEN 'Champions'
    WHEN (r_score + f_score + m_score) BETWEEN 10 AND 12 THEN 'Loyal'
    WHEN (r_score + f_score + m_score) BETWEEN 7 AND 9 THEN 'Potential'
    WHEN (r_score + f_score + m_score) BETWEEN 4 AND 6 THEN 'At Risk'
    ELSE 'Lost'
  END AS rfm_segment

FROM rfm_scored;
