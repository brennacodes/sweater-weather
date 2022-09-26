module Api
  module V1
    class BooksController < ApplicationController
      def index
        quantity = book_params[:quantity]
        topic = book_params[:location]
        books = BookFacade.get_books(topic, quantity)
        render json: BookSerializer.new(books)
      end

      private
        def book_params
          params.permit(:location, :quantity)
        end
    end
  end
end
