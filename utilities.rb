module Utilities
  def table_printer(prompt, result)
    table = Terminal::Table.new
    table.title = prompt
    table.headings = result.fields
    table.rows = result.values
    table.style = { border: :unicode }
    puts table
  end
end
