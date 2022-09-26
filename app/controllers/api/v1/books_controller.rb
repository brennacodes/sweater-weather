module Api
  module V1
    class Api::V1::BooksController < ApplicationController
      def index
        coords = MapQuestFacade.get_coords(book_params[:location])
        quantity = book_params[:quantity]
        topic = book_params[:location]
        forecast = ForecastFacade.weather(coords, 'imperial')[:current]
        books = BookFacade.new(topic, quantity)
        render json: BookSerializer.new(books, forecast)
      end

      private
        def book_params
          params.permit(:location, :quantity)
        end
    end
  end
end
