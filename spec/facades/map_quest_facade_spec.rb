require 'rails_helper'

RSpec.describe MapQuestFacade, type: :facade, vcr: { :match_requests_on => [:uri] } do
  let!(:location) { 'denver,co' }

  it "can get the lat and long of a location" do
    info = MapQuestFacade.verify_location(location)

    expect(info).to be_a(Hash)
    expect(info[:statuscode]).to be_nil
    expect(info[:results][0][:providedLocation][:location]).to eq(location)

    coords = info[:results][0][:locations][0][:latLng]
    expect(coords).to be_a(Hash)
    expect(coords).to have_key(:lat)
    expect(coords[:lat]).to be_a(Float)
    expect(coords).to have_key(:lng)
    expect(coords[:lng]).to be_a(Float)
  end

  it "can return coordinates as an array" do
    coords = MapQuestFacade.get_coords(location)
    expect(coords).to be_an(Array)
    expect(coords[0]).to be_a(Float)
    expect(coords[1]).to be_a(Float)
  end
end