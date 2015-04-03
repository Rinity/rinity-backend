class DashboardController < ApplicationController
  before_action :get_user
  def index
  end
  private
  def get_user
    if session[:user_type] == 'Passenger'
      @user = Passenger.includes(:company, :ride_requests, :default_office).find(session[:user_id])
      @ride = RideRequest.new(user_id: @user.id, office: @user.default_office, time: Time.now.localtime)
      @rides = @user.ride_requests
    else
      @user = Driver.find(session[:user_id])
      @ride = RideOffer.new(user: @user, office: @user.default_office, time: Time.now.localtime)
      @rides = @user.ride_offers
    end
    @offices = @user.company.offices
  end
end
