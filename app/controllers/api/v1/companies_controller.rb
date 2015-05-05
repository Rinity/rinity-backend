module Api
  module V1
    # companies_controller.rb
    class CompaniesController < Api::V1::BaseController
      def show
        company = Company.find(params[:id]) if params[:id]
        company = Company.find_by_domain(params[:domain]) if params[:domain]
        render json: company
      end

      def index
        companies = Company.includes(:offices)
        render json: companies, each_serializer: Api::V1::CompanySerializer
      end
    end
  end
end
