require 'rails_helper'

RSpec.describe DailyWeather, type: :poro, vcr: { :match_requests_on => [:uri] } do
  let!(:location) { 'denver,co' }
  let!(:forecast) { OpenWeatherService.get_weather([39.7392358, -104.990251], 'imperial') }

  it "returns a daily weather object" do
    object = DailyWeather.new(forecast[:daily].first)

    expect(object).to be_a(DailyWeather)
    expect(object.conditions).to be_a(String)
    expect(object.icon).to be_a(String)
    expect(object.max_temp).to be_a(Float)
    expect(object.min_temp).to be_a(Float)
    expect(object.date).to be_a(DateTime)
    expect(object.sunrise).to be_a(DateTime)
    expect(object.sunset).to be_a(DateTime)
  end
end
