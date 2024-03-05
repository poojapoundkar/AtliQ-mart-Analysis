/*3.Generate a report that displays each campaign along with the total revenue generated before 
and after the campaign? The report includes three key fields: 
campaign_name, 
totaI_revenue(before_promotion), 
totaI_revenue(after_promotion). */

 select distinct(p1.campaign_name) as campaigns, 
concat(round(sum(p2.`quantity_sold(before_promo)`*p2.base_price)/1000000,2),' ' 'M') as revenue_before_promo, CONCAT(round(sum(p2.`quantity_sold(after_promo)`*p2.base_price)/1000000,2),' ' 'M') as revenue_after_revenue
from fact_events as p2
inner join dim_campaigns as p1
ON p1.campaign_id = p2.campaign_id
group by campaigns
order by campaigns asc;
