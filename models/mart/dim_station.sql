select
    CAST(station_id AS INTEGER) as station_id,
    name as station_name,
    address,
    rental_methods,
    lat as latitude,
    lon as longitude
from {{ ref('stg_station_information') }}