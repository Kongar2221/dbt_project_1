{{ config(materialized='table') }}

SELECT s.store_id, s.manager_staff_id,
       t.first_name AS manager_first_name,
       t.last_name AS manager_last_name,
       a.address, a.district,
       a.postal_code, a.phone,
       c.city, y.country,
       s.last_update
FROM {{ source('sakila', 'store') }} AS s
    LEFT JOIN {{ source('sakila', 'staff') }} AS t
        ON s.manager_staff_id = t.staff_id
    LEFT JOIN {{ source('sakila', 'address') }} AS a
        ON s.address_id = a.address_id
    LEFT JOIN {{ source('sakila', 'city') }} AS c
        ON a.city_id = c.city_id
    LEFT JOIN {{ source('sakila', 'country') }} AS y
        ON c.country_id = y.country_id

