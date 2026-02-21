CREATE OR REPLACE VIEW `retail_customer_journey.vw_campaign_revenue_lift` AS

WITH campaign_window AS (
  SELECT
    cd.campaign,
    cd.start_day,
    cd.end_day,
    ct.household_key
  FROM `retail_customer_journey.campaign_desc` cd
  JOIN `retail_customer_journey.campaign_table` ct
    ON cd.campaign = ct.campaign
),

revenue_calc AS (
  SELECT
    cw.campaign,
    cw.household_key,

    SUM(CASE 
          WHEN td.day BETWEEN cw.start_day - 29 AND cw.start_day - 1 
          THEN td.sales_value 
        END) AS revenue_before,

    SUM(CASE 
          WHEN td.day BETWEEN cw.start_day AND cw.end_day 
          THEN td.sales_value 
        END) AS revenue_during

  FROM campaign_window cw
  JOIN `retail_customer_journey.transaction_data` td
    ON cw.household_key = td.household_key

  GROUP BY cw.campaign, cw.household_key
)

SELECT
  campaign,
  ROUND(AVG(revenue_before),2) AS avg_revenue_before,
  ROUND(AVG(revenue_during),2) AS avg_revenue_during,
  ROUND(AVG(revenue_during - revenue_before),2) AS avg_revenue_lift

FROM revenue_calc
GROUP BY campaign
ORDER BY avg_revenue_lift DESC;