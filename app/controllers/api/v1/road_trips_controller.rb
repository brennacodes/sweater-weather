module Api
  module V1
    class RoadTripsController < ApplicationController
      include Timable
      include Renderable

      def create
        user = User.find_by(api_key: roadtrip_params[:api_key])
        if user
          trip = RoadTripFacade.create_trip(roadtrip_params[:origin], roadtrip_params[:destination])
          roadtrip = create_road_trip(roadtrip_params[:origin], roadtrip_params[:destination], trip)

          render json: RoadTripSerializer.new(roadtrip)
        else
          json_response({ errors: "Invalid API key" }, :unauthorized)
        end
      end

      private
        def roadtrip_params
          params.permit(:origin, :destination, :api_key)
        end
    end
  end
end