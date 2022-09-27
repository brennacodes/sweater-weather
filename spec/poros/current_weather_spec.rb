require 'rails_helper'

RSpec.describe CurrentWeather, type: :poro, vcr: { :match_requests_on => [:uri] } do
  let!(:location) { 'denver,co' }
  let!(:forecast) { OpenWeatherService.get_weather([39.7392358, -104.990251], 'imperial') }

  it "returns a daily weather object" do
    object = CurrentWeather.new(forecast[:hourly].first)

    expect(object).to be_a(CurrentWeather)
    expect(object.datetime).to be_a(DateTime)
    expect(object.sunrise).to be_a(DateTime)
    expect(object.sunset).to be_a(DateTime)
    expect(object.temperature).to be_a(Float)
    expect(object.feels_like).to be_a(Float)
    expect(object.humidity).to be_a(Integer)
    expect(object.uvi).to be_a(Float)
    expect(object.visibility).to be_a(Integer)
    expect(object.conditions).to be_a(String)
    expect(object.icon).to be_a(String)
  end
end
