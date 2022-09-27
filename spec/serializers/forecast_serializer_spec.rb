require 'rails_helper'

RSpec.describe ForecastSerializer, type: :serializer, vcr: { :match_requests_on => [:uri] } do
  let!(:location) { 'denver,co' }
  let!(:weather) { OpenWeatherService.get_weather([39.7392358, -104.990251], 'imperial') }

  it "returns a forecast object" do
    current = CurrentWeather.new(weather[:current])
    daily = DailyWeather.new(weather[:daily].first)
    hourly = HourlyWeather.new(weather[:hourly].first)
    forecast = { current: current, daily: daily, hourly: hourly }
    
    object = Forecast.new(forecast)
    serialized = ForecastSerializer.new(object).serializable_hash
    
    expect(serialized).to be_a(Hash)
    expect(serialized).to have_key(:data)
    expect(serialized[:data]).to be_a(Hash)

    data = serialized[:data]
    expect(data[:id]).to be_nil
    expect(data).to have_key(:type)
    expect(data[:type]).to be_a(Symbol)
    expect(data[:type]).to eq(:forecast)
    expect(data).to have_key(:attributes)

    attributes = data[:attributes]
    expect(attributes).to be_a(Hash)
    expect(attributes).to have_key(:current_weather)
    expect(attributes[:current_weather]).to be_a(CurrentWeather)
    expect(attributes).to have_key(:daily_weather)
    expect(attributes[:daily_weather]).to be_an(DailyWeather)
    expect(attributes).to have_key(:hourly_weather)
    expect(attributes[:hourly_weather]).to be_an(HourlyWeather)
  end
end
