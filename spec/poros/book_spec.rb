require 'rails_helper'

RSpec.describe Book, type: :poro, vcr: true do
  let!(:json) { File.read('spec/fixtures/book.json') }
  let!(:parsed) { JSON.parse(json, symbolize_names: true) }
  
  it "creates a ruby Book class object" do
    book_hash = parsed[:docs].first
    book = Book.new(book_hash)
    expect(book).to be_a(Book)
    expect(book.isbn).to eq(parsed[:isbn])
    expect(book.title).to eq(parsed[:title])
    expect(book.publisher).to eq(parsed[:publisher])
  end
end
