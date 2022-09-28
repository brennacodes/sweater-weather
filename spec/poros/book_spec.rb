require 'rails_helper'

RSpec.describe Book, type: :poro do
  let!(:json) { File.read('spec/fixtures/book_fixture.json') }
  let!(:parsed) { JSON.parse(json, symbolize_names: true) }
  
  it "creates a ruby Book class object" do
    book_hash = parsed[:docs].first
    book = Book.new(book_hash)
    expect(book).to be_a(Book)
    expect(book.isbn).to eq(["0762507845", "9780762507849"])
    expect(book.title).to eq("Denver, Co")
    expect(book.publisher).to eq(["Universal Map Enterprises"])
  end
end
