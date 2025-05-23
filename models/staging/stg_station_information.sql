SELECT
  station_id,
  name,
  address,
  capacity,
  rental_methods,
  lat,
  lon
FROM {{ source('raw', 'station_information_raw') }}
