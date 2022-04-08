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
    when "1" then "execute 1"
    when "2" then "execute 2"
    when "3" then "execute 3"
    when "4" then "execute 4"
    when "5" then "execute 5"
    when "6" then "execute 6"
    when "7" then "execute 7"
    when "8" then "execute 8"
    when "9" then "execute 9"
    when "quit" then "quit"
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
end

app = InsightsApp.new
app.start