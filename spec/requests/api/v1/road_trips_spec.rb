require 'rails_helper'

RSpec.describe "RoadTrips", type: :request, vcr: { :match_requests_on => [:uri] } do
  let!(:origin) { "Denver,CO" }
  let!(:destination) { "Pueblo,CO" }
  let!(:user) { User.create!(email: "email@email.com", password: "pass", password_confirmation: "pass") }

  context "POST /road_trip" do
    it "returns json with travel time, arrival weather, and arrival temperature" do
      user_1 = User.create(email: "whatever@example.com", password: "password")

      post api_v1_road_trips_path, params: { origin: origin, destination: destination, api_key: user_1.api_key }
      
      expect(response).to be_successful
      
      json_body = JSON.parse(response.body, symbolize_names: true)
      expect(json_body).to have_key(:data)
      expect(json_body[:data]).to be_a(Hash)

      data = json_body[:data]
      expect(data).to have_key(:id)
      expect(data[:id]).to be_nil
      expect(data).to have_key(:type)
      expect(data[:type]).to be_a(String)
      expect(data[:type]).to eq("roadtrip")
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
      expect(data[:attributes][:travel_time]).to eq("about 2 hours")
      expect(data[:attributes]).to have_key(:weather_at_eta)
      expect(data[:attributes][:weather_at_eta]).to be_a(Hash)
      expect(data[:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(data[:attributes][:weather_at_eta][:temperature]).to be_a(Float)
      expect(data[:attributes][:weather_at_eta]).to have_key(:conditions)
      expect(data[:attributes][:weather_at_eta][:conditions]).to be_a(String)
    end

    it "returns a 401 error if the api key is invalid" do
      post api_v1_road_trips_path, params: { origin: origin, destination: destination, api_key: "12345" }
      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      expect(response.body.include?("Invalid API key")).to be_truthy
    end
    
    it "returns a 401 error if the api key is missing" do
      post api_v1_road_trips_path, params: { origin: origin, destination: destination }
      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      expect(response.body.include?("Invalid API key")).to be_truthy
    end
  end
end
