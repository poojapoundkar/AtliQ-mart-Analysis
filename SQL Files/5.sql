/* Create a report featuring the Top 5 products, ranked by Incremental Revenue Percentage (IR%), 
across all campaigns. 
The report will provide essential information including product name, category, and ir%. 
This analysis helps identify the most successful products in terms of incremental revenue across our campaigns,
 assisting in product optimization.*/
 
SELECT
    p.product_name,
    p.category,
    round((
        (SUM(f.base_price * f.`quantity_sold(after_promo)`) - SUM(f.base_price * f.`quantity_sold(before_promo)`)) /
         SUM(f.base_price * f.`quantity_sold(before_promo)`)
    ) * 100 ,2) AS IR_percentage
FROM
    dim_products p
JOIN
    fact_events f ON p.product_code = f.product_code
GROUP BY
    p.product_name, p.category
ORDER BY
    IR_percentage DESC
LIMIT 5;