module Api
  module V1
    class Api::V1::BooksController < ApplicationController
      def index
        location = book_params[:location]
        quantity = book_params[:quantity]
        books = BookFacade.new(location, quantity)
        render json: BookSerializer.new(books)
      end

      private
        def book_params
          params.permit(:location, :quantity)
        end
    end
  end
end
