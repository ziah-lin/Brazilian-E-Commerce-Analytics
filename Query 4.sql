-- Query 4: Average Order Value by Brazilian State
-- Business question: Which regions have the highest AOV and total revenue?
-- Techniques: Multi-table JOIN, derived metric (SUM / COUNT DISTINCT), aggregation

SELECT 
  c.customer_state,
  COUNT(DISTINCT o.order_id) AS orders,
  ROUND(SUM(oi.price + oi.freight_value) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value,
  ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue
FROM olist_customers_dataset c
JOIN olist_orders_dataset o ON c.customer_id = o.customer_id
JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY total_revenue DESC
LIMIT 15;