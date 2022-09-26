module Api
  module V1
    class ForecastsController < ApplicationController 
      include Verifiable

      def show
        check_input(location_params[:location])

        user_input = [ location_params[:location], units_params[:units] ].compact!
        forecast = ForecastFacade.weather(get_coords(user_input))
        require 'pry'; binding.pry 

        render json: forecast
      end

      private
        def location_params
          params.permit(:location)
        end

        def units_params
          params.permit(:units)
        end

        def get_coords(input)
          coordinates = MapQuestFacade.verify_location(input[0])
          [
            coordinates[:results][0][:locations][0][:latLng][:lat], 
            coordinates[:results][0][:locations][0][:latLng][:lng]
          ]
        end
    end
  end
end