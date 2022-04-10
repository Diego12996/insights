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
  clients = insert("clients", client_data, "name")

  restaurant_data = {
    "name" => row["restaurant_name"],
    "category" => row["category"],
    "city" => row["city"],
    "address" => row["address"]
  }
  restaurants = insert("restaurants", restaurant_data, "name")
  
  dish_data = {
    "name" => row["dish"]
  }
  dishes = insert("dishes", dish_data, "name")
  
  restaurants_dishes_data = {
    "restaurant_id" => restaurants["id"],
    "dish_id" => dishes["id"],
    "price" => row["price"]
  }
  restaurants_dishes = insert("restaurants_dishes", restaurants_dishes_data)

  visits_data = {
    "date" => row["visit_date"],
    "client_id" => clients["id"],
    "restaurant_dish_id" => restaurants_dishes["id"]
  }
  insert("visits", visits_data)
  
end
