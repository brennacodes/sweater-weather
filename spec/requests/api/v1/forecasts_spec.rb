require 'rails_helper'

RSpec.describe "Forecasts", type: :request do
  let!(:user) { User.create!(email: Faker::Internet.email, password: "password") }
  let!(:email) { user.email }
  let!(:password) { user.password }
  let!(:api_key) { user.api_key }
  let!(:headers) { { "CONTENT_TYPE" => "application/json" } }
  let!(:body) { { email: email, password: password }.to_json }
  let!(:happy_location) { "Denver,CO" }
  let!(:sad_location_1) { "aaljpoiap" }
  let!(:sad_location_2) { " " }

  describe "location params" do
    it "has has a happy path" do
      get api_v1_forecasts_path(location: happy_location)
      expect(response).to have_http_status(:success)
    end

    it "has has a sad path" do
      get api_v1_forecasts_path, params: { location: sad_location_1 }
      expect(response).to have_http_status(:not_found)
    end
  end
end
