class MapquestService
  def self.get_coordinates(location)
    response = conn.get("/address") do |req|
      req.params['location'] = location
      req.params['key'] = ENV['MAPQUEST_API_KEY']
    end
    JSON.parse(response.body, symbolize_names: true)
  end
  
  private
    def self.conn
      Faraday.new("http://www.mapquestapi.com/geocoding/v1")
    end
end