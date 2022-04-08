require "pg"
require"terminal-table"


class InsightsApp
  def initialize; end
  
  def start
    puts "Welcome to the Restaurants Insights!"
    puts "Write 'menu' at any moment to print the menu again and 'quit' to exit."
    print "> "
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
  end
end

app = InsightsApp.new
app.start