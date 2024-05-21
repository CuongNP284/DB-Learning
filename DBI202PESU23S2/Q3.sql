select l.location_id, l.country_id, l.street_address, l.city from locations l
where l.country_id in ('US','CA')