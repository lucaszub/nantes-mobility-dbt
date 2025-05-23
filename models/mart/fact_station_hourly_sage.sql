WITH station_data AS (
  SELECT
    CAST(ss.station_id AS INTEGER) as station_id,
    CONVERT_TIMEZONE('UTC', 'Europe/Paris', ss.last_updated) AS date_hour,
    DATE_TRUNC('HOUR', CONVERT_TIMEZONE('UTC', 'Europe/Paris', ss.last_updated)) AS rounded_hour,
    si.capacity,
    ss.num_bikes_available,
    ss.num_docks_available,
    ss.num_docks_disabled,
    ss.num_bikes_disabled,
    ss.is_installed,
    ss.is_renting,
    ss.is_returning
  FROM
    {{ ref('stg_station_status') }} ss
    JOIN {{ ref('stg_station_information') }} si ON ss.station_id = si.station_id
),
bike_diffs AS (
  SELECT
    station_id,
    rounded_hour,
    num_bikes_available,
    capacity,
    num_docks_available,
    num_docks_disabled,
    num_bikes_disabled,
    is_installed,
    is_renting,
    is_returning,
    LAG(num_bikes_available) OVER (PARTITION BY station_id ORDER BY rounded_hour) AS prev_bikes
  FROM station_data
)
SELECT
  station_id,
  TO_VARCHAR(rounded_hour, 'DD/MM/YYYY') || ' ' || TO_VARCHAR(rounded_hour, 'HH24') || 'h00' AS date_hour,
  capacity,
  CASE
    WHEN prev_bikes > num_bikes_available THEN prev_bikes - num_bikes_available
    ELSE 0
  END AS estimated_departures,
  CASE
    WHEN num_bikes_available > prev_bikes THEN num_bikes_available - prev_bikes
    ELSE 0
  END AS estimated_arrivals,
  num_bikes_available,
  num_docks_available,
  num_docks_disabled,
  num_bikes_disabled,
  is_installed,
  is_renting,
  is_returning
  
FROM bike_diffs
WHERE prev_bikes IS NOT NULL
ORDER BY rounded_hour

