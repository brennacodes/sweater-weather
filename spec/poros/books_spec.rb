require 'rails_helper'

RSpec.describe Books, type: :poro, vcr: true do
  let!(:json) { File.read('spec/fixtures/book-search/retrieves_books_for_a_given_location_and_quantity_limit.json') }
  let!(:parsed) { JSON.parse(json, symbolize_names: true) }

  it "creates a ruby Books class object" do
    all_books = parsed[:docs]

    books = parsed.map do |book|
      book = Book.new(book)
    end

    poro = Books.new(books)
    expect(poro).to be_a(Books)
    expect(poro.books).to be_an(Array)
    expect(poro.books.first).to be_a(Book)
    expect(poro.id).to eq("null")
    expect(poro.destination).to eq("denver,co")
    expect(poro.forecast).to be_a(Hash)
    expect(poro.total_books_found).to eq(10)
    expect(poro.books).to be_an(Array)
    expect(poro.books.count).to eq(10)
  end
end
