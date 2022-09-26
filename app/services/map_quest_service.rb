class MapQuestService < BaseService
# include Parsable
  def self.get_coordinates(location)
    response = conn.get("/geocoding/v1/address") do |req|
      req.params['location'] = location
      req.params['key'] = Figaro.env.map_api_key
    end
    self.parse_json(response)
  end
  
  private
    def self.conn
      self.faraday_conn("http://www.mapquestapi.com")
    end
end