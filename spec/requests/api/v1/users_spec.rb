require 'rails_helper'

RSpec.describe "User Registration", type: :request, vcr: { :match_requests_on => [:uri] } do
  let!(:email) { Faker::Internet.email }
  let!(:password) { "password" }
  let!(:valid_params) { 
    {
     "email": email, 
     "password": password, 
     "password_confirmation": password 
    } 
  }
  let!(:to_path) { "/api/v1/users" }

  context "post request to /api/v1/users" do
    context "has a happy path" do
      it "is successful" do
        post to_path, params: valid_params

        expect(response).to be_successful
        expect(response.status).to eq(201)

        data = JSON.parse(response.body, symbolize_names: true)[:data]
        id = User.last.id

        expect(data[:id]).to eq(id.to_s)
        expect(data[:type]).to eq("user")

        attributes = data[:attributes]
        expect(attributes[:email]).to eq(email)
        expect(attributes[:api_key]).to be_a(String)
        expect(attributes[:api_key].length).to eq(28)
        expect(attributes).to_not have_key(:password_digest)
        expect(attributes).to_not have_key(:password)
      end
    end

    context "has sad paths" do
      it "returns 400 if no params are given" do
        post to_path, params: {}
        expect(response.status).to eq(400)
        expect(response.body.include?("Missing required parameters")).to be_truthy
      end

      it "returns 400 if passwords are not given" do
        post to_path, params: { email: email }

        expect(response.status).to eq(400)
        expect(response.body.include?("Missing required")).to be_truthy
      end
      
      it "returns 400 if email and password confirmation are not given" do
        post to_path, params: { password: password }
        
        expect(response.status).to eq(400)
        expect(response.body.include?("Missing required")).to be_truthy
      end
      
      it "returns 400 if email is not given" do
        post to_path, params: { password: "hi", password_confirmation: password }
        expect(response.status).to eq(400)
        expect(response.body.include?("Missing required")).to be_truthy
      end

      it "returns 400 if password adn password_confirmation do not match" do
        post to_path, params: { email: email, password: password, password_confirmation: "password1" }
        expect(response.status).to eq(400)
        expect(response.body.include?("Password and password confirmation do not match")).to be_truthy
      end
    end
  

    context "when user already exists" do
      it "returns status 409" do
        post to_path, params: { email: "greg@greg.greg", password: password, password_confirmation: password }
        expect(response.status).to eq(201)

        post to_path, params: { email: "greg@greg.greg", password: "hello", password_confirmation: "hello" }
        expect(response.status).to eq(409)
        expect(response.body.include?("Email already exists")).to be_truthy
      end
    end
  end
end
