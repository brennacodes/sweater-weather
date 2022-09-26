class BookFacade
  def self.get_books(location, quantity)
    search = BookService.search_books(location, quantity)

    books = search[:docs].map do |book|
      Book.new(book)
    end

    Books.new({
      books: books,, 
      location: location,
      forcast: get_forecast(location),
      total_books_found: search[:numFound]
    })
  end

  def self.get_forecast(location)
    coords = MapQuestFacade.get_coords(location)
    current = ForecastFacade.current_conditions(coords, 'imperial')
    { 
      summary: current[:weather][0][:description], 
      temperature: current[:temp].to_s.join(' °F') 
    }
  end
end