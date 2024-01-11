-- Jak się zmieniła struktura wypożyczeń (liczba, samochody, miejsca)?
-- Liczba
SELECT
dc.calendar_year,
COUNT(1) 
FROM fact_rental_payment AS frp
JOIN dim_calendar AS dc ON frp.rental_date_id = dc.calendar_id 
GROUP BY dc.calendar_year

-- Marki
SELECT
dc.calendar_year,
di.inventory_producer,
COUNT(1) 
FROM fact_rental_payment AS frp
JOIN dim_inventory AS di ON frp.inventory_id = di.inventory_id
JOIN dim_calendar AS dc ON frp.rental_date_id = dc.calendar_id 
GROUP BY dc.calendar_year, di.inventory_producer

-- Miejsce wypożyczenia
SELECT
dc.calendar_year,
ds.store_country,
COUNT(1) 
FROM fact_rental_payment AS frp
JOIN dim_store AS ds ON frp.store_id = ds.store_id
JOIN dim_calendar AS dc ON frp.rental_date_id = dc.calendar_id 
GROUP BY dc.calendar_year, ds.store_country

-- Jak się zmieniła struktura klientów (liczba, profil klienta)?
-- Liczba
SELECT
dc.calendar_year,
COUNT(1) 
FROM fact_rental_payment AS frp
JOIN dim_customer AS dcu ON frp.customer_id = dcu.customer_id 
JOIN dim_calendar AS dc ON frp.rental_date_id = dc.calendar_id 
GROUP BY dc.calendar_year