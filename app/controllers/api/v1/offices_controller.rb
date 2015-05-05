module Api
  module V1
    # offices_controller.rb
    class OfficesController < Api::V1::BaseController
      def show
        office = Office.find(params[:id])
        render json: office
      end

      def index
        if session[:user_id]
          offices = User.find(session[:user_id]).company.offices
        else
          offices = Company.second.offices
        end
        render json: offices # , serializer: Api::V1::OfficeSerializer
      end
    end
  end
end
