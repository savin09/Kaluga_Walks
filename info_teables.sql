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

-- Заполнение данными (Калуга)
INSERT INTO users (password, status, mail) VALUES
('hashed_pass_12345', 'active', 'ivan.kaluga@example.ru'),
('hashed_pass_67890', 'active', 'elena.smirnova@example.ru'),
('hashed_pass_qwerty', 'banned', 'troll_user@example.ru'),
('hashed_pass_abcde', 'active', 'alex.volkov@example.ru'),
('hashed_pass_zxcvb', 'deleted', 'old_account@example.ru');

INSERT INTO category (name) VALUES
('Исторические прогулки'),
('Космическая Калуга'),
('Природа и парки'),
('Гастрономия и отдых');

INSERT INTO routes (category_id, name, description, route_time) VALUES
(2, 'Колыбель космонавтики', 'Главный туристический маршрут Калуги от музея космонавтики до дома-музея К. Э. Циолковского.', 150),
(1, 'Купеческая Калуга: от Гостиных рядов до Каменного моста', 'Пешеходная прогулка по историческому центру города с осмотром памятников архитектуры XVIII–XIX веков.', 120),
(3, 'Прогулка вдоль Оки и по городским паркам', 'Спокойный видовой маршрут от набережной Яченского водохранилища через Центральный парк к смотровой площадке.', 110),
(4, 'Вкусная Калуга: кофейни и локальная кухня', 'Маршрут по уютным заведениям в центре города с дегустацией калужского теста.', 140);

INSERT INTO places (name, coordinates, maps_rating, city, location_type) VALUES
('Музей истории космонавтики им. К. Э. Циолковского', '54.5168, 36.2306', 4.95, 'Калуга', 'Музей'),
('Дом-музей К. Э. Циолковского', '54.5069, 36.2238', 4.90, 'Калуга', 'Музей'),
('Гостиные ряды', '54.5091, 36.2504', 4.85, 'Калуга', 'Достопримечательность'),
('Каменный мост (Виадук)', '54.5063, 36.2494', 4.88, 'Калуга', 'Достопримечательность'),
('Центральный парк культуры и отдыха', '54.5065, 36.2458', 4.80, 'Калуга', 'Парк'),
('Набережная Яченского водохранилища', '54.5142, 36.2245', 4.78, 'Калуга', 'Набережная'),
('Краеведческий музей (Усадьба Золотаревых)', '54.5078, 36.2435', 4.89, 'Калуга', 'Музей'),
('Кафе-музей «Калужское тесто»', '54.5105, 36.2512', 4.84, 'Калуга', 'Ресторан');

INSERT INTO route_location (route_id, place_id, number_route, time_next_stop, city) VALUES
(1, 1, 1, 20, 'Калуга'),
(1, 2, 2, 0, 'Калуга'),
(2, 3, 1, 10, 'Калуга'),
(2, 4, 2, 15, 'Калуга'),
(2, 7, 3, 0, 'Калуга'),
(3, 6, 1, 30, 'Калуга'),
(3, 5, 2, 0, 'Калуга'),
(4, 3, 1, 5, 'Калуга'),
(4, 8, 2, 0, 'Калуга');

INSERT INTO reviews (route_id, place_id, text, attachment_id, rating) VALUES
(1, 1, 'Новый корпус музея космонавтики впечатляет масштабом, отличный маршрут на полдня.', 'kaluga_space_01.jpg', 5),
(2, 4, 'Очень живописный вид с Каменного моста на Березуйский овраг, особенно на закате.', 'kaluga_bridge_02.jpg', 5),
(3, 6, 'Приятно прогуляться вдоль Яченского водохранилища, свежий воздух и красивые виды.', NULL, 4),
(4, 8, 'Обязательно попробуйте традиционное калужское тесто с пряностями!', 'kaluga_food_03.jpg', 5);

INSERT INTO users_routes (route_id, user_id) VALUES
(1, 1),
(2, 1),
(1, 2),
(3, 4),
(4, 2);

INSERT INTO users_places (user_id, place_id) VALUES
(1, 1),
(1, 4),
(2, 3),
(2, 8),
(4, 6);
