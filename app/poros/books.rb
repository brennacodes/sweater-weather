class Books
  attr_reader :id,
              :destination,
              :forecast,
              :total_books_found,
              :books

  def initialize(attributes)
    @id = 0
    @destination = attributes[:location]
    @forecast = attributes[:forecast]
    @total_books_found = attributes[:total_books_found]
    @books = attributes[:books]
  end
end