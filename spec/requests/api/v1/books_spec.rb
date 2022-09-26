require 'rails_helper'

RSpec.describe "book search", type: :request, vcr: true do
  let!(:location) { "Denver,CO" }
  let!(:quantity) { 5 }
  
  describe "GET /books" do
    it "retrieves books for a given location and quantity limit" do
      get api_v1_books_path, params: { location: location, quantity: quantity }
      expect(response).to have_http_status(200)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_key(:data)

      data = response[:data]
      expect(data).to have_key(:id)
      expect(data[:id]).to eq(nil)
      expect(data).to have_key(:type)
      expect(data[:type]).to be_a(String)
      expect(data[:type]).to eq("book")
      expect(data).to have_key(:attributes)
      expect(data[:attributes]).to be_a(Hash)

      attributes = data[:attributes]

      expect(attributes).to have_key(:location)
      expect(attributes[:location]).to be_a(String)
      expect(attributes[:location]).to eq(location)

      expect(attributes).to have_key(:total_books_found)
      expect(attributes[:total_books_found]).to be_a(Integer)

      expect(attributes).to have_key(:forcast)
      expect(attributes[:forcast]).to be_a(Hash)

      expect(attributes[:forcast]).to have_key(:summary)
      expect(attributes[:forcast][:summary]).to be_a(String)

      expect(attributes[:forcast]).to have_key(:temperature)
      expect(attributes[:forcast][:temperature]).to be_a(String)

      expect(attributes).to have_key(:books)
      expect(attributes[:books]).to be_an(Array)
      expect(attributes[:books].count).to eq(quantity)

      expect(attributes[:books].first).to have_key(:title)
      expect(attributes[:books].first[:title]).to be_a(String)

      expect(attributes[:books].first).to have_key(:author)
      expect(attributes[:books].first[:author]).to be_a(String)

      expect(attributes[:books].first).to have_key(:isbn)
      expect(attributes[:books].first[:isbn]).to be_a(Array)

      expect(attributes[:books].first).to have_key(:publisher)
      expect(attributes[:books].first[:publisher]).to be_a(Array)
    end
  end
end
