-- ** ranking wypożyczaln
WITH dim_store_sum_payment AS (
	SELECT
	frp.store_id,
	SUM(frp.payment_amount) AS income
	FROM fact_rental_payment AS frp
	GROUP BY frp.store_id
)

SELECT
ds.store_id,
ds.store_country,
ds.store_city,
ds.store_postal_code,
ds.store_address,
ds_sum.income
FROM dim_store AS ds
JOIN dim_store_sum_payment AS ds_sum ON ds.store_id = ds_sum.store_id