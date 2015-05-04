# dashboard_controller.rb
class DashboardController < ApplicationController
  before_action :get_user

  def index
    @rides = @user.rides.waiting.includes(:office)
    if session[:user_type] == 'Passenger'
      @ride = RideRequest.new(user_id: @user.id, office_id: @user.default_office_id, time: Time.zone.now.localtime)
    else
      @ride = RideOffer.new(user: @user, office_id: @user.default_office_id, time: Time.zone.now.localtime)
    end
    @offices = @user.company.offices
  end

  private

  def get_user
    #@user = User.includes(:rides).find(session[:user_id])
    @user = User.joins(:company).find(session[:user_id])
  end
end
