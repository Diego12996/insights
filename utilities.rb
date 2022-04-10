module Utilities
  def table_printer(prompt, result)
    table = Terminal::Table.new
    table.title = prompt
    table.headings = result.fields
    table.rows = result.values
    table.style = { border: :unicode }
    puts table
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

  def welcome_message
    puts "Welcome to the Restaurants Insights!"
    puts "Write 'menu' at any moment to print the menu again and 'quit' to exit."
  end

  def column_ref
    {
      "age" => "clients.age",
      "gender" => "clients.gender",
      "occupation" => "clients.occupation",
      "nationality" => "clients.nationality"
    }
  end

  def case_when(option, param)
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
  end

  # def for validate option param = option insert for user
  def validation_param(param, left, right)
    izq, der = param.split("=")
    left.include?(izq) && (right.include?(der) || right.empty?) ? [izq, der] : []
  end

  # error msg if user insert invalid option prompt = suggestion input
  def error_msg(prompt)
    puts "Please insert a valid option like #{prompt}".red
  end
end
