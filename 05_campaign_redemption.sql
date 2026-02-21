CREATE OR REPLACE VIEW `retail_customer_journey.vw_campaign_redemption` AS

SELECT
  ct.campaign,

  COUNT(DISTINCT ct.household_key) AS targeted_customers,
  COUNT(DISTINCT cr.household_key) AS redeemed_customers,

  ROUND(
    SAFE_DIVIDE(
      COUNT(DISTINCT cr.household_key),
      COUNT(DISTINCT ct.household_key)
    ),
    4
  ) AS redemption_rate

FROM `retail_customer_journey.campaign_table` ct

LEFT JOIN `retail_customer_journey.coupon_redemption` cr
  ON ct.household_key = cr.household_key
  AND ct.campaign = cr.campaign

GROUP BY ct.campaign
ORDER BY redemption_rate DESC;
