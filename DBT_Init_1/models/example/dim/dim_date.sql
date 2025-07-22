{{ config(materialized='table') }}

SELECT
  to_char(datum, 'YYYYMMDD')::INT  AS date_dim_id,
  datum AS date_key,
  extract(epoch FROM datum) AS epoch,
  to_char(datum, 'TMDay') AS day_name,
  extract(isodow FROM datum) AS day_of_week,
  extract(day FROM datum) AS day_of_month,
  extract(day FROM (datum - date_trunc('quarter', datum)))::INT + 1 AS day_of_quarter,
  extract(doy FROM datum) AS day_of_year,
  to_char(datum, 'W')::INT  AS week_of_month,
  extract(week FROM datum) AS week_of_year,
  extract(month FROM datum) AS month_actual,
  to_char(datum, 'TMMonth') AS month_name,
  to_char(datum, 'Mon') AS month_name_abbreviated,
  extract(quarter  FROM datum) AS quarter_actual,
  CASE extract(quarter FROM datum)
    WHEN 1 THEN 'First'
    WHEN 2 THEN 'Second'
    WHEN 3 THEN 'Third'
    WHEN 4 THEN 'Fourth'
  END AS quarter_name,
  extract(year     FROM datum) AS year_actual,
  (datum + (1 - extract(isodow FROM datum)) * interval '1 day')::DATE AS first_day_of_week,
  (datum + (7 - extract(isodow FROM datum)) * interval '1 day')::DATE AS last_day_of_week,
  (datum + (1 - extract(day    FROM datum)) * interval '1 day')::DATE AS first_day_of_month,
  (date_trunc('month', datum) + interval '1 month' - interval '1 day')::DATE AS last_day_of_month,
  date_trunc('quarter', datum)::DATE AS first_day_of_quarter,
  (date_trunc('quarter', datum) + interval '3 month' - interval '1 day')::DATE AS last_day_of_quarter,
  make_date(extract(year FROM datum)::INT,  1,  1) AS first_day_of_year,
  make_date(extract(year FROM datum)::INT, 12, 31) AS last_day_of_year,
  to_char(datum, 'YYYYMM') AS yyyymm,
  extract(isodow FROM datum) IN (6,7) AS weekend_ind
FROM generate_series(
       '2000-01-01'::DATE,
       current_date,
       interval '1 day'
     ) AS d(datum)
ORDER BY date_key
