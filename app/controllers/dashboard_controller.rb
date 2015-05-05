# dashboard_controller.rb
class DashboardController < ApplicationController
  before_action :current_user

  def index
    @rides = @user.rides.waiting.includes(:office)
    @ride = @user.rides.build(office_id: @user.default_office_id, time: Time.zone.now.localtime)
    @offices = @user.company.offices
  end

  private

  def current_user
    # @user = User.includes(:rides).find(session[:user_id])
    @user = User.joins(:company).find(session[:user_id])
  end
end
