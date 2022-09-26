class ForecastPoro
  attr_reader :id,
              :type,
              :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(data)
    @id = 0
    @type = "forecast"
    @current_weather = get_current_weather(data[:current])
    @daily_weather = get_daily_weather(data[:daily])
    @hourly_weather = get_hourly_weather(data[:hourly])
  end
end