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
          render json: { error: 'Invalid quantity' }, status: 400
        end
      end

      private
        def book_params
          params.permit(:location, :quantity)
        end
    end
  end
end
