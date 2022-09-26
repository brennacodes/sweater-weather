class BookFacade
  def self.get_books(location, quantity)
    books = BookService.search_books(location, quantity)
    books.map do |book|
      Book.new(book)
    end
  end
end