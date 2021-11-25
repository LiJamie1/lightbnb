-- LHL answer
SELECT 
  properties.id,
  properties.title,
  properties.cost_per_night,
  reservations.start_date,
  AVG(rating) AS average_rating
FROM reservations
  JOIN properties ON reservations.property_id = properties.id
  JOIN property_reviews ON properties.id = property_reviews.property_id
WHERE reservations.guest_id = 1
  AND reservations.end_date < NOW()::DATE --why date? without date works fine
GROUP BY properties.id, reservations.id
ORDER BY reservations.start_date
LIMIT 10;

-- My attempt
-- SELECT
--   properties.id,
--   properties.title,
--   properties.cost_per_night,
--   reservations.start_date,
--   AVG(property_reviews.rating) AS average_rating
-- FROM properties
--   JOIN reservations ON properties.id = reservations.property_id
--   JOIN property_reviews ON properties.id = property_reviews.property_id
-- WHERE property_reviews.guest_id = 1
--   AND start_date < now() ** missing ::date
-- GROUP BY properties.id, reservations.start_date ** this should be reservations.id instead of date
-- ORDER BY reservations.start_date;