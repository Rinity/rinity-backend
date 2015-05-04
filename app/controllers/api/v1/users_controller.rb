module Api
  module V1
    # users_controller.rb
    class UsersController < Api::V1::BaseController
      before_action :authenticate_user!, only: [:index, :show, :create]

      def show
        user = @current_user
        render json: user, serializer: Api::V1::UserSerializer
      end

      def index
        @users = @current_user.company(includes: [:offices, :employees]).employees(includes: [:default_office])
        # users = User.includes(:company,:default_office).limit(30)
        render json: @users, each_serializer: Api::V1::UserSerializer
      end
    end
  end
end
