{{config(materialized='table')}}

select staff_id, first_name,
       last_name, email, last_update,
       CASE WHEN active = true THEN 1 ELSE 0 END AS active_int,
       CASE WHEN active = true THEN 'Yes' ELSE 'No' END AS active_desc
from {{source('sakila', 'staff')}}