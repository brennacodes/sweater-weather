require "rails_helper"

RSpec.describe RoadTripSerializer, type: :serializer, vcr: { :match_requests_on => [:uri] } do
  let!(:origin) { "Denver,CO" }
  let!(:destination) { "Pueblo,CO" }
  let!(:user) { User.create!(email: "email@email.com", password: "pass", password_confirmation: "pass") }

  it "serializes a road_trip" do
    poro = RoadTrip.new({
      start_city: origin, 
      end_city: destination,
      travel_time: "1 hour, 53 minutes",
      weather_at_eta: {
        temperature: 75.0,
        conditions: "clear sky"
      }
    })

    serializer = RoadTripSerializer.new(poro).serializable_hash

    expect(serializer).to have_key(:data)
    expect(serializer[:data]).to be_a(Hash)

    data = serializer[:data]
    expect(data).to have_key(:id)
    expect(data[:id]).to be_nil
    expect(data).to have_key(:type)
    expect(data[:type]).to eq(:roadtrip)
    expect(data).to have_key(:attributes)
    expect(data[:attributes]).to be_a(Hash)
    expect(data[:attributes]).to have_key(:start_city)
    expect(data[:attributes][:start_city]).to be_a(String)
    expect(data[:attributes][:start_city]).to eq(origin)
    expect(data[:attributes]).to have_key(:end_city)
    expect(data[:attributes][:end_city]).to be_a(String)
    expect(data[:attributes][:end_city]).to eq(destination)
    expect(data[:attributes]).to have_key(:travel_time)
    expect(data[:attributes][:travel_time]).to be_a(String)
    expect(data[:attributes][:travel_time]).to eq("1 hour, 53 minutes")
    expect(data[:attributes]).to have_key(:weather_at_eta)
    expect(data[:attributes][:weather_at_eta]).to be_a(Hash)
    expect(data[:attributes][:weather_at_eta]).to have_key(:temperature)
    expect(data[:attributes][:weather_at_eta][:temperature]).to be_a(Float)
    expect(data[:attributes][:weather_at_eta]).to have_key(:conditions)
    expect(data[:attributes][:weather_at_eta][:conditions]).to be_a(String)
  end
end
