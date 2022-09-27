require 'rails_helper'

RSpec.describe "Sessions", type: :request, vcr: { :match_requests_on => [:uri] } do
  let!(:email) { "whatever@example.com" }
  let!(:password) { "password" }
  let!(:user) { User.create(email: email, password: password) }

  describe "POST /api/v1/sessions" do
    it "returns json with api key when valid params are given" do
      post api_v1_sessions_path, params: { email: email, password: password }
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body).to have_key(:data)
      expect(body[:data]).to be_a(Hash)
      expect(body[:data]).to have_key(:id)
      expect(body[:data][:id]).to be_a(String)
      expect(body[:data]).to have_key(:type)
      expect(body[:data][:type]).to be_a(String)
      expect(body[:data]).to have_key(:attributes)
      expect(body[:data][:attributes]).to be_a(Hash)
      expect(body[:data][:attributes]).to have_key(:email)
      expect(body[:data][:attributes][:email]).to be_a(String)
      expect(body[:data][:attributes]).to have_key(:api_key)
      expect(body[:data][:attributes][:api_key]).to be_a(String)
      expect(body[:data][:attributes][:api_key].length).to eq(28)
    end

    it "returns 401 if no params are given" do
      post api_v1_sessions_path, params: {}
      expect(response.status).to eq(401)

      message = JSON.parse(response.body, symbolize_names: true)
      expect(message).to eq({"error": "Invalid credentials"})
    end

    it "returns 401 if invalid credentials are given" do
      post api_v1_sessions_path, params: { email: email, password: "password1" }
      expect(response.status).to eq(401)

      message = JSON.parse(response.body, symbolize_names: true)
      expect(message).to eq({"error": "Invalid credentials"})
    end
  
  end
end
