SELECT
  properties.city,
  COUNT(*) AS total_reservations
FROM properties
  JOIN property_reviews ON properties.id = property_reviews.property_id
GROUP BY properties.city
ORDER BY total_reservations DESC;