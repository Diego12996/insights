require "pg"
require "terminal-table"
require "colorize"

class InsightsApp
  def initialize
    @db = PG.connect(dbname: "insights")
  end

  def start
    puts "Welcome to the Restaurants Insights!"
    puts "Write 'menu' at any moment to print the menu again and 'quit' to exit."
    menu
    print "> "
    option, param = gets.chomp.split

    until option == "quit"
      case option
      when "1" then search_by(param)
      when "2" then unique_dish
      when "3" then users_by(param)
      when "4" then top10_by_visitors
      when "5" then top10_by_sales
      when "6" then top10_by_average_expense
      when "7" then average_expense_by(param)
      when "8" then sales_per_month(param)
      when "9" then best_price_dish
      when "10" then favorite_dish_by(param)
      when "menu" then menu
      end
      print "> "
      option, param = gets.chomp.split
    end
  end

  def menu
    puts "---"
    puts "1. List of restaurants included in the research filter by ['' | category=string | city=string]"
    puts "2. List of unique dishes included in the research"
    puts "3. Number and distribution (%) of clients by [group=[age | gender | occupation | nationality]]"
    puts "4. Top 10 restaurants by the number of visitors."
    puts "5. Top 10 restaurants by the sum of sales."
    puts "6. Top 10 restaurants by the average expense of their clients."
    puts "7. The average consumer expense group by [group=[age | gender | occupation | nationality]]"
    puts "8. The total sales of all the restaurants group by month [order=[asc | desc]]"
    puts "9. The list of dishes and the restaurant where you can find it at a lower price."
    puts "10. The favorite dish for [age=number | gender=string | occupation=string | nationality=string]"
    puts "---"
    puts "Pick a number from the list and an [option] if necessary"
  end

  def search_by(param)
    if param.nil?
      result = @db.exec(%(
        SELECT
          restaurant.name,
          restaurant.category,
          restaurant.city
          FROM restaurant))
    else
      column_ref = {
        "category" => "restaurant.category",
        "city" => "restaurant.city"
      }

      column, value = param.split("=")
      column = column_ref[column]

      result = @db.exec(%[
        SELECT
          restaurant.name,
          restaurant.category,
          restaurant.city
        FROM
          restaurant
        WHERE LOWER(#{column}) LIKE LOWER('%#{value}%');
      ])
    end

    table = Terminal::Table.new
    table.title = "List of restaurants"
    table.headings = result.fields
    table.rows = result.values
    table.style = { border: :unicode }
    puts table
  end

  def unique_dish
    result = @db.exec(%(
      SELECT
        dish.name
        FROM dish
        ORDER BY dish.name))

    table = Terminal::Table.new
    table.title = "List of dishes"
    table.headings = result.fields
    table.rows = result.values
    table.style = { border: :unicode }
    puts table
  end

  def users_by(param)
    column_ref = {
      "age" => "client.age",
      "gender" => "client.gender",
      "occupation" => "client.occupation",
      "nationality" => "client.nationality"
    }

    column, value = param.split("=")
    order_by = value
    value = column_ref[value]

    result = @db.exec(%[
      SELECT
        #{value},
        COUNT(#{value}),
        CONCAT((COUNT(#{value})*100 / (SELECT COUNT(#{value}) FROM client)), '%') AS "percentage"
      FROM client
      GROUP BY #{value}
      ORDER BY #{order_by} ASC;
    ])

    table = Terminal::Table.new
    table.title = "Number and Distribution of Users"
    table.headings = result.fields
    table.rows = result.values
    table.style = { border: :unicode }
    puts table
  end

  def top10_by_visitors
    
    result = @db.exec(%(
      SELECT
      r.name, count(rc.client_id) as visitors
      FROM restaurant as r
      JOIN rest_clients as rc on r.id = rc.restaurant_id
      GROUP BY r.name 
      ORDER BY visitors DESC
      LIMIT 10))

    table = Terminal::Table.new
    table.title = "Top 10 restaurants by visitors"
    table.headings = result.fields
    table.rows = result.values
    table.style = { border: :unicode }
    puts table
  end

  def top10_by_sales
    
    result = @db.exec(%(
      SELECT r.name, SUM(rd.price) AS sales
      FROM restaurant AS r 
      JOIN restaurant_dishes AS rd ON r.id = rd.restaurant_id
      GROUP BY r.name
      ORDER BY sales DESC
      LIMIT 10))

    table = Terminal::Table.new
    table.title = "Top 10 restaurants by sales"
    table.headings = result.fields
    table.rows = result.values
    table.style = { border: :unicode }
    puts table
  end

  def top10_by_average_expense
    
    result = @db.exec(%(
      SELECT r.name, ROUND(AVG(rd.price),1) AS "avg expense"
      FROM restaurant AS r 
      JOIN restaurant_dishes AS rd ON r.id = rd.restaurant_id
      GROUP BY r.name
      ORDER BY "avg expense" DESC
      LIMIT 10))

    table = Terminal::Table.new
    table.title = "Top 10 restaurants by average expense per user"
    table.headings = result.fields
    table.rows = result.values
    table.style = { border: :unicode }
    puts table
  end

  def average_expense_by(_param)
    table = Terminal::Table.new
    table.title = "Average consumer expenses"
    table
  end

  def sales_per_month(_param)
    table = Terminal::Table.new
    table.title = "Total sales by month"
    table
  end

  def best_price_dish
    table = Terminal::Table.new
    table.title = "Best price for dish"
    table
  end

  def favorite_dish_by(_param)
    table = Terminal::Table.new
    table.title = "Favorite dish"
    table
  end
end

app = InsightsApp.new
app.start
