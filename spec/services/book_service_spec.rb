require 'rails_helper'

RSpec.describe BookService, type: :service, vcr: { :match_requests_on => [:uri] } do
  it "retrieves books for a given location and quantity limit" do
    location = "denver,co"
    qty = 10
    response = BookService.search_books(location, qty)
    expect(response).to_not be_nil
    expect(response).to be_a(Hash)
    expect(response[:docs]).to be_an(Array)
    expect(response[:docs].count).to eq(10)
    expect(response[:numFound]).to eq(47111)
  end
end
