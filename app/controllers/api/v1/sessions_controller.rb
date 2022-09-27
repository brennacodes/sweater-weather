module Api
  module V1
    class SessionsController < ApplicationController
      def new
        @user = User.find_by(username: params[:username]) || User.new
        session[:user] = @user
      end
    
      def create
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          render json: UserSerializer.new(@user), status: 200
        else
          render json: { "error": "Invalid credentials" }, status: 401
        end
      end
    
      def destroy
        session.clear
        redirect_to root_path
      end

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

        def current_user
          User.find(session[:user_id]) if session[:user_id]
        end
    end
  end
end