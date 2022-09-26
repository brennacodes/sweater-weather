class DailyWeather
  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :conditions,
              :icon
  
  def initialize(data)
    @date = Time.at(data[:dt]).to_datetime
    @sunrise = Time.at(data[:sunrise]).to_datetime
    @sunset = Time.at(data[:sunset]).to_datetime
    @max_temp = data[:temp][:max]
    @min_temp = data[:temp][:min]
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end
end