# offices_controller.rb
class Api::V1::OfficesController < Api::V1::BaseController
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
