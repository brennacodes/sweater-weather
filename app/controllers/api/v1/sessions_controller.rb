module Api
  module V1
    class SessionsController < ApplicationController
      include Renderable
      
      def create
        @user = User.find_by(email: user_params[:email])
        if @user && @user.authenticate(user_params[:password])
          render json: UserSerializer.new(@user), status: 200
        else
          json_response({ "error": "Invalid credentials" }, :unauthorized)
        end
      end

      private
        def user_params
          params.permit(:email, :password, :password_confirmation)
        end
    end
  end
end