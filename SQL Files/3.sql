/*3.Generate a report that displays each campaign along with the total revenue generated before 
and after the campaign? The report includes three key fields: 
campaign_name, 
totaI_revenue(before_promotion), 
totaI_revenue(after_promotion). */

 WITH PromoPrices AS (
    SELECT
        fe.*,
        CASE
            WHEN fe.promo_type = '50% OFF' THEN fe.base_price * 0.5
            WHEN fe.promo_type = '33% OFF' THEN fe.base_price * 0.67
            WHEN fe.promo_type = '25% OFF' THEN fe.base_price * 0.75
            WHEN fe.promo_type = '500 Cashback' THEN fe.base_price - 500
            WHEN fe.promo_type = 'BOGOF' THEN fe.base_price / 2
            ELSE fe.base_price  
        END AS promo_price
    FROM
        fact_events fe
)
SELECT
    dc.campaign_name,
    ROUND(SUM(f.`quantity_sold(before_promo)` * f.base_price) / 1000000, 2) AS total_revenue_before_promotion,
    ROUND(SUM(f.`quantity_sold(after_promo)` * p.promo_price) / 1000000, 2) AS total_revenue_after_promotion
FROM
    dim_campaigns dc
JOIN
    fact_events f ON dc.campaign_id = f.campaign_id
JOIN
    PromoPrices p ON p.event_id = f.event_id
GROUP BY
    dc.campaign_name;
