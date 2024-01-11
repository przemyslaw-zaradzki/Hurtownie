-- Analiza klientów powracających
-- Czy chcemy dodać do wymiaru customer liczbę wypożyczeń ???
WITH dim_customer_rental_cnt AS (
	SELECT
	dc.customer_id,
	COUNT(1) AS rental_cnt
	FROM fact_rental_payment AS frp
	JOIN dim_customer AS dc ON frp.customer_id = dc.customer_id
	GROUP BY dc.customer_id
), returning_customers_id AS (
	SELECT
	dc_rnt_cnt.customer_id
	FROM dim_customer_rental_cnt AS dc_rnt_cnt
	WHERE dc_rnt_cnt.rental_cnt >= 2
), non_returning_customers_id AS (
	SELECT
	dc_rnt_cnt.customer_id
	FROM dim_customer_rental_cnt AS dc_rnt_cnt
	WHERE dc_rnt_cnt.rental_cnt = 1
)

-- Histogram liczba wypożyczeń
SELECT
COUNT(1) AS histogram_liczba_wypożyczeń
FROM dim_customer_rental_cnt AS dc_cnt
GROUP BY dc_cnt.rental_cnt

-- Wiek klientów
SELECT 
YEAR(CURDATE()) - YEAR(dc.customer_birth_date) AS wiek,
COUNT(1)
FROM fact_rental_payment AS frp
JOIN returning_customers_id AS dc_rnt_id ON frp.customer_id = dc_rnt_id.customer_id
JOIN dim_customer AS dc ON frp.customer_id = dc.customer_id
GROUP BY wiek

-- Skąd przyjeżdżają
SELECT 
dc.customer_country,
COUNT(1)
FROM fact_rental_payment AS frp
JOIN returning_customers_id AS dc_rnt_id ON frp.customer_id = dc_rnt_id.customer_id
JOIN dim_customer AS dc ON frp.customer_id = dc.customer_id
GROUP BY customer_country