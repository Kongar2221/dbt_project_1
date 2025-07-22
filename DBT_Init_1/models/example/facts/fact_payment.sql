{{ config(materialized='incremental') }}

select *
    from {{ source('sakila', 'payment') }}