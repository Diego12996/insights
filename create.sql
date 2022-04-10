BEGIN;

DROP TABLE IF EXISTS "clients";
CREATE TABLE "clients" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR NOT NULL,
  "age" INTEGER NOT NULL,
  "gender" VARCHAR NOT NULL check ("gender" = 'Male' or "gender" = 'Female'),   
  "occupation" VARCHAR NOT NULL,
  "nationality" VARCHAR NOT NULL
);

DROP TABLE IF EXISTS "dishes";
CREATE TABLE "dishes" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR NOT NULL
);

DROP TABLE IF EXISTS "restaurants";
CREATE TABLE "restaurants" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR NOT NULL,
  "category" VARCHAR NOT NULL,
  "city" VARCHAR NOT NULL,
  "address" VARCHAR NOT NULL
);

DROP TABLE IF EXISTS "restaurants_dishes";
CREATE TABLE "restaurants_dishes" (
  "id" SERIAL PRIMARY KEY,
  "restaurant_id" INTEGER NOT NULL REFERENCES "restaurants"("id"),
  "dish_id" INTEGER NOT NULL REFERENCES "dishes"("id"),
  "price" INTEGER NOT NULL
);

DROP TABLE IF EXISTS "visits";
CREATE TABLE "visits" (
  "id" SERIAL PRIMARY KEY,
  "date" DATE NOT NULL,
  "client_id" INTEGER NOT NULL REFERENCES "clients"("id"),
  "restaurant_dish_id" INTEGER NOT NULL REFERENCES "restaurants_dishes"("id")
);

COMMIT;
