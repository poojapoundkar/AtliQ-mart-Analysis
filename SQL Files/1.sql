/* 1.	Provide a list of products with a base price greater than 500 and that are featured in promo type 
of 'BOGOF' (Buy One Get One Free). */

select p.product_name,f.product_code,f.base_price,f.promo_type
from dim_products p
join fact_events f 
on p.product_code=f.product_code
where f.base_price>500 AND f.promo_type="BOGOF";