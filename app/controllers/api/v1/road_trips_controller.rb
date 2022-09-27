module Api
  module V1
    class RoadTripsController < ApplicationController
      def create
        user = User.find_by(api_key: params[:api_key])
        if user
          roadtrip = RoadTripFacade.create_trip(params[:origin], params[:destination])
          render json: RoadTripSerializer.new(roadtrip)
        else
          render json: { error: 'Invalid API key' }, status: 401
        end
      end

      private
        def roadtrip_params
          params.permit(:origin, :destination, :api_key)
        end
    end
  end
end