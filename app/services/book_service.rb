class BookService < BaseService
  def self.search_books(location, qty)
    response = conn.get("search.json") do |req|
      req.params['q'] = location
      req.params['limit'] = qty
    end
    self.parse_json(response)
  end
  
  private
    def self.conn
      self.faraday_conn("http://openlibrary.org/")
    end
end