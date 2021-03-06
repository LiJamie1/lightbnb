const { Pool } = require('pg');
const properties = require('./json/properties.json');
const users = require('./json/users.json');


const pool = new Pool({
  user: 'vagrant',
  password: '123',
  host: 'localhost',
  database: 'lightbnb'
});
/// Users

/**
 * Get a single user from the database given their email.
 * @param {String} email The email of the user.
 * @return {Promise<{}>} A promise to the user.
 */
const getUserWithEmail = function(email) {
  const values = [`${email}`]
  return pool.query(`
    SELECT *
    FROM users
    WHERE email = $1
    `, values)
    .then((result) => {
      if (result) {
        return result.rows[0]
      } else {
        return null
      }
    })
    .catch((err) => console.log(err))
}
exports.getUserWithEmail = getUserWithEmail;

/**
 * Get a single user from the database given their id.
 * @param {string} id The id of the user.
 * @return {Promise<{}>} A promise to the user.
 */
const getUserWithId = function(id) {
  const values = [id]
  return pool.query(`
    SELECT *
    FROM users
    WHERE id = $1;
  `, values)
  .then((result) => {
    if (result) {
      return result.rows[0]
    } else {
      return null
    }
  })
  .catch((err) => console.log(err))
}
exports.getUserWithId = getUserWithId;


/**
 * Add a new user to the database.
 * @param {{name: string, password: string, email: string}} user
 * @return {Promise<{}>} A promise to the user.
 */
const addUser =  function(user) {
  const values = [user.name, user.email, user.password]
  return pool.query(`
    INSERT INTO users (name, email, password)
    VALUES ($1, $2, $3);
  `, values)
    .then((result) => {
      if (result) {
        return result.rows[0]
      } else {
        return null
      }
    })
    .catch((err) => console.log(err))
}
exports.addUser = addUser;

/// Reservations

/**
 * Get all reservations for a single user.
 * @param {string} guest_id The id of the user.
 * @return {Promise<[{}]>} A promise to the reservations.
 */
const getAllReservations = function(guest_id, limit = 10) {
  return pool.query(`
  SELECT reservations.*, properties.*, AVG(rating)
  FROM reservations
  JOIN properties ON properties.id = property_id
  JOIN property_reviews ON reservations.id = reservation_id
  WHERE reservations.guest_id = $1
  AND end_date < now()::date
  GROUP BY properties.id, reservations.id
  ORDER BY start_date DESC
  LIMIT $2;
  `, [guest_id, limit])
  .then(result => {
    return result.rows;
  })
  .catch(err => console.log(err.message));
}
exports.getAllReservations = getAllReservations;

/// Properties

/**
 * Get all properties.
 * @param {{}} options An object containing query options.
 * @param {*} limit The number of results to return.
 * @return {Promise<[{}]>}  A promise to the properties.
 */

const getAllProperties = function (options, limit = 10) {
  const queryParams = [];
  let queryString = `
  SELECT properties.*, avg(property_reviews.rating) as average_rating
  FROM properties
  JOIN property_reviews ON properties.id = property_id
  `;

  // if <- checks if key value pair exists
  // ternary in queryString

  if (options.city) {
    queryParams.push(`%${options.city}%`);
    queryString += `WHERE city LIKE $${queryParams.length} `;
  }

  // ternary in queryString to check whether to use AND or WHERE
  if (options.minimum_price_per_night) {
    queryString += `${queryParams.length ? 'AND' : 'WHERE'} ` ;
    const minPrice = options.minimum_price_per_night * 100;
    queryParams.push(minPrice);
    queryString += `cost_per_night > $${queryParams.length}`;
  }

  if (options.maximum_price_per_night) {
    queryString += `${queryParams.length ? 'AND' : 'WHERE'} `;
    const maxPrice = options.maximum_price_per_night * 100;
    queryParams.push(maxPrice);
    queryString += `cost_per_night < $${queryParams.length}`;
  }

  if (options.owner_id) {
    queryParams.push(options.owner_id);
    queryString += `WHERE owner_id = $${queryParams.length}`
  }

  queryString += `
  GROUP BY properties.id
  `

  if (options.minimum_rating) {
    queryParams.push(options.minimum_rating);
    queryString += `HAVING AVG(property_reviews.rating) >= $${queryParams.length}`
  }

  queryParams.push(limit);
  queryString += `
  ORDER BY cost_per_night
  LIMIT $${queryParams.length};
  `;

  return pool.query(queryString, queryParams).then((result) => result.rows);
};


exports.getAllProperties = getAllProperties;


/**
 * Add a property to the database
 * @param {{}} property An object containing all of the property details.
 * @return {Promise<{}>} A promise to the property.
 */
const addProperty = function(property) {
  return pool.query(`
  INSERT INTO properties (owner_id, title, description, thumbnail_photo_url, cover_photo_url, cost_per_night, parking_spaces, number_of_bathrooms, number_of_bedrooms, street, city, province, post_code, country)
  VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14)
  RETURNING *;`,
  [property.owner_id, property.title, property.description, property.thumbnail_photo_url, property.cover_photo_url, property.cost_per_night, property.parking_spaces, property.number_of_bathrooms, property.number_of_bedrooms, property.street, property.city, property.province, property.post_code, property.country])
.then(result => result);
}
exports.addProperty = addProperty;
