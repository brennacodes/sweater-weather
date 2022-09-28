require 'rails_helper'

RSpec.describe RoadTrip, type: :poro, vcr: { :match_requests_on => [:uri] } do
  let!(:origin) { 'Denver,CO' }
  let!(:destination) { 'Pueblo,CO' }

  it "creates a road trip object" do
    trip = RoadTrip.new({
      start_city: origin, 
      end_city: destination,
      travel_time: "2 hours, 30 minutes",
      weather_at_eta: { temperature: 70.0, conditions: "sunny" }
    })

    expect(trip).to be_a(RoadTrip)
  end
end