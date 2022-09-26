require 'rails_helper'

RSpec.describe BookSerializer, type: :serializer do
  let!(:json) { File.read('spec/fixtures/book-search/retrieves_books_for_a_given_location_and_quantity_limit.json') }
  let!(:parsed) { JSON.parse(json, symbolize_names: true) }
  let!(:book) { Book.new(parsed[:docs].first) }
  let!(:serializer) { BookSerializer.new(book) }
  let!(:serialize) { ActiveModelSerializers::Adapter.create(serializer) }

  it 'serializes a book' do
    expect(serialize.to_json).to eq(
      {
        data: {
          id: "null",
          type: 'book',
          attributes: {
            isbn: book.isbn,
            title: book.title,
            publisher: book.publisher
          }
        }
      }.to_json
    )
  end
end
