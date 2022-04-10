require "pg"
require "csv"

DB = PG.connect(dbname: "insights")

def insert(table, data, unique_column = nil)
  entity = nil

  entity = find(table, unique_column, data[unique_column]) if unique_column

  entity ||= DB.exec(%[INSERT INTO #{table} (#{data.keys.join(', ')})
                VALUES (#{data.values.map { |value| "'#{value.gsub("'", "''")}'" }.join(', ')})
                RETURNING *;]).first

  entity
end

def find(table, column, value)
  DB.exec(%(
      SELECT * FROM #{table}
      WHERE #{column} = '#{value.gsub("'", "''")}';
      )).first
end

CSV.foreach("data.csv", headers: true) do |row|
  client_data = {
    "name" => row["client_name"],
    "age" => row["age"],
    "gender" => row["gender"],
    "occupation" => row["occupation"],
    "nationality" => row["nationality"]
  }
  client = insert("client", client_data, "name")

  restaurant_data = {
    "name" => row["restaurant_name"],
    "category" => row["category"],
    "city" => row["city"],
    "address" => row["address"]
  }
  restaurant = insert("restaurant", restaurant_data, "name")

  dish_data = {
    "name" => row["dish"]
  }
  dish = insert("dish", dish_data, "name")

  rest_clients_data = {
    "client_id" => client["id"],
    "restaurant_id" => restaurant["id"],
    "date" => row["visit_date"]
  }
  insert("rest_clients", rest_clients_data)

  restaurant_dishes_data = {
    "price" => row["price"],
    "restaurant_id" => restaurant["id"],
    "dish_id" => dish["id"]
  }
  insert("restaurant_dishes", restaurant_dishes_data)
end
