module Api
  module V1
    class BooksController < ApplicationController
      include Verifiable
      
      def index
        if check_quantity(params[:quantity])
          quantity = book_params[:quantity]
          topic = book_params[:location]
          books = BookFacade.get_books(topic, quantity)
          render json: BookSerializer.new(books)
        else
          json_response({ errors: "Invalid quantity" }, :bad_request)
        end
      end

      private
        def book_params
          params.permit(:location, :quantity)
        end
    end
  end
end
