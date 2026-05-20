-- Query 1: Monthly Revenue & Growth Trends
-- Business question: How is revenue trending over time, and which months show the strongest growth?
-- Techniques: CTE, multi-table JOIN, date manipulation (substr), window function (LAG), aggregation

WITH monthly AS (
  SELECT 
    substr(o.order_purchase_timestamp, 1, 7) AS month,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS revenue
  FROM olist_orders_dataset o
  JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
  WHERE o.order_status = 'delivered'
  GROUP BY month
)
SELECT 
  month,
  revenue,
  ROUND(100.0 * (revenue - LAG(revenue) OVER (ORDER BY month)) 
        / LAG(revenue) OVER (ORDER BY month), 1) AS growth_pct
FROM monthly
ORDER BY month;