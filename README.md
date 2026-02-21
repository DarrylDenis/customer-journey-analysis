Customer Journey & Campaign Lift Analysis
📌 Project Overview

This project analyzes retail campaign performance and customer segmentation using SQL and Tableau.

The objective was to:

Evaluate incremental revenue lift

Compare treatment vs control performance

Segment customers using RFM analysis

Identify revenue concentration risks

Recommend retention and optimization strategies

📈 Executive Summary (From Dashboard Insights)
🔹 Campaign Performance

Total Campaigns Analyzed: 30

Campaigns with Positive Incremental Lift: 18

Average Incremental Lift: 9.2%

Average Incremental Revenue: 5,378

Average Redemption Rate: 9.1%

Top 3 campaigns contributed ~35% of total incremental impact

👉 Insight: A small group of campaigns drives disproportionate value, indicating strong optimization potential.

💰 Overall Business Metrics

Total Revenue: 8,057,463

Total Customers: 2,500

Average Revenue per Customer: 3,223

🎯 Incremental Lift Analysis
Treatment vs Control Comparison

Multiple campaigns show strong positive lift (>5%)

Worst performing campaign shows -3.48% net incremental impact

Some campaigns had positive treatment % change but weak incremental conversion efficiency

👉 Insight:
Campaign effectiveness is uneven — optimization should focus on scaling top performers and diagnosing underperformers.

📊 Campaign Efficiency Matrix Insight

From the scatter plot:

Majority of high-performing campaigns fall in:

Positive Treatment % Change

Positive Incremental Lift %

Negative quadrant campaigns:

Show both negative treatment response and negative lift

Likely caused revenue cannibalization or poor targeting

👉 Strategic Action:
Segment-based targeting should replace blanket campaign execution.

👥 RFM Segment Performance
Revenue Contribution by Segment
Segment	Revenue Contribution
At Risk	43.7%
Potential	22.4%
Lost	19.9%
Loyal	10.4%
Champions	3.6%

⚠️ 63% of revenue comes from At-Risk + Lost customers.

This exposes major retention risk.
Customer Distribution
Segment	% of Customers
Potential	25.3%
Loyal	23.4%
At Risk	23.0%
Champions	21.5%
Lost	6.7%

👉 Insight:
High-value revenue does NOT come from high customer volume segments.

💵 Revenue per Customer by Segment
Segment	Revenue per Customer
At Risk	6,117
Potential	2,856
Loyal	1,424
Champions	537

👉 At-Risk customers generate the highest revenue per customer.

This confirms:
Retention campaigns should be prioritized over acquisition.

🔥 RFM Heatmap Insight (Recency vs Frequency)

Highest revenue cluster:

R = 5, F = 1 → 1,789,016

R = 4, F = 1 → 1,230,111

R = 3, F = 1 → 848,515

Revenue concentration is skewed toward:

Recently active but low frequency buyers.

👉 Insight:
Increasing purchase frequency of high-recency customers could unlock significant incremental revenue.

🚀 Strategic Recommendations

Prioritize retention campaigns targeting "At Risk" segment.

Increase frequency among high-recency customers.

Scale top 3 performing campaigns.

Rework or discontinue campaigns in negative lift quadrant.

Implement segmented targeting instead of broad campaigns.

## 📊 Interactive Tableau Dashboard

Explore the full interactive dashboard here:

🔗 Live Dashboard (Tableau Public):  
https://public.tableau.com/views/customerjourneyanalysis/incrementalliftanalysis


### What the Dashboard Includes

- Incremental Revenue & Lift Analysis
- Treatment vs Control Comparison
- Campaign Efficiency Matrix
- RFM Revenue Heatmap (Recency vs Frequency)
- Revenue Concentration by Segment
- Revenue per Customer by Segment

> The dashboard evaluates 30 campaigns, highlighting that 18 generated positive incremental lift with an average lift of 9.2%.

🛠 Tools Used

SQL (CTEs, Aggregations, Window Functions)

BigQuery-style structured queries

Tableau for dashboard visualization

Git for version control

💡 Skills Demonstrated

Incremental Lift Modeling

Control vs Treatment Analysis

RFM Segmentation

Revenue Concentration Analysis

Campaign Efficiency Evaluation

Data Storytelling

Business Insight Generation

Author
Darryl Denis
SQL | Tableau | Data Analytics | Marketing Analytics
