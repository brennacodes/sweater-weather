require 'rails_helper'

RSpec.describe OpenWeatherService, type: :service, vcr: { :match_requests_on => [:uri] } do
  it "retrieves weather for given coordinates" do
    coords = [39.738453, -104.984853]
    units = "imperial"

    response = OpenWeatherService.get_weather(coords, units)
    expect(response).to_not be_nil
    expect(response).to be_a(Hash)
    expect(response).to have_key(:current)
    expect(response[:current]).to be_a(Hash)
    expect(response).to have_key(:daily)
    expect(response[:daily]).to be_an(Array)
    expect(response).to have_key(:hourly)
    expect(response[:hourly]).to be_an(Array)
    expect(response).to_not have_key(:minutely)
  end

  it "retrieves forecast for a given location" do
    coords = [39.738453, -104.984853]
    
    response = OpenWeatherService.get_forecast(coords)
    expect(response).to_not be_nil
    expect(response).to be_a(Hash)
    expect(response).to have_key(:daily)
    expect(response[:daily]).to be_an(Array)
    expect(response).to have_key(:hourly)
    expect(response[:hourly]).to be_an(Array)
    expect(response).to_not have_key(:current)
    expect(response).to_not have_key(:minutely)
  end
end