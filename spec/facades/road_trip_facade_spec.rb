require 'rails_helper'

RSpec.describe RoadTripFacade, type: :facade, vcr: { :match_requests_on => [:uri] } do
  let!(:origin) { 'Denver,CO' }
  let!(:destination) { 'Pueblo,CO' }

  it "can call a service to get a road trip" do
    road_trip = RoadTripFacade.create_trip(origin, destination)
    
    expect(road_trip).to be_a(Hash)
    expect(road_trip).to have_key(:realTime)
    expect(road_trip[:realTime]).to be_a(Integer)
    expect(road_trip).to have_key(:formattedTime)
    expect(road_trip[:formattedTime]).to be_a(String)
    expect(road_trip).to have_key(:legs)
    expect(road_trip[:legs]).to be_an(Array)
  end
end
