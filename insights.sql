BEGIN;

DROP TABLE IF EXISTS Client;
CREATE TABLE "Client" (
  "ID" SERIAL PRIMARY KEY,
  "name" VARCHAR NOT NULL,
  "age" INTEGER CHECK (age > 0),
  "gender" VARCHAR,
  "occupation" VARCHAR,
  "nationality" VARCHAR
);

DROP TABLE IF EXISTS restaurant_dishes;
CREATE TABLE "restaurant_dishes" (
  "ID" SERIAL PRIMARY KEY,
  "restaurant_id" INTEGER NOT NULL REFERENCES restaurant(ID),
  "dish_id" INTEGER NOT NULL REFERENCES dish(ID)
);

DROP TABLE IF EXISTS restaurant;
CREATE TABLE "restaurant" (
  "ID" SERIAL PRIMARY KEY,
  "name" VARCHAR NOT NULL,
  "category" VARCHAR,
  "city" VARCHAR,
  "address" VARCHAR
);

DROP TABLE IF EXISTS dish;
CREATE TABLE "dish" (
  "ID" SERIAL PRIMARY KEY,
  "name" VARCHAR,
  "price" INTEGER CHECK (price > 0)
);

DROP TABLE IF EXISTS Visit_date;
CREATE TABLE "Visit_date" (
  "ID" SERIAL PRIMARY KEY,
  "date" DATE,
  "client_id" INTEGER NOT NULL REFERENCES client(ID)
);

DROP TABLE IF EXISTS Rest_clients;
CREATE TABLE "Rest_clients" (
  "ID" SERIAL PRIMARY KEY,
  "clien_id" INTEGER NOT NULL REFERENCES client(ID),
  "restaurant_id" INTEGER NOT NULL REFERENCES restaurant(ID)
);

COMMIT;
