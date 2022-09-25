module Api
  module V1
    class ForecastsController < ApplicationController 
      include Verifiable

      def show
        check_input(location_input)

        user_input = [ location_input, units_requested ].compact!
        forecast = ForecastFacade.weather(get_coords(user_input))

        render json: forecast
      end

      private
        def location_input
          params.permit(:location)
        end

        def units_requested
          params.permit(:units)
        end

        def get_coords(input)
          coordinates = MapQuestFacade.verify_location(input)
          [
            coordintes.body[:features][:properties][:lat], 
            coordinates.body[:features][:properties][:long]
          ]
        end
    end
  end
end