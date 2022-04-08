BEGIN;

CREATE TABLE "Client" (
  "ID" SERIAL,
  "name" VARCHAR NOT NULL,
  "age" INTEGER,
  "gender" VARCHAR,
  "occupation" VARCHAR,
  "nationality" VARCHAR
);

CREATE TABLE "restaurant_dishes" (
  "INTEGER" <type>,
  "FK" <type>,
  "FK" <type>
);

CREATE INDEX "ID" ON  "restaurant_dishes" ("INTEGER");

CREATE INDEX "restaurant_id" ON  "restaurant_dishes" ("FK");

CREATE INDEX "dish_id" ON  "restaurant_dishes" ("FK");

CREATE TABLE "restaurant" (
  "ID" INTEGER,
  "name" VARCHAR,
  "category" VARCHAR,
  "city" VARCHAR,
  "address" VARCHAR,
  CONSTRAINT "FK_restaurant.ID"
    FOREIGN KEY ("ID")
      REFERENCES "restaurant_dishes"("FK")
);

CREATE TABLE "dish" (
  "ID" INTEGER,
  "name" VARCHAR,
  "price" INTEGER,
  CONSTRAINT "FK_dish.ID"
    FOREIGN KEY ("ID")
      REFERENCES "restaurant_dishes"("FK")
);

CREATE TABLE "Visit_date" (
  "ID" INTEGER,
  "date" DATE,
  "client_id" FK,
  CONSTRAINT "FK_Visit_date.client_id"
    FOREIGN KEY ("client_id")
      REFERENCES "Client"("ID")
);

CREATE TABLE "Rest_clients" (
  "INTEGER" <type>,
  "FK" <type>,
  "FK" <type>,
  CONSTRAINT "FK_Rest_clients.FK"
    FOREIGN KEY ("FK")
      REFERENCES "Client"("ID"),
  CONSTRAINT "FK_Rest_clients.FK"
    FOREIGN KEY ("FK")
      REFERENCES "restaurant"("ID")
);

CREATE INDEX "ID" ON  "Rest_clients" ("INTEGER");

CREATE INDEX "client_id" ON  "Rest_clients" ("FK");

CREATE INDEX "restaurant_ID" ON  "Rest_clients" ("FK");

COMMIT;
