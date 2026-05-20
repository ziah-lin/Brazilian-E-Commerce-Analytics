-- Query 3: Customer Segmentation (One-time / Repeat / VIP)
-- Business question: How do customers segment by purchase behavior, and where is revenue concentrated?
-- Techniques: CTE, multi-table JOIN, CASE WHEN, conditional aggregation

WITH customer_stats AS (
  SELECT 
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS order_count,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_spent
  FROM olist_customers_dataset c
  JOIN olist_orders_dataset o ON c.customer_id = o.customer_id
  JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
  WHERE o.order_status = 'delivered'
  GROUP BY c.customer_unique_id
)
SELECT 
  CASE 
    WHEN order_count = 1 THEN 'One-time'
    WHEN total_spent > 1000 THEN 'VIP'
    ELSE 'Repeat'
  END AS segment,
  COUNT(*) AS customers,
  ROUND(AVG(total_spent), 2) AS avg_spend,
  ROUND(SUM(total_spent), 2) AS segment_revenue
FROM customer_stats
GROUP BY segment
ORDER BY avg_spend DESC;