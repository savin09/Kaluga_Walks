DROP TABLE IF EXISTS users_routes, users_places, reviews, route_location, places, routes, category, users CASCADE;

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    status VARCHAR(50) NOT NULL CHECK (status IN ('active', 'banned', 'deleted')),
    mail VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE routes (
    route_id SERIAL PRIMARY KEY,
    category_id INTEGER REFERENCES category(category_id) ON DELETE CASCADE,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    route_time INTEGER
);

CREATE TABLE places (
    place_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    coordinates VARCHAR(100),
    maps_rating NUMERIC(3,2),
    city VARCHAR(100),
    location_type VARCHAR(50)
);

CREATE TABLE route_location (
    route_location_id SERIAL PRIMARY KEY,
    route_id INTEGER REFERENCES routes(route_id) ON DELETE CASCADE,
    place_id INTEGER REFERENCES places(place_id) ON DELETE CASCADE,
    number_route INTEGER NOT NULL,
    time_next_stop INTEGER,
    city VARCHAR(100)
);

CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    route_id INTEGER REFERENCES routes(route_id) ON DELETE CASCADE,
    place_id INTEGER REFERENCES places(place_id) ON DELETE CASCADE,
    text TEXT,
    attachment_id VARCHAR(255),
    rating INTEGER
);

CREATE TABLE users_routes (
    users_routes_id SERIAL PRIMARY KEY,
    route_id INTEGER REFERENCES routes(route_id) ON DELETE CASCADE,
    user_id INTEGER REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE users_places (
    users_places_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id) ON DELETE CASCADE,
    place_id INTEGER REFERENCES places(place_id) ON DELETE CASCADE
);
