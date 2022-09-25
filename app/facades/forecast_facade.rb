class ForecastFacade
  def self.verify_location(location)
    CityVerifyService.verify_location(location)
  end

  def self.weather(coords)
    forecast = OpenWeatherService.get_weather(coords[0], coords[1])
    weather_breakdown(forecast)
  end

  private
    def is_valid_location?(location)
      CityVerifyService.verify_location(location)
    end

    def weather_breakdown(forecast)
      weather = Hash.new
      weather[:current] = CurrentWeather.new(forecast[:current])
      weather[:daily] = forecast[:daily].map do |daily|
        DailyWeather.new(daily)
      end
      weather[:hourly] = forecast[:hourly].map do |hourly|
        HourlyWeather.new(hourly)
      end
      weather
    end
end