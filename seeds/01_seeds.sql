-- users
INSERT INTO users (name, email, password)
VALUES
  ('Cally Mullen','dolor.donec@outlook.couk','$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u.'),
  ('Martina Miller','volutpat.ornare@google.edu','$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u.'),
  ('Mara Welch','euismod@aol.com','$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u.'),
  ('Jameson Duffy','pellentesque@hotmail.org','$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u.'),
  ('Ava Willis','erat.in.consectetuer@google.ca','$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u.');

--properties
-- link 1 https://cdn.discordapp.com/attachments/906056340131184720/913188369834582086/20211124_135918.jpg
-- link 2 https://cdn.discordapp.com/attachments/906056340131184720/913175924692881438/20211124_130433.jpg

INSERT INTO properties (owner_id, title, description, thumbnail_photo_url, cover_photo_url, cost_per_night, parking_spaces, number_of_bathrooms, number_of_bedrooms, country, street, city, province, post_code, active)
VALUES
  (1, 'Big House', 'description', 'https://cdn.discordapp.com/attachments/906056340131184720/913188369834582086/20211124_135918.jpg', 'https://cdn.discordapp.com/attachments/906056340131184720/913175924692881438/20211124_130433.jpg', 10000, 100, 100, 200, 'Country 1', 'Street 1', 'City 1', 'Province 1', 'Postal code 1', TRUE),
  (1, 'Long House', 'description', 'https://cdn.discordapp.com/attachments/906056340131184720/913188369834582086/20211124_135918.jpg', 'https://cdn.discordapp.com/attachments/906056340131184720/913175924692881438/20211124_130433.jpg', 500, 10, 15, 30, 'Country 2', 'Street 2', 'City 2', 'Province 2', 'Postal code 3', TRUE),
  (3, 'Tall House', 'description', 'https://cdn.discordapp.com/attachments/906056340131184720/913188369834582086/20211124_135918.jpg', 'https://cdn.discordapp.com/attachments/906056340131184720/913175924692881438/20211124_130433.jpg', 750, 10, 15, 30, 'Country 3', 'Street 3', 'City 3', 'Province 3', 'Postal code 3', TRUE),
  (1, 'Round House', 'description', 'https://cdn.discordapp.com/attachments/906056340131184720/913188369834582086/20211124_135918.jpg', 'https://cdn.discordapp.com/attachments/906056340131184720/913175924692881438/20211124_130433.jpg', 200, 360, 720, 1080, 'Country 4', 'Street 4', 'City 4', 'Province 4', 'Postal code 4', TRUE),
  (1, 'Broken House', 'description', 'https://cdn.discordapp.com/attachments/906056340131184720/913188369834582086/20211124_135918.jpg', 'https://cdn.discordapp.com/attachments/906056340131184720/913175924692881438/20211124_130433.jpg', 5, 5, 5, 5, 'Country 5', 'Street 5', 'City 5', 'Province 5', 'Postal code 5', FALSE);

--reservations
INSERT INTO reservations (start_date, end_date, property_id, guest_id)
VALUES
  ('2018-09-11', '2018-09-26', 1, 2),
  ('2019-01-04', '2019-02-01', 2, 5),
  ('2021-10-01', '2021-10-14', 3, 3),
  ('2023-04-23', '2023-05-02', 4, 4);

--property reviews
INSERT INTO property_reviews (guest_id, property_id, reservation_id, rating, message)
VALUES
  (2, 1, 1, 4, 'house is big!'),
  (5, 2, 2, 3, 'house is long!'),
  (3, 3, 3, 4, 'house is tall!'),
  (4, 4, 4, 5, 'house is round!');