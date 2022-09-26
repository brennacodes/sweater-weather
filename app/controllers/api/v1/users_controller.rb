module Api
  module V1
    class UsersController < ApplicationController
      include Existable
      before_action :user_precheck, only: [:create]

      def create
        user = User.new(user_params)
        if user.save
          render json: UserSerializer.new(user), status: 201
        else
          render_something_wrong
        end
      end

      private
        def user_params
          params.permit(:email, :password, :password_confirmation)
        end
    end
  end
end