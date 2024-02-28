/* 4.	Produce a report that calculates the Incremental Sold Quantity (ISU%) for each category 
during the Diwali campaign. 
Additionally, provide rankings for the categories based on their ISU%. 
The report will include three key fields: category, isu%, and rank order. */

   SELECT
    p.category,
    ((SUM(f.`quantity_sold(after_promo)`)-SUM(f.`quantity_sold(before_promo)`))/SUM(f.`quantity_sold(before_promo)`) * 100) AS ISU_percentage ,
    RANK() 
    OVER (ORDER BY((SUM(f.`quantity_sold(after_promo)`)-SUM(f.`quantity_sold(before_promo)`)) / SUM(f.`quantity_sold(before_promo)`) * 100) DESC) 
    AS Rank_order
FROM
    dim_products p
JOIN
    fact_events f ON p.product_code = f.product_code
WHERE
    f.campaign_id = 'CAMP_DIW_01'
GROUP BY
    p.category
ORDER BY
    ISU_percentage DESC;