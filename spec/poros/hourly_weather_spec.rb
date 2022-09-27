require 'rails_helper'

RSpec.describe HourlyWeather, type: :poro, vcr: { :match_requests_on => [:uri] } do
  let!(:location) { 'denver,co' }
  let!(:forecast) { OpenWeatherService.get_weather([39.7392358, -104.990251], 'imperial') }

  it "returns a daily weather object" do
    object = HourlyWeather.new(forecast[:hourly].first)

    expect(object).to be_a(HourlyWeather)
    expect(object.temperature).to be_a(Float)
    expect(object.conditions).to be_a(String)
    expect(object.icon).to be_a(String)
    expect(object.time).to be_a(DateTime)
  end
end
