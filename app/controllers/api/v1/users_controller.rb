module Api
  module V1
    class UsersController < ApplicationController
      def create
        user = User.new(user_params)
        if user.save
          render json: UserSerializer.new(user), status: 201
        else
          render json: { error: 'Email already exists' }, status: 409
        end
      end

      private
        def user_params
          params.permit(:email, :password, :password_confirmation)
        end
    end
  end
end