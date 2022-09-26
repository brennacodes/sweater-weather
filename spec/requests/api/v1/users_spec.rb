require 'rails_helper'

RSpec.describe "User Registration", type: :request, vcr: true do
  let!(:email) { Faker::Internet.email }
  let!(:password) { "password" }
  let!(:valid_params) { 
    {
     "email": email, 
     "password": password, 
     "password_confirmation": password 
    } 
  }

  describe "post request to /api/v1/users" do
    it "has a happy path" do
      post api_v1_users_path, params: valid_params

      expect(response).to be_successful
      expect(response.status).to eq(201)

      data = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(data[:id]).to eq(1)
      expect(data[:type]).to eq("user")

      attributes = data[:attributes]
      expect(attributes[:email]).to eq(email)
      expect(attributes[:api_key]).to be_a(String)
      expect(attributes[:api_key].length).to eq(22)
      expect(attributes).to_not have_key(:password_digest)
      expect(attributes).to_not have_key(:password)
    end
  end
end
