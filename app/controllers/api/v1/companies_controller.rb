class Api::V1::CompaniesController < Api::V1::BaseController
  def show

    company = Company.find(params[:id]) if params[:id]
    company = Company.find_by_domain(params[:domain]) if params[:domain]
    render json: company
  end
  def index
    companies = Company.all
    render json: companies
  end
end
