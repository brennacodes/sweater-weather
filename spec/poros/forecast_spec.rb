require 'rails_helper'

RSpec.describe Forecast, type: :poro, vcr: { :match_requests_on => [:uri] } do
  let!(:location) { 'denver,co' }
  let!(:forecast) { OpenWeatherService.get_weather([39.7392358, -104.990251], 'imperial') }

  it "returns a forecast object" do
    current = CurrentWeather.new(forecast[:current])
    daily = DailyWeather.new(forecast[:daily].first)
    hourly = HourlyWeather.new(forecast[:hourly].first)
    data = { current: current, daily: daily, hourly: hourly }
    
    object = Forecast.new(data)

    expect(object).to be_a(Forecast)
    expect(object.id).to be_nil
    expect(object.current_weather).to be_a(CurrentWeather)
    expect(object.daily_weather).to be_a(DailyWeather)
    expect(object.hourly_weather).to be_a(HourlyWeather)
  end
end
