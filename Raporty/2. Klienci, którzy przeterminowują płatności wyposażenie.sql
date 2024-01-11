-- **pogłębienie transakcji/klientów - jakie wyposażenie jest wybierane
WITH dim_equipment_cnt_before_deadline AS (
	SELECT
	de.equipment_id ,
	COUNT(1) 
	FROM fact_rental_payment AS frp
	JOIN bridge_inventory_equipment AS bie ON frp.inventory_id = bie.inventory_id
	JOIN dim_equipment AS de ON bie.equipment_id = de.equipment_id 
	WHERE frp.days_to_deadline > 0
	GROUP BY de.equipment_id 
)

SELECT
*
FROM dim_equipment AS de
JOIN dim_equipment_cnt_before_deadline AS de_cnt ON de.equipment_id = de_cnt.equipment_id