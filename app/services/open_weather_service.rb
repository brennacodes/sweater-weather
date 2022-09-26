class OpenWeatherService < BaseService
  def self.get_weather(input)
    return get_weather_with_units(input) if input.count == 2
    
    response = conn.get("/onecall") do |req|
      req.params = { 
        lat: input[0],
        lon: input[1]
      }
    end
    parse_json(response)
  end

  private
    def self.conn
      faraday_conn("https://api.openweathermap.org/data/2.5")
    end  

    def self.get_weather_with_units(input)
      response = conn.get("/onecall") do |req|
        req.params = { 
          lat: input[0][0],
          lon: input[0][1],
          units: input[1]
        }
      end
      parse_json(response)
    end
end