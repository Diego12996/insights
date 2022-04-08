require "pg"
require "csv"

DB = PG.connect(dbname: "insights") 

def insert(table, data, unique_column = nil)
    entity = nil
  
    entity = find(table, unique_column, data[unique_column]) if (unique_column)
    
    entity ||=  DB.exec(%[INSERT INTO #{table} (#{data.keys.join(', ')})
                VALUES (#{data.values.map { |value| "'#{value.gsub("'","''")}'"}.join(", ")})
                RETURNING *;]).first
  
    entity
end
  
def find(table, column, value)
    DB.exec(%[
      SELECT * FROM #{table} 
      WHERE #{column} = '#{value.gsub("'","''")}'; 
      ]).first
end
  
CSV.foreach("data.csv", headers: true) do |row|
    client_data = {
      "name" => row["client_name"],
      "age" => row["age"],
      "gender" => row["gender"],
      "occupation" => row["occupation"],
      "nationality" => row["nationality"]
    }
    insert("client", client_data, "name")
  
    # publisher_data = {
    #   "name" => row["publisher_name"],
    #   "annual_revenue" => row["publisher_annual_revenue"],
    #   "founded_year" => row["publisher_founded_year"]
    # }
    # publisher = insert("publishers", publisher_data, "name")
  
    # genre_data = {
    #   "name" => row["genre"]
    # }
    # genre = insert("genres", genre_data, "name")
  
    # book_data = {
    #   "title" => row["title"],
    #   "pages" => row["pages"],
    #   "author_id" => author["id"],
    #   "publisher_id" => publisher["id"]
    # }
    # book = insert("books", book_data, "title")
  
    # book_genre_data = {
    #   "book_id" => book["id"],
    #   "genre_id" => genre["id"]
    # }
    # insert("books_genres", book_genre_data)
end
