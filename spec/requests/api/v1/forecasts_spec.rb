require 'rails_helper'

RSpec.describe "Forecast", type: :request, vcr: { :match_requests_on => [:uri] } do
  let!(:user) { User.create!(email: Faker::Internet.email, password_digest: "password") }
  let!(:email) { user.email }
  let!(:password) { user.password_digest }
  let!(:api_key) { user.api_key }
  let!(:happy_location) { "Denver,CO" }
  let!(:sad_location_1) { "Denver" }
  let!(:sad_location_2) { "aaljpoiap" }
  let!(:sad_location_3) { " " }

  describe "request with location params" do
    it "has has a happy path" do
      get api_v1_forecasts_path, params: { location: happy_location }
      expect(response).to have_http_status(:success)
    end

    it "has has a sad path" do
      get api_v1_forecasts_path, params: { location: sad_location_1 }
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(response.body.include?("Invalid location")).to be true
      
      get api_v1_forecasts_path, params: { location: sad_location_2 }
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(response.body.include?("Invalid location")).to be true
      
      get api_v1_forecasts_path, params: { location: sad_location_3 }
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(response.body.include?("Missing location")).to be true
    end

    it "returns necessary data" do
      get api_v1_forecasts_path, params: { location: happy_location }

      expect(response).to be_successful

      data = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(data[:id]).to be_nil
      expect(data[:type]).to eq("forecast")

      attributes = data[:attributes]
      expect(attributes[:current_weather]).to be_a(Hash)
      expect(attributes[:daily_weather]).to be_an(Array)
      expect(attributes[:hourly_weather]).to be_an(Array)

      current_weather = attributes[:current_weather]
      expect(current_weather[:datetime]).to be_a(String)
      expect(current_weather[:sunrise]).to be_a(String)
      expect(current_weather[:sunset]).to be_a(String)
      expect(current_weather[:temperature]).to be_a(Float)
      expect(current_weather[:temperature]).to be < 100
      expect(current_weather[:feels_like]).to be_a(Float)
      expect(current_weather[:feels_like]).to be < 100
      expect(current_weather[:humidity]).to be_an(Integer)
      expect(current_weather[:humidity]).to be < 100
      expect(current_weather[:uvi]).to be_an(Float)
      expect(current_weather[:visibility]).to be_an(Integer)
      expect(current_weather[:conditions]).to be_a(String)
      expect(current_weather[:icon]).to be_a(String)

      daily_weather = attributes[:daily_weather]
      expect(daily_weather[0][:date]).to be_a(String)
      expect(daily_weather[0][:sunrise]).to be_a(String)
      expect(daily_weather[0][:sunset]).to be_a(String)
      expect(daily_weather[0][:max_temp]).to be_a(Float)
      expect(daily_weather[0][:max_temp]).to be < 100
      expect(daily_weather[0][:min_temp]).to be_a(Float)
      expect(daily_weather[0][:min_temp]).to be < 100
      expect(daily_weather[0][:conditions]).to be_a(String)
      expect(daily_weather[0][:icon]).to be_a(String)

      hourly_weather = attributes[:hourly_weather]
      expect(hourly_weather[0][:time]).to be_a(String)
      expect(hourly_weather[0][:temperature]).to be_a(Float)
      expect(hourly_weather[0][:temperature]).to be < 100
      expect(hourly_weather[0][:conditions]).to be_a(String)
      expect(hourly_weather[0][:icon]).to be_a(String)
    end
  end

  describe "request with location and units params" do
    let!(:happy_units) { "metric" }
    let!(:sad_units_1) { " " }
    let!(:sad_units_2) { "zzzzz" }

    it "only has has a happy paths" do
      get api_v1_forecasts_path, params: { location: happy_location, units: happy_units }
      expect(response).to have_http_status(:success)

      get api_v1_forecasts_path, params: { location: happy_location, units: sad_units_1 }
      expect(response).to have_http_status(:success)

      get api_v1_forecasts_path, params: { location: happy_location, units: sad_units_2 }
      expect(response).to have_http_status(:success)
    end
  end
end
