DROP TABLE IF EXISTS place_reviews, attachment, category_routes, users_routes, users_places, reviews, route_location, places, routes, category, users CASCADE;

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
    category_id INTEGER,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    route_time INTEGER,
    CONSTRAINT fk_routes_category FOREIGN KEY (category_id) REFERENCES category(category_id) ON DELETE CASCADE
);

CREATE TABLE category_routes (
    category_routes_id SERIAL PRIMARY KEY,
    route_id INTEGER,
    category_id INTEGER,
    CONSTRAINT fk_cr_route FOREIGN KEY (route_id) REFERENCES routes(route_id) ON DELETE CASCADE,
    CONSTRAINT fk_cr_category FOREIGN KEY (category_id) REFERENCES category(category_id) ON DELETE CASCADE
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
    route_id INTEGER,
    place_id INTEGER,
    number_route INTEGER NOT NULL,
    time_next_stop INTEGER,
    city VARCHAR(100),
    CONSTRAINT fk_rl_route FOREIGN KEY (route_id) REFERENCES routes(route_id) ON DELETE CASCADE,
    CONSTRAINT fk_rl_place FOREIGN KEY (place_id) REFERENCES places(place_id) ON DELETE CASCADE
);

CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    route_id INTEGER,
    place_id INTEGER,
    text TEXT,
    attachment_id VARCHAR(255),
    rating INTEGER,
    CONSTRAINT fk_reviews_route FOREIGN KEY (route_id) REFERENCES routes(route_id) ON DELETE CASCADE,
    CONSTRAINT fk_reviews_place FOREIGN KEY (place_id) REFERENCES places(place_id) ON DELETE CASCADE
);

CREATE TABLE attachment (
    attachment_id SERIAL PRIMARY KEY,
    route_id INTEGER,
    place_id INTEGER,
    review_id INTEGER,
    type VARCHAR(50),
    link_to_data VARCHAR(255),
    CONSTRAINT fk_att_route FOREIGN KEY (route_id) REFERENCES routes(route_id) ON DELETE CASCADE,
    CONSTRAINT fk_att_place FOREIGN KEY (place_id) REFERENCES places(place_id) ON DELETE CASCADE,
    CONSTRAINT fk_att_review FOREIGN KEY (review_id) REFERENCES reviews(review_id) ON DELETE CASCADE
);

CREATE TABLE place_reviews (
    place_reviews_id SERIAL PRIMARY KEY,
    review_id INTEGER,
    place_id INTEGER,
    CONSTRAINT fk_pr_review FOREIGN KEY (review_id) REFERENCES reviews(review_id) ON DELETE CASCADE,
    CONSTRAINT fk_pr_place FOREIGN KEY (place_id) REFERENCES places(place_id) ON DELETE CASCADE
);

CREATE TABLE users_routes (
    users_routes_id SERIAL PRIMARY KEY,
    route_id INTEGER,
    user_id INTEGER,
    CONSTRAINT fk_ur_route FOREIGN KEY (route_id) REFERENCES routes(route_id) ON DELETE CASCADE,
    CONSTRAINT fk_ur_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE users_places (
    users_places_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    place_id INTEGER,
    CONSTRAINT fk_up_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_up_place FOREIGN KEY (place_id) REFERENCES places(place_id) ON DELETE CASCADE
);

INSERT INTO users (password, status, mail) VALUES
('hashed_pass_12345', 'active', 'ivan.kaluga@example.ru'),
('hashed_pass_67890', 'active', 'elena.smirnova@example.ru'),
('hashed_pass_qwerty', 'banned', 'troll_user@example.ru'),
('hashed_pass_abcde', 'active', 'alex.volkov@example.ru'),
('hashed_pass_zxcvb', 'deleted', 'old_account@example.ru'),
('hashed_pass_11111', 'active', 'maria.orlova@example.ru'),
('hashed_pass_22222', 'active', 'dmitry.kuznetsov@example.ru'),
('hashed_pass_33333', 'active', 'olga.sokolova@example.ru'),
('hashed_pass_44444', 'banned', 'spammer40@example.ru');

INSERT INTO category (name) VALUES
('Исторические прогулки'),
('Космическая Калуга'),
('Природа и парки'),
('Гастрономия и отдых'),
('Храмы и монастыри'),
('Семейный отдых с детьми');

INSERT INTO routes (category_id, name, description, route_time) VALUES
(2, 'Колыбель космонавтики', 'Главный туристический маршрут Калуги от музея космонавтики до дома-музея К. Э. Циолковского.', 150),
(1, 'Купеческая Калуга: от Гостиных рядов до Каменного моста', 'Пешеходная прогулка по историческому центру города с осмотром памятников архитектуры XVIII–XIX веков.', 120),
(3, 'Прогулка вдоль Оки и по городским паркам', 'Спокойный видовой маршрут от набережной Яченского водохранилища через Центральный парк к смотровой площадке.', 110),
(4, 'Вкусная Калуга: кофейни и локальная кухня', 'Маршрут по уютным заведениям в центре города с дегустацией калужского теста.', 140),
(5, 'Святыни и храмы старой Калуги', 'Пешеходный маршрут по главным соборам и церквям исторического центра.', 130),
(6, 'Выходные с детьми в Калуге', 'Развлекательно-познавательный маршрут с посещением планетария, парка и музея ремесел.', 180),
(1, 'Скверы и памятники центральной части города', 'Неспешная прогулка от площади Победы до сквера Мира и Березуйского оврага.', 95);

INSERT INTO category_routes (route_id, category_id) VALUES
(1, 2),
(1, 6),
(2, 1),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(6, 2),
(7, 1),
(7, 3);

INSERT INTO places (name, coordinates, maps_rating, city, location_type) VALUES
('Музей истории космонавтики им. К. Э. Циолковского', '54.5168, 36.2306', 4.95, 'Калуга', 'Музей'),
('Дом-музей К. Э. Циолковского', '54.5069, 36.2238', 4.90, 'Калуга', 'Музей'),
('Гостиные ряды', '54.5091, 36.2504', 4.85, 'Калуга', 'Достопримечательность'),
('Каменный мост (Виадук)', '54.5063, 36.2494', 4.88, 'Калуга', 'Достопримечательность'),
('Центральный парк культуры и отдыха', '54.5065, 36.2458', 4.80, 'Калуга', 'Парк'),
('Набережная Яченского водохранилища', '54.5142, 36.2245', 4.78, 'Калуга', 'Набережная'),
('Краеведческий музей (Усадьба Золотаревых)', '54.5078, 36.2435', 4.89, 'Калуга', 'Музей'),
('Кафе-музей «Калужское тесто»', '54.5105, 36.2512', 4.84, 'Калуга', 'Ресторан'),
('Свято-Троицкий кафедральный собор', '54.5068, 36.2452', 4.92, 'Калуга', 'Храм'),
('Храм Покрова Пресвятой Богородицы на Рву', '54.5083, 36.2469', 4.86, 'Калуга', 'Храм'),
('Калужский планетарий', '54.5169, 36.2312', 4.91, 'Калуга', 'Музей'),
('Дом мастеров', '54.5101, 36.2456', 4.83, 'Калуга', 'Музей'),
('Площадь Победы', '54.5186, 36.2615', 4.87, 'Калуга', 'Площадь'),
('Сквер Мира', '54.5153, 36.2461', 4.79, 'Калуга', 'Парк'),
('Памятник 600-летию Калуги (Шарик)', '54.5138, 36.2289', 4.85, 'Калуга', 'Достопримечательность');

INSERT INTO route_location (route_id, place_id, number_route, time_next_stop, city) VALUES
(1, 1, 1, 20, 'Калуга'),
(1, 2, 2, 15, 'Калуга'),
(1, 15, 3, 0, 'Калуга'),
(2, 3, 1, 10, 'Калуга'),
(2, 4, 2, 15, 'Калуга'),
(2, 7, 3, 0, 'Калуга'),
(3, 6, 1, 30, 'Калуга'),
(3, 5, 2, 0, 'Калуга'),
(4, 3, 1, 5, 'Калуга'),
(4, 8, 2, 0, 'Калуга'),
(5, 9, 1, 10, 'Калуга'),
(5, 10, 2, 0, 'Калуга'),
(6, 11, 1, 25, 'Калуга'),
(6, 12, 2, 15, 'Калуга'),
(6, 5, 3, 0, 'Калуга'),
(7, 13, 1, 20, 'Калуга'),
(7, 14, 2, 15, 'Калуга'),
(7, 15, 3, 0, 'Калуга');

INSERT INTO reviews (route_id, place_id, text, attachment_id, rating) VALUES
(1, 1, 'Новый корпус музея космонавтики впечатляет масштабом, отличный маршрут на полдня.', 'kaluga_space_01.jpg', 5),
(2, 4, 'Очень живописный вид с Каменного моста на Березуйский овраг, особенно на закате.', 'kaluga_bridge_02.jpg', 5),
(3, 6, 'Приятно прогуляться вдоль Яченского водохранилища, свежий воздух и красивые виды.', NULL, 4),
(4, 8, 'Обязательно попробуйте традиционное калужское тесто с пряностями!', 'kaluga_food_03.jpg', 5),
(5, 9, 'Величественный собор прямо в Центральном парке, очень ухоженная территория.', 'trinity_cathedral.jpg', 5),
(6, 11, 'Ходили в планетарий с ребенком 8 лет — программа про звезды просто восторг!', 'planetarium_kaluga.jpg', 5),
(6, 12, 'В Доме мастеров очень душевные экскурсии и красивые глиняные игрушки.', NULL, 5),
(7, 13, 'Вечером на площади Победы красиво работает подсветка фонтанов.', 'victory_square.jpg', 4),
(7, 15, 'Знаковое место на въезде к музею космонавтики, отличная точка для фото.', 'kaluga_globe.jpg', 5);

INSERT INTO attachment (route_id, place_id, review_id, type, link_to_data) VALUES
(1, 1, 1, 'image/jpeg', '/uploads/reviews/kaluga_space_01.jpg'),
(2, 4, 2, 'image/jpeg', '/uploads/reviews/kaluga_bridge_02.jpg'),
(4, 8, 4, 'image/jpeg', '/uploads/reviews/kaluga_food_03.jpg'),
(5, 9, 5, 'image/jpeg', '/uploads/reviews/trinity_cathedral.jpg'),
(6, 11, 6, 'image/jpeg', '/uploads/reviews/planetarium_kaluga.jpg'),
(7, 13, 8, 'image/jpeg', '/uploads/reviews/victory_square.jpg'),
(7, 15, 9, 'image/jpeg', '/uploads/reviews/kaluga_globe.jpg');

INSERT INTO place_reviews (review_id, place_id) VALUES
(1, 1),
(2, 4),
(3, 6),
(4, 8),
(5, 9),
(6, 11),
(7, 12),
(8, 13),
(9, 15);

INSERT INTO users_routes (route_id, user_id) VALUES
(1, 1),
(2, 1),
(5, 1),
(1, 2),
(4, 2),
(7, 2),
(3, 4),
(5, 6),
(7, 6),
(6, 7),
(6, 8);

INSERT INTO users_places (user_id, place_id) VALUES
(1, 1),
(1, 4),
(1, 11),
(2, 3),
(2, 8),
(4, 6),
(6, 9),
(6, 13),
(7, 11),
(7, 12),
(8, 15);
