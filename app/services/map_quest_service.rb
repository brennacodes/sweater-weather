class MapQuestService < BaseService
  def self.get_coordinates(location)
    response = conn.get("/geocoding/v1/address") do |req|
      req.params['location'] = location
      req.params['key'] = Figaro.env.map_api_key
    end
    self.parse_json(response)
  end

  def self.get_travel_time(origin, destination)
    response = conn.get("/directions/v2/route") do |req|
      req.params['key'] = Figaro.env.map_api_key
      req.params['from'] = origin
      req.params['to'] = destination
    end
    self.parse_json(response)
  end
  
  private
    def self.conn
      self.faraday_conn("http://www.mapquestapi.com")
    end
end