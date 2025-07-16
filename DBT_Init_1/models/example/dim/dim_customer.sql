{{config(
    materialized='table',
    post_hook="insert into {{this}} (customer_id, first_name) values (-1, 'N/A')"
)}}

SELECT c.customer_id , c.store_id, 
       c.first_name, c.last_name, a.address, c.email,
       concat(c.first_name, ' ', c.last_name) AS full_name,
       split_part(c.email, '@', 1) AS domain,
       i.city, o.country, CASE 
         WHEN c.active = 1 THEN 'Active'
         ELSE 'Inactive'
       END AS status, c.last_update, c.create_date
  FROM {{source('sakila', 'customer')}} AS c
  LEFT JOIN {{source('sakila', 'address')}} AS a 
    ON c.address_id = a.address_id
  LEFT JOIN {{source('sakila', 'city')}} AS i
    ON a.city_id = i.city_id
  LEFT JOIN {{source('sakila', 'country')}} AS o
    ON i.country_id = o.country_id
  
