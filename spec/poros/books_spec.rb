require 'rails_helper'

RSpec.describe Books, type: :poro do
  let!(:books_json) { File.read('spec/fixtures/books_fixture.json') }
  let!(:parsed) { JSON.parse(books_json, symbolize_names: true) }
  let!(:forecast) { { summary: "Partly cloudy", temperature: "75 F" } }

  it "creates a ruby Books class object" do
    all_books = parsed[:docs]

    books = all_books.map do |book|
      Book.new(book)
    end

    poro = Books.new({
      books: books, 
      location: "Denver,CO",
      forecast: forecast,
      total_books_found: parsed[:numFound]
    })
    expect(poro).to be_a(Books)
    expect(poro.books).to be_an(Array)
    expect(poro.books.first).to be_a(Book)
    expect(poro.id).to eq("null")
    expect(poro.destination).to eq("Denver,CO")
    expect(poro.forecast).to be_a(Hash)
    expect(poro.total_books_found).to eq(47113)
    expect(poro.books).to be_an(Array)
    expect(poro.books.count).to eq(5)
  end
end
