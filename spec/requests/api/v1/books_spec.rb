require 'rails_helper'

RSpec.describe "book search", type: :request, vcr: true do
  let!(:location) { "Denver,CO" }
  let!(:quantity) { 5 }
  
  describe "GET /book-search" do
    it "retrieves books for a given location and quantity limit" do
      get '/api/v1/book-search', params: { location: location, quantity: quantity }
      expect(response).to have_http_status(200)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      test = JSON.parse(response.body, symbolize_names: true)
      expect(test).to have_key(:data)

      data = test[:data]
      expect(data).to have_key(:id)
      expect(data[:id]).to eq("null")
      expect(data).to have_key(:type)
      expect(data[:type]).to be_a(String)
      expect(data[:type]).to eq("books")
      expect(data).to have_key(:attributes)
      expect(data[:attributes]).to be_a(Hash)

      attributes = data[:attributes]

      expect(attributes).to have_key(:destination)
      expect(attributes[:destination]).to be_a(String)
      expect(attributes[:destination]).to eq(location)

      expect(attributes).to have_key(:total_books_found)
      expect(attributes[:total_books_found]).to be_a(Integer)

      expect(attributes).to have_key(:forecast)
      expect(attributes[:forecast]).to be_a(Hash)

      expect(attributes[:forecast]).to have_key(:summary)
      expect(attributes[:forecast][:summary]).to be_a(String)

      expect(attributes[:forecast]).to have_key(:temperature)
      expect(attributes[:forecast][:temperature]).to be_a(String)

      expect(attributes).to have_key(:books)
      expect(attributes[:books]).to be_an(Array)
      expect(attributes[:books].count).to eq(quantity)

      expect(attributes[:books].first).to have_key(:title)
      expect(attributes[:books].first[:title]).to be_a(String)

      expect(attributes[:books].first).to have_key(:isbn)
      expect(attributes[:books].first[:isbn]).to be_a(Array)

      expect(attributes[:books].first).to have_key(:publisher)
      expect(attributes[:books].first[:publisher]).to be_a(Array)
    end

    it "returns an error if the quantity is invalid" do
      get api_v1_books_path, params: { location: location, quantity: 0 }
      expect(response).to_not be_successful
      expect(response).to have_http_status(400)

      get api_v1_books_path, params: { location: location, quantity: -1 }
      expect(response).to_not be_successful
      expect(response).to have_http_status(400)
    end
  end
end
