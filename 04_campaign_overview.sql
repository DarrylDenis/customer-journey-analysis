CREATE OR REPLACE VIEW `retail_customer_journey.vw_campaign_overview` AS

SELECT
    cd.campaign,
    cd.start_day,
    cd.end_day,
    (cd.end_day - cd.start_day) AS campaign_duration_days,

    COUNT(DISTINCT ct.household_key) AS targeted_customers

FROM `retail_customer_journey.campaign_desc` cd
LEFT JOIN `retail_customer_journey.campaign_table` ct
    ON cd.campaign = ct.campaign

GROUP BY cd.campaign, cd.start_day, cd.end_day
ORDER BY targeted_customers DESC;
