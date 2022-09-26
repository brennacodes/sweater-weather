module Api
  module V1
    class ForecastsController < ApplicationController 
      include Verifiable

      def show
        check = check_input(location_params[:location])

        process_location if check == true
      end

      private
        def location_params
          params.permit(:location)
        end

        def units_params
          params.permit(:units)
        end

        def get_coords(input)
          coordinates = MapQuestFacade.verify_location(input)
          [
            coordinates[:results][0][:locations][0][:latLng][:lat], 
            coordinates[:results][0][:locations][0][:latLng][:lng]
          ]
        end

        def process_location
          units = check_unit_params(units_params[:units])
          user_input = [ location_params[:location], units ]
          forecast = ForecastFacade.weather(get_coords(location_params), units)

          render json: ForecastSerializer.new(forecast) if forecast != nil
          render json: { error: 'Could not process your request at this time.' }, status: 400  if forecast == nil
        end
    end
  end
end