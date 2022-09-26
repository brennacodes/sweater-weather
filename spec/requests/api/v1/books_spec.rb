require 'rails_helper'

RSpec.describe "Book search", type: :request, vcr: true do
  let!(:location) { "Denver,CO" }
  
  describe "GET /books" do
    it "retrieves books for a given location" do
      get books_index_path
      expect(response).to have_http_status(200)
    end
  end
end
