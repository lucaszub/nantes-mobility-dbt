with base as (
    select distinct
        DATE_TRUNC('HOUR', CONVERT_TIMEZONE('UTC', 'Europe/Paris', last_updated)) as date_hour
    from {{ source('raw', 'station_status_raw') }}
),

enriched as (
    select
        date_hour,
        -- Format : 16/05/2026 16h00
        TO_VARCHAR(date_hour, 'DD/MM/YYYY') || ' ' || TO_VARCHAR(date_hour, 'HH24') || 'h00' as date_hour_str,
        TO_VARCHAR(date_hour, 'DD/MM/YYYY') ad date_str,
        case EXTRACT(DAYOFWEEK FROM date_hour)
            when 1 then 'Dimanche'
            when 2 then 'Lundi'
            when 3 then 'Mardi'
            when 4 then 'Mercredi'
            when 5 then 'Jeudi'
            when 6 then 'Vendredi'
            when 7 then 'Samedi'
        end as day_name_fr,
        EXTRACT(HOUR FROM date_hour) as hour,
        CASE WHEN EXTRACT(DAYOFWEEK FROM date_hour) IN (1, 7) THEN TRUE ELSE FALSE END as is_weekend,
        CASE 
            WHEN TO_VARCHAR(date_hour, 'MM-DD') IN ('01-01', '05-01', '07-14', '12-25') THEN TRUE
            ELSE FALSE
        END as is_holiday
    from base
)

select * from enriched
order by date_hour