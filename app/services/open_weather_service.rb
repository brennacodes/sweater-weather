class OpenWeatherService
  def self.get_weather(lat, long)
    response = conn.get("/onecall") do |req|
      req.params['lat'] = lat,
      req.params['lon'] = long,
      req.params['units'] = 'imperial'
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private
    def self.conn
      Faraday.new("https://api.openweathermap.org/data/2.5")
    end  
end