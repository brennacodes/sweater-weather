require 'rails_helper'

RSpec.describe "Forecasts", type: :request, vcr: true do
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

      get api_v1_forecasts_path, params: { location: sad_location_2 }
      expect(response).to_not be_successful

      get api_v1_forecasts_path, params: { location: sad_location_3 }
      expect(response).to_not be_successful
    end

    it "returns necessary data" do
      get api_v1_forecasts_path, params: { location: happy_location }

      expect(response).to be_successful
      expect(response[:id]).to be(null)
      expect[:data][:attributes][:current_weather].to have_key(:datetime)
    end
  end

  describe "request with location and units params" do
    let!(:happy_units) { "metric" }
    let!(:sad_units_1) { " " }
    let!(:sad_units_2) { "zzzzz" }
  end
end
