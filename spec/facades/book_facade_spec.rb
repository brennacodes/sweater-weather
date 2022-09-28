require 'rails_helper'

RSpec.describe BookFacade, type: :facade, vcr: { :match_requests_on => [:uri] } do
  let(:location) { "Denver,CO" }
  let(:quantity) { 5 }

  describe "class methods" do
    describe "get_books" do
      it "returns a book object" do
        books = BookFacade.get_books(location, quantity)
        expect(books).to be_a(Books)
      end
    end

    describe "get_forecast" do
      it "returns a hash" do
        forecast = BookFacade.get_forecast(location)
        expect(forecast).to be_a(Hash)
      end
    end
  end
end
