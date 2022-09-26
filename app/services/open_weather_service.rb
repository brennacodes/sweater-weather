class OpenWeatherService < BaseService
  def self.get_weather(input, *units)
    units.empty? ? units = "imperial" : units = units[0]
    response = conn.get("data/2.5/onecall") do |req|
      req.params['lat'] = input[0].to_s
      req.params['lon'] = input[1].to_s
      req.params['units'] = units
      req.params['exclude'] = "minutely"
      req.params['appid'] = Figaro.env.weather_api_key
    end
    self.parse_json(response)
  end

  private
    def self.conn
      self.faraday_conn("https://api.openweathermap.org/")
    end  

    def self.get_weather_with_units(input, units)
      response = conn.get("data/2.5/onecall") do |req|
        req.params['lat'] = input[0]
        req.params['lon'] = input[1]
        req.params['units'] = units
        req.params['exclude'] = "minutely"
        req.params['appid'] = Figaro.env.weather_api_key
      end
      self.parse_json(response)
    end
end