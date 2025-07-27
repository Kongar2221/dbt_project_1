{{ config(materialized='incremental', unique_key='rental_id') }}

    select  r.rental_id, r.rental_date, r.inventory_id,
            r.customer_id, r.return_date, r.staff_id,
            r.last_update, i.film_id, i.store_id,
            cast(to_char(r.rental_date, 'YYYYMMDD') as integer) as date_key,
            case when r.return_date is not null then
                 round(extract(epoch from (r.return_date - r.rental_date)) / 3600, 2)
                 else null
            end as rental_time_hours,
            case when r.return_date is not null then 1 else 0 end as is_return
    from {{ source('sakila', 'rental') }} r
        left join {{ source('sakila', 'inventory') }} i
            on r.inventory_id = i.inventory_id