class OpenWeatherService < BaseService
  def self.get_weather(input, units)
    response = conn.get("data/2.5/onecall") do |req|
      req.params['lat'] = input[0].to_s
      req.params['lon'] = input[1].to_s
      req.params['units'] = units
      req.params['exclude'] = "minutely,alerts"
      req.params['appid'] = Figaro.env.weather_api_key
    end
    self.parse_json(response)
  end

  def self.get_forecast(input, units = 'imperial')
    response = conn.get("data/2.5/onecall") do |req|
      req.params['lat'] = input[0].to_s
      req.params['lon'] = input[1].to_s
      req.params['units'] = units
      req.params['exclude'] = "current,minutely,alerts"
      req.params['appid'] = Figaro.env.weather_api_key
    end
    self.parse_json(response)
  end

  private
    def self.conn
      self.faraday_conn("https://api.openweathermap.org/")
    end  
end