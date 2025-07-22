{{ config(materialized='table') }}

SELECT  f.*, l.name AS language,
        c.name AS category,
        c.category_id,
    CASE WHEN f.length <= 75 THEN 'Short'
         WHEN f.length > 75 AND f.length <= 120 THEN 'Medium'
         ELSE 'Long'
    END AS length_category,
    
    CASE WHEN f.special_features IS NOT NULL
              AND f.special_features <> '' 
         THEN 1
        ELSE 0
    END AS special_features_indicator

FROM {{ source('sakila', 'film') }} AS f
    LEFT JOIN {{ source('sakila', 'language') }} AS l 
        ON f.language_id = l.language_id
    LEFT JOIN {{ source('sakila', 'film_category') }} AS fc 
        ON f.film_id = fc.film_id
    LEFT JOIN {{ source('sakila', 'category') }} AS c 
        ON fc.category_id = c.category_id
