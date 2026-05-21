# Olist E-commerce SQL Analytics

End-to-end SQL analysis of 100K+ Brazilian e-commerce orders using SQLite. 
Five business-focused queries covering revenue trends, product performance, 
customer segmentation, regional spending, and cohort retention.

## Tableau Dashboard
**Live dashboard:** [Tableau Public →](https://public.tableau.com/app/profile/ziah.lin/viz/BrazilianE-CommerceDashboard_17793332672290/Dashboard1)

## Dataset

Olist Brazilian E-Commerce Public Dataset (Kaggle): 9 relational tables 
covering ~100K orders from 2016–2018, including customers, orders, items, 
products, sellers, payments, and reviews.

Source: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

## Tools

SQLite, DB Browser for SQLite

## Techniques Demonstrated

- Multi-table JOINs across 9 normalized tables
- Common Table Expressions (CTEs)
- Window functions (LAG for period-over-period comparisons)
- Conditional aggregation (CASE WHEN)
- Date manipulation and cohort analysis
- COALESCE for NULL handling

## Key Findings

### 1. Monthly Revenue & Growth Trends
**Question:** How is revenue trending over time?

**Findings:** Peak revenue month was 2017-11 at $1153364, driven by Brazil's 
Black Friday. Highest growth occurred during the platform's 2017 scaling 
phase, with 649657.2% month-over-month growth in January.

**Implication:** Revenue growth was acquisition-driven, with clear Q4 
seasonality requiring inventory and infrastructure planning.

### 2. Top Product Categories by Revenue
**Question:** Which categories drive the most revenue?

**Findings:** health and beauty led with $1258681.34 in revenue across 2444 unique 
products.

**Implication:** Long-tail e-commerce pattern — concentrated revenue in a 
handful of categories suggests targeted inventory and marketing investment 
opportunities.

### 3. Customer Segmentation
**Question:** How do customers segment by purchase behavior?

**Findings:** 97% of customers were one-time buyers, generating 94.5% of 
total revenue. VIP customers (>$1,000 lifetime spend) made up just 0.09% 
of the base and contributed under 1% of revenue. Repeat customers — 
defined here as multi-order buyers under the VIP threshold — accounted 
for 2.9% of customers and 4.6% of revenue.

**Implication:** Unlike typical e-commerce platforms where a small VIP 
segment drives outsized revenue, Olist's marketplace model is overwhelmingly 
acquisition-driven. There is virtually no high-value repeat segment to 
retain or upsell — growth depends almost entirely on bringing in new 
buyers. This pattern is consistent with the platform's role as an 
occasional-purchase marketplace (gifts, one-off needs) rather than a 
recurring shopping destination.

### 4. Average Order Value by Brazilian State

**Question:** Which regions drive the most revenue, and where is spending 
per order highest?

**Findings:** São Paulo (SP) dominated total revenue at $5.77M across 40,501 
orders — nearly 3× the volume of the next state (Rio de Janeiro at $2.06M). 
However, SP also had the **lowest AOV among the top 15 states** at $142.46. 
The highest AOVs came from less commercially central northern states: 
Pará (PA) at $224.13, Ceará (CE) at $208.32, and Maranhão (MA) at $206.14 — 
all roughly 40–55% higher than SP's average.

**Implication:** A clear inverse pattern exists between order volume and 
order size. SP and the southeast generate the bulk of revenue through 
high-frequency, lower-value orders — likely reflecting better logistics 
access and Olist's regional concentration. Northern states have far fewer 
orders but spend substantially more per order, possibly because higher 
shipping costs make small purchases impractical, so customers consolidate 
into larger baskets. This suggests differentiated regional strategies: 
volume optimization in the south, basket-size and shipping-cost messaging 
in the north.

### 5. 90-Day Cohort Retention

**Question:** Do new customers return within 90 days, and is retention 
improving over time?

**Findings:** 90-day retention was strikingly low across every cohort — 
ranging from 0.3% to 1.8%, with most months clustered between 1.0% and 
1.4%. There was no meaningful improvement over the 21-month observation 
window: the 2018 cohorts retained at essentially the same rate as 2017 
cohorts. October 2016 had zero returning customers (consistent with the 
platform's pre-launch state), and the August 2018 figure (0.3%) is 
artificially low because the dataset cuts off before its 90-day window 
closes.

**Implication:** Olist's marketplace shows extreme one-and-done behavior — 
fewer than 2 in 100 new customers place another order within 90 days. 
Combined with the segmentation finding (97% of customers are one-time 
buyers), this confirms the platform is structurally acquisition-dependent. 
Despite scaling from ~700 to ~7,000 monthly new customers between early 
2017 and late 2017, the platform built no compounding customer base. 
For sustained growth, Olist would need to invest in retention mechanisms 
(loyalty programs, replenishment categories, post-purchase re-engagement) 
to reduce its dependence on continuous new-customer acquisition.

## Repo Structure

\`\`\`
olist-sql-analytics/
├── README.md
├── queries/
│   ├── 01_monthly_revenue.sql
│   ├── 02_top_categories.sql
│   ├── 03_customer_segments.sql
│   ├── 04_aov_by_state.sql
│   └── 05_cohort_retention.sql
└── results/
    ├── query1_monthly_revenue.csv
    ├── query2_top_categories.csv
    ├── query3_customer_segments.csv
    ├── query4_aov_by_state.csv
    └── query5_cohort_retention.csv
\`\`\`

## How to Reproduce

1. Download the Olist dataset from Kaggle (link above)
2. Install DB Browser for SQLite (sqlitebrowser.org)
3. Create a new database and import all 9 CSVs as tables. **Make sure "Column names in first line" is checked** during each import.
4. Open the queries in `/queries` and run them in order in the Execute SQL tab.

## Notes

- November 2016 has no delivered orders — Olist was in soft-launch mode.
- August 2018 retention is artificially low because the dataset cuts off before that cohort's 90-day window closes.
- Olist anonymizes product names in the public dataset; analysis is therefore done at the category level.
