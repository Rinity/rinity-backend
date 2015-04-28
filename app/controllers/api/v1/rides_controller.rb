class Api::V1::RidesController < Api::V1::BaseController
  before_filter :authenticate_user!, only: [:index]
  def index
    rides = current_user.rides
    render json: rides
  end
end
