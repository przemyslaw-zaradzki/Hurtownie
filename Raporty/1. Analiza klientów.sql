-- Wiek klientów
SELECT 
YEAR(CURDATE()) - YEAR(dc.customer_birth_date) AS wiek,
COUNT(1)
FROM fact_rental_payment AS frp
JOIN dim_customer AS dc ON frp.customer_id = dc.customer_id
GROUP BY wiek

-- Miejsce wypożyczenia
SELECT
ds.store_country,
COUNT(1) 
FROM fact_rental_payment AS frp
JOIN dim_store AS ds ON frp.store_id = ds.store_id
GROUP BY ds.store_country

-- Skąd przyjeżdżają
SELECT 
dc.customer_country,
COUNT(1)
FROM fact_rental_payment AS frp
JOIN dim_customer AS dc ON frp.customer_id = dc.customer_id
GROUP BY dc.customer_country

-- Marki
SELECT
di.inventory_producer,
COUNT(1) 
FROM fact_rental_payment AS frp
JOIN dim_inventory AS di ON frp.inventory_id = di.inventory_id
GROUP BY di.inventory_producer 

-- Wiek auta
SELECT
YEAR(CURDATE()) - di.inventory_production_year AS wiek_auta,
COUNT(1) 
FROM fact_rental_payment AS frp
JOIN dim_inventory AS di ON frp.inventory_id = di.inventory_id
GROUP BY di.inventory_production_year

-- Długość wypożyczenia
SELECT
frp.rental_days
FROM fact_rental_payment AS frp
GROUP BY frp.rental_days