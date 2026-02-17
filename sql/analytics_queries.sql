-- Revenue by origin country
SELECT origin_country,
       SUM(estimated_revenue) AS total_revenue
FROM sales_data
GROUP BY origin_country
ORDER BY total_revenue DESC;

-- Top 5 products per country by revenue (CTE + Window Function)
WITH ranked_products AS (
    SELECT origin_country,
           product_id,
           SUM(estimated_revenue) AS revenue,
           ROW_NUMBER() OVER (
               PARTITION BY origin_country
               ORDER BY SUM(estimated_revenue) DESC
           ) AS rn
    FROM sales_data
    GROUP BY origin_country, product_id
)
SELECT origin_country, product_id, revenue, rn
FROM ranked_products
WHERE rn <= 5
ORDER BY origin_country, rn;

