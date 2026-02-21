WITH campaign_info AS (
    SELECT
        campaign,
        start_day,
        end_day
    FROM `retail_customer_journey.campaign_desc`
),

treatment_households AS (
    SELECT DISTINCT
        campaign,
        household_key
    FROM `retail_customer_journey.campaign_table`
),

all_households AS (
    SELECT DISTINCT household_key
    FROM `retail_customer_journey.transaction_data`
),

control_households AS (
    SELECT
        ci.campaign,
        ah.household_key
    FROM campaign_info ci
    CROSS JOIN all_households ah
    LEFT JOIN treatment_households th
        ON ci.campaign = th.campaign
        AND ah.household_key = th.household_key
    WHERE th.household_key IS NULL
),

customer_groups AS (
    SELECT
        campaign,
        household_key,
        'treatment' AS group_type
    FROM treatment_households

    UNION ALL

    SELECT
        campaign,
        household_key,
        'control' AS group_type
    FROM control_households
),

campaign_transactions AS (
    SELECT
        cg.campaign,
        cg.group_type,
        td.household_key,
        td.sales_value,
        CASE
            WHEN td.day BETWEEN ci.start_day - 29 AND ci.start_day - 1 THEN 'before'
            WHEN td.day BETWEEN ci.start_day AND ci.end_day THEN 'during'
        END AS period
    FROM customer_groups cg
    JOIN campaign_info ci
        ON cg.campaign = ci.campaign
    JOIN `retail_customer_journey.transaction_data` td
        ON cg.household_key = td.household_key
    WHERE td.day BETWEEN ci.start_day - 29 AND ci.end_day
),

group_revenue AS (
    SELECT
        campaign,
        group_type,
        period,
        AVG(sales_value) AS avg_revenue
    FROM campaign_transactions
    WHERE period IS NOT NULL
    GROUP BY campaign, group_type, period
),

pivoted AS (
    SELECT
        campaign,
        group_type,
        MAX(CASE WHEN period = 'before' THEN avg_revenue END) AS revenue_before,
        MAX(CASE WHEN period = 'during' THEN avg_revenue END) AS revenue_during
    FROM group_revenue
    GROUP BY campaign, group_type
)

SELECT
    t.campaign,

    -- Absolute values
    t.revenue_before  AS treatment_before,
    t.revenue_during  AS treatment_during,
    c.revenue_before  AS control_before,
    c.revenue_during  AS control_during,

    -- Absolute Changes
    (t.revenue_during - t.revenue_before) AS treatment_change,
    (c.revenue_during - c.revenue_before) AS control_change,

    -- Absolute Incremental Lift (DiD)
    ((t.revenue_during - t.revenue_before)
     -
     (c.revenue_during - c.revenue_before)) AS incremental_lift,

    -- Percentage Changes
    ROUND(
        SAFE_DIVIDE(
            (t.revenue_during - t.revenue_before),
            t.revenue_before
        ) * 100, 2
    ) AS treatment_pct_change,

    ROUND(
        SAFE_DIVIDE(
            (c.revenue_during - c.revenue_before),
            c.revenue_before
        ) * 100, 2
    ) AS control_pct_change,

    -- Percentage Incremental Lift
    ROUND(
        (
            SAFE_DIVIDE(
                (t.revenue_during - t.revenue_before),
                t.revenue_before
            )
            -
            SAFE_DIVIDE(
                (c.revenue_during - c.revenue_before),
                c.revenue_before
            )
        ) * 100, 2
    ) AS incremental_lift_pct

FROM pivoted t
JOIN pivoted c
    ON t.campaign = c.campaign
WHERE t.group_type = 'treatment'
  AND c.group_type = 'control'
ORDER BY incremental_lift DESC;
