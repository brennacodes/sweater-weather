require 'rails_helper'

RSpec.describe MapQuestService, type: :service, vcr: { :match_requests_on => [:uri] } do
  it "retrieves lat and long for a given location" do
    location = "denver,co"

    response = MapQuestService.get_coordinates(location)
    expect(response).to_not be_nil
    expect(response).to be_a(Hash)
    expect(response[:results]).to be_an(Array)
    expect(response[:results][0][:locations]).to be_an(Array)

    coords = response[:results][0][:locations][0][:latLng]
    expect(coords).to be_a(Hash)
    expect(coords).to have_key(:lat)
    expect(coords[:lat]).to be_a(Float)
    expect(coords).to have_key(:lng)
    expect(coords[:lng]).to be_a(Float)
  end

  it "retrieves travel time for a given origin and destination" do
    origin = "denver,co"
    destination = "pueblo,co"
    units = "imperial"

    response = MapQuestService.get_travel_time(origin, destination)
    expect(response).to_not be_nil
    expect(response).to be_a(Hash)
    expect(response[:route]).to be_a(Hash)
    expect(response[:route][:formattedTime]).to be_a(String)
  end
end
