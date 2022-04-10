BEGIN;

DROP TABLE IF EXISTS client;
CREATE TABLE client (
  ID SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL,
  age INTEGER CHECK (age > 0),
  gender VARCHAR,
  occupation VARCHAR,
  nationality VARCHAR
);

DROP TABLE IF EXISTS restaurant;
CREATE TABLE restaurant (
  ID SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL,
  category VARCHAR,
  city VARCHAR,
  address VARCHAR
);

DROP TABLE IF EXISTS dish;
CREATE TABLE dish (
  ID SERIAL PRIMARY KEY,
  name VARCHAR
);

DROP TABLE IF EXISTS restaurant_dishes;
CREATE TABLE restaurant_dishes (
  ID SERIAL PRIMARY KEY,
  price INTEGER CHECK (price > 0),
  restaurant_id INTEGER NOT NULL REFERENCES restaurant(ID),
  dish_id INTEGER NOT NULL REFERENCES dish(ID)
);

DROP TABLE IF EXISTS rest_clients;
CREATE TABLE rest_clients (
  ID SERIAL PRIMARY KEY,
  client_id INTEGER NOT NULL REFERENCES client(ID),
  restaurant_id INTEGER NOT NULL REFERENCES restaurant(ID),
  date DATE
);

COMMIT;
