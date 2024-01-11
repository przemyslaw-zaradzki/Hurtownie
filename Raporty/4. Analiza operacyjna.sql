-- Przychody - (bieżący rok vs. poprzedni, zestawienie bieżące, podział na sprzedawców/lokalizacje)
WITH dim_staff_sum_payment AS (
	SELECT
	frp.staff_id,
	SUM(frp.payment_amount) AS income
	FROM fact_rental_payment AS frp
	GROUP BY frp.staff_id
)

SELECT
ds.staff_id,
ds.staff_name,
ds.staff_country,
ds.staff_city,
ds.staff_postal_code,
ds.staff_address,
ds_sum.income
FROM dim_staff AS ds
JOIN dim_staff_sum_payment AS ds_sum ON ds.staff_id = ds_sum.staff_id


-- Zaległości klientów (opóźnienia w regulowaniu zobowiązań przez klientów, gdzie powstają)
SELECT
ds.store_country,
COUNT(1)
FROM fact_rental_payment AS frp
JOIN dim_store AS ds ON frp.store_id = ds.store_id
WHERE frp.days_to_deadline > 0
GROUP BY ds.store_country