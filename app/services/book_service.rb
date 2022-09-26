class BookService < BaseService
  def self.get_books(location)
    response = conn.get("search.json") do |req|
      req.params['title'] = location
      req.params['key'] = Figaro.env.books_api_key
    end
    self.parse_json(response)
  end
  
  private
    def self.conn
      self.faraday_conn("http://openlibrary.org/")
    end
end