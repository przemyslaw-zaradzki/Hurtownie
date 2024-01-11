-- Jakie są koszty serwisu
SELECT
dc.calendar_year,
SUM(fs.service_cost) suma_kosztów_serwisu,
AVG(fs.service_cost) średni_kosztów_serwisu
FROM fact_service AS fs
JOIN dim_calendar AS dc ON fs.service_date_id = dc.calendar_id 
GROUP BY dc.calendar_year

-- Ile działań serwisowych wykonujemy w przekroju na samochody w miesiącach/roku
-- Co rozumiemy przez przekrój na samochody egzemplarz(inventory_id), marka(inventory_producer) ???

-- Ile działań serwisowych wykonujemy w poszczególnych miesiącach
SELECT
dc.calendar_month,
COUNT(1) 
FROM fact_service AS fs
JOIN dim_calendar AS dc ON fs.service_date_id = dc.calendar_id 
GROUP BY dc.calendar_month 

-- Ile kosztuje nas serwis poszczególnych marek samochodów
SELECT
di.inventory_producer,
SUM(fs.service_cost) suma_kosztów_serwisu,
AVG(fs.service_cost) średni_kosztów_serwisu
FROM  fact_service AS fs
JOIN dim_inventory AS di ON fs.service_inventory_id = di.inventory_id
GROUP BY di.inventory_producer

-- ** Ranking samochodów wg kosztów serwisów
-- Ranking z podziałem na co? Model, producent, rok?