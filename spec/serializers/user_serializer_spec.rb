require 'rails_helper'

RSpec.describe UserSerializer, type: :serializer, vcr: { :match_requests_on => [:uri] } do
  let!(:user) { User.create!(email: "email@email.com", password: "password", password_confirmation: "password") }

  it "serializes a user" do
    serialized = UserSerializer.new(user).serializable_hash

    expect(serialized).to have_key(:data)
    expect(serialized[:data]).to be_a(Hash)
    expect(serialized[:data]).to have_key(:id)
    expect(serialized[:data][:id]).to be_a(String)
    expect(serialized[:data]).to have_key(:type)
    expect(serialized[:data][:type]).to be_a(Symbol)
    expect(serialized[:data][:type]).to eq(:user)
    expect(serialized[:data]).to have_key(:attributes)
    expect(serialized[:data][:attributes]).to be_a(Hash)
    expect(serialized[:data][:attributes]).to have_key(:email)
    expect(serialized[:data][:attributes][:email]).to be_a(String)
    expect(serialized[:data][:attributes][:email]).to eq(user.email)
    expect(serialized[:data][:attributes]).to have_key(:api_key)
    expect(serialized[:data][:attributes][:api_key]).to be_a(String)
    expect(serialized[:data][:attributes][:api_key]).to eq(user.api_key)
  end
end
