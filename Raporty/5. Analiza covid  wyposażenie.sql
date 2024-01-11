-- ** czy zmieniło się wyposażenie zamawiane przez klientów?
WITH dim_equipment_cnt AS (
	SELECT
	dc.calendar_year,
	de.equipment_id ,
	COUNT(1) 
	FROM fact_rental_payment AS frp
	JOIN bridge_inventory_equipment AS bie ON frp.inventory_id = bie.inventory_id
	JOIN dim_equipment AS de ON bie.equipment_id = de.equipment_id 
	JOIN dim_calendar AS dc ON frp.rental_date_id = dc.calendar_id
	GROUP BY dc.calendar_year, de.equipment_id 
)

SELECT
*
FROM dim_equipment AS de
JOIN dim_equipment_cnt AS de_cnt ON de.equipment_id = de_cnt.equipment_id