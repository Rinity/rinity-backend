# rides_controller.rb
class Api::V1::RidesController < Api::V1::BaseController
  before_action :authenticate_user!, only: [:index, :create, :destroy]
  before_action :set_ride, only: [:show, :edit, :update, :destroy]

  def index
    @rides = @current_user.rides.includes(:office)
    #    puts Api::V1::RideSerializer.new(@rides.first).to_json
    render json: @rides, each_serializer: Api::V1::RideSerializer
  end

  def create
    params_hash = ride_params.to_hash
    params_hash[:type] = @current_user.type == 'Driver' ? 'RideOffer' : 'RideRequest'

    @ride = @current_user.rides.build(params_hash)
    if @ride.save
      render json: @ride, serializer: Api::V1::RideSerializer
    else
      logger.error @ride.errors.full_messages
      render json: { head: 'error' }
    end
  end

  def destroy
    logger.info "Would delete ride: #{@ride.id}"
    render json: @ride, serializer: Api::V1::RideSerializer
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ride
    @ride = Ride.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def ride_params
    # TODO: from the API we should only get :direction, :time, :office_id[,
    # :freeSeats (in case of offer)]
    # params.require(:ride).permit(:direction, :time, :type, :freeSeats, :fromAddress, :toAddress, :fromCity, :toCity, :user_id, :status, :ride_id, :office_id)
    params.require(:ride).permit(:direction, :time, :freeSeats, :office_id)
  end
end
