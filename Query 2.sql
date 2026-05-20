-- Query 2: Top Product Categories by Revenue
-- Business question: Which categories drive the most revenue?
-- Techniques: Multi-table JOIN, LEFT JOIN, COALESCE (NULL handling), COUNT(DISTINCT), aggregation

SELECT 
  COALESCE(t.product_category_name_english, p.product_category_name, 'unknown') AS category,
  COUNT(DISTINCT oi.product_id) AS unique_products,
  COUNT(*) AS units_sold,
  ROUND(SUM(oi.price), 2) AS revenue,
  ROUND(SUM(oi.price) / COUNT(*), 2) AS avg_price_per_unit
FROM olist_order_items_dataset oi
JOIN olist_products_dataset p ON oi.product_id = p.product_id
LEFT JOIN product_category_name_translation t 
  ON p.product_category_name = t.product_category_name
GROUP BY category
ORDER BY revenue DESC
LIMIT 10;