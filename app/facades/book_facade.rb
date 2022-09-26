class BookFacade
  def self.get_books(location, quantity)
    BookService.search_books(location, quantity)
  end
end