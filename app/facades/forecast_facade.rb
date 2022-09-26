class ForecastFacade
  def self.weather(coords, *units)
    forecast = OpenWeatherService.get_weather([coords[0], coords[1]], *units)
    weather_breakdown(forecast)
  end

  private
    def self.weather_breakdown(forecast)
      weather = Hash.new
      weather[:current] = CurrentWeather.new(forecast[:current])
      weather[:daily] = forecast[:daily].map do |daily|
        DailyWeather.new(daily)
      end
      weather[:hourly] = forecast[:hourly].map do |hourly|
        HourlyWeather.new(hourly)
      end
      weather
      require 'pry'; binding.pry 
    end
end