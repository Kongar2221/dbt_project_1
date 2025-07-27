{{ config(materialized='incremental', unique_key='payment_id') }}

select *
    from {{ source('sakila', 'payment') }}