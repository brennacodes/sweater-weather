module Api
  module V1
    class ForecastsController < ApplicationController 
      include Verifiable

      def index
        verify = check_input(location_params)

        coords = [
          verify.body[:features][:properties][:lat], 
          verify.body[:features][:properties][:long]
        ]

        forecast = ForecastFacade.weather(coords)

        render json: ForecastPoro.new(forecast)
      end

      private
        def location_params
          params.permit(:location)
        end  

        def unit_params
          params.permit(:units)
        end
    end
  end
end