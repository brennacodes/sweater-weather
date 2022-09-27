require 'rails_helper'

RSpec.describe BookSerializer, type: :serializer do
  let!(:json) { File.read('spec/fixtures/book_fixture.json') }
  let!(:parsed) { JSON.parse(json, symbolize_names: true) }
  let!(:all_books) { parsed[:docs] }
  let!(:forecast) { { summary: "Partly cloudy", temperature: "75 F" } }
  let!(:books) { all_books.map { |book| Book.new(book) } }

  it 'serializes a book' do
    poro = Books.new({
      books: books, 
      location: "Denver,CO",
      forecast: forecast,
      total_books_found: parsed[:numFound]
    })

    serializer = BookSerializer.new(poro)

    expect(serializer).to have_key(:data)
    data = serializer[:data]

    expect(data).to have_key(:id)
    expect(data[:id]).to eq("null")
    expect(data).to have_key(:type)
    expect(data[:type]).to eq("books")
    expect(data).to have_key(:attributes)
    expect(data[:attributes]).to be_a(Hash)
    expect(data[:attributes]).to have_key(:destination)
    expect(data[:attributes][:destination]).to eq("Denver,CO")
    expect(data[:attributes]).to have_key(:forecast)
    expect(data[:attributes][:forecast]).to be_a(Hash)
    expect(data[:attributes][:forecast]).to have_key(:summary)
    expect(data[:attributes][:forecast][:summary]).to eq("Partly cloudy")
    expect(data[:attributes][:forecast]).to have_key(:temperature)
    expect(data[:attributes][:forecast][:temperature]).to eq("75 F")
    expect(data[:attributes]).to have_key(:total_books_found)

  end
end
