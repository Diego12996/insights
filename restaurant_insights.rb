require "pg"
require "terminal-table"
require "colorize"
require_relative "utilities"

class InsightsApp
  include Utilities
  def initialize
    @db = PG.connect(dbname: "insights")
  end

  def start
    welcome_message
    menu
    print "> "
    option, param = gets.chomp.split

    until option == "quit"
      case_when(option, param)
      print "> "
      option, param = gets.chomp.split
    end
  end

  def search_by(param)
    if param.nil?
      result = @db.exec(%(
        SELECT name, category, city FROM restaurants;))
    else
      column_ref = {
        "category" => "restaurants.category",
        "city" => "restaurants.city"
      }

      column, value = param.split("=")
      column = column_ref[column]

      result = @db.exec(%(
        SELECT name, category, city FROM restaurants
        WHERE LOWER(#{column}) LIKE LOWER('%#{value}%');
      ))
    end

    table_printer("List of restaurants", result)
  end

  def unique_dish
    result = @db.exec(%(
      SELECT DISTINCT name
      FROM dishes;))

    table_printer("List of dishes", result)
  end

  def users_by(param)
    column_ref
    _, value = param.split("=")
    value = column_ref[value]

    result = @db.exec(%[
      SELECT #{value}, COUNT(*), ROUND( (COUNT(*)*100 /  SUM( COUNT(*) ) OVER() ),2) || '%' percentage FROM clients
        GROUP BY #{value}
        ORDER BY #{value};
    ])

    table_printer("Number and Distribution of Users", result)
  end

  def top10_by_visitors
    result = @db.exec(%(
      SELECT a.name, COUNT(*) as visitors FROM restaurants AS a
        INNER JOIN restaurants_dishes AS b ON b.restaurant_id = a.id
        INNER JOIN visits AS c ON c.restaurant_dish_id = b.id
        GROUP BY a.name ORDER BY visitors DESC LIMIT 10;))

    table_printer("Top 10 restaurants by visitors", result)
  end

  def top10_by_sales
    result = @db.exec(%(
      SELECT a.name, SUM(price) AS sales FROM restaurants AS a
      INNER JOIN restaurants_dishes AS b ON b.restaurant_id = a.id
      GROUP BY a.name ORDER BY sales DESC LIMIT 10;))

    table_printer("Top 10 restaurants by sales", result)
  end

  def top10_by_average_expense
    result = @db.exec(%[
      SELECT a.name, ROUND(AVG(price),1) AS "avg expense" FROM restaurants AS a
      INNER JOIN restaurants_dishes AS b ON b.restaurant_id = a.id
      GROUP BY a.name ORDER BY "avg expense" DESC LIMIT 10;])

    table_printer("Top 10 restaurants by average expense per user", result)
  end

  def average_expense_by(param)
    column_ref

    _, value = param.split("=")
    value = column_ref[value]

    result = @db.exec(%[
      SELECT #{value}, ROUND(AVG(rd.price),1) AS avg_expense FROM clients
      JOIN visits AS v ON clients.id = v.client_id
      JOIN restaurants_dishes AS rd ON v.restaurant_dish_id = rd.id
      GROUP BY #{value} ORDER BY avg_expense;
    ])

    table_printer("Average consumer expenses", result)
  end

  def sales_per_month(param)
    _, value = param.split("=")

    result = @db.exec(%[
      SELECT to_char(v.date,'Mon') AS month, SUM(rd.price) AS sales  FROM visits AS v
      JOIN restaurants_dishes AS rd ON v.restaurant_dish_id = rd.id
      GROUP BY month ORDER BY sales #{value};
    ])

    table_printer("Total sales by month", result)
  end

  def best_price_dish
    result = @db.exec(%(
      SELECT DISTINCT ON (d.name) d.name as dish, r.name, MIN(rd.price) as price
      FROM dishes AS d
      JOIN restaurants_dishes AS rd ON d.id = rd.dish_id
      JOIN restaurants AS r on r.id = rd.restaurant_id
      GROUP BY d.name, r.name ORDER BY dish, price;))

    table_printer("Best price for dish", result)
  end

  def favorite_dish_by(param)
    column_ref

    column, value = param.split("=")
    column = column_ref[column]

    result = @db.exec(%[
      SELECT #{column}, a.name as dish, COUNT(a.name) count FROM dishes a
      INNER JOIN restaurants_dishes b ON b.dish_id = a.id
      INNER JOIN visits c ON c.restaurant_dish_id = b.id
      INNER JOIN clients ON clients.id = c.client_id
      WHERE #{column} LIKE LOWER('%#{value}%')
      GROUP BY #{column}, dish
      ORDER BY count DESC LIMIT 1;
    ])

    table_printer("Average consumer expenses", result)
  end
end

app = InsightsApp.new
app.start
