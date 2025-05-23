SELECT
  station_id,
  num_bikes_available,
  num_bikes_disabled,
  num_docks_available,
  num_docks_disabled,
  is_installed,
  is_renting,
  is_returning,
  last_reported,
  last_updated
FROM {{ source('raw', 'station_status_raw') }}
