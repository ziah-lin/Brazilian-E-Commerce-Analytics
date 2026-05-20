WITH first_orders AS (
  SELECT 
    c.customer_unique_id,
    MIN(o.order_purchase_timestamp) AS first_order_date
  FROM olist_customers_dataset c
  JOIN olist_orders_dataset o ON c.customer_id = o.customer_id
  WHERE o.order_status = 'delivered'
  GROUP BY c.customer_unique_id
),
returns AS (
  SELECT 
    f.customer_unique_id,
    substr(f.first_order_date, 1, 7) AS cohort_month,
    MAX(CASE 
      WHEN julianday(o.order_purchase_timestamp) - julianday(f.first_order_date) 
           BETWEEN 1 AND 90 THEN 1 ELSE 0 
    END) AS returned_within_90d
  FROM first_orders f
  JOIN olist_customers_dataset c ON c.customer_unique_id = f.customer_unique_id
  JOIN olist_orders_dataset o ON c.customer_id = o.customer_id
  WHERE o.order_status = 'delivered'
  GROUP BY f.customer_unique_id, cohort_month
)
SELECT 
  cohort_month,
  COUNT(*) AS new_customers,
  SUM(returned_within_90d) AS returning_customers,
  ROUND(100.0 * SUM(returned_within_90d) / COUNT(*), 1) AS retention_pct
FROM returns
GROUP BY cohort_month
HAVING COUNT(*) >= 50
ORDER BY cohort_month;