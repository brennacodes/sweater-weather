class ForecastPoro
  attr_reader :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(data)
    @current_weather = get_current_weather(data[:current])
    @daily_weather = get_daily_weather(data[:daily])
    @hourly_weather = get_hourly_weather(data[:hourly])
  end

  def get_current_weather(data)
    data.map do |current|

    end
  end

  def get_daily_weather(data)
    data.map do |daily|

    end
  end

  def get_hourly_weather(data)
    data.map do |hourly|

    end
  end 
end