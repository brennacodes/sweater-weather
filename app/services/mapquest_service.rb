class MapquestService
  def self.get_coordinates(location)
    if location.count > 1
      get_coordinates_with_units(location)
    else
      get_coordinates_without_units(location)
    end
  end
  
  private
    def self.conn
      Faraday.new("http://www.mapquestapi.com/geocoding/v1")
    end

    def get_coordinates_with_units(location)
      units_requested = location[1]
      response = conn.get("/address") do |req|
        req.params { 
          location: location[0],
          units: units_requested,
          key: ENV['MAPQUEST_API_KEY']
        }
      end
      JSON.parse(response.body, symbolize_names: true)
    end

    def get_coordinates_without_units(location)
      response = conn.get("/address") do |req|
        req.params { 
          location: location,
          key: ENV['MAPQUEST_API_KEY']
        }
      end
      JSON.parse(response.body, symbolize_names: true)
    end
end