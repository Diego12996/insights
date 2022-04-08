require "pg"
require"terminal-table"


class InsightsApp
  def initialize; end
  
  def start
    puts "Welcome to the Restaurants Insights!"
    puts "Write 'menu' at any moment to print the menu again and 'quit' to exit."
    menu
    print "> "
    option, param = gets.chomp.split

    case option
    when "1" then search_by
    when "2" then unique_dish
    when "3" then users_by
    when "4" then top10_by_visitors
    when "5" then top10_by_sales
    when "6" then top10_by_average_expense
    when "7" then average_expense_by
    when "8" then sales_per_month
    when "9" then best_price_dish
    when "10" then favorite_dish_by
    when "quit" then print "Good bye!"
    when "menu" then menu        
    end

  end

  def options
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

  def search_by
  end

  def unique_dish
  end

  def users_by
  end

  def top10_by_visitors
  end

  def top10_by_sales
  end

  def top10_by_average_expense
  end

  def average_expense_by
  end

  def sales_per_month
  end

  def best_price_dish
  end

  def favorite_dish_by
  end


end

app = InsightsApp.new
app.start