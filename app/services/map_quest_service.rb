class MapQuestService < BaseService
  def self.get_coordinates(location)
    response = conn.get("/address") do |req|
      req.params = { 
        location: location,
        key: ENV['MAPQUEST_API_KEY']
      }
    end
    require 'pry'; binding.pry 
    parse_json(response)
  end
  
  private
    def self.conn
      faraday_conn("http://www.mapquestapi.com/geocoding/v1")
    end
end