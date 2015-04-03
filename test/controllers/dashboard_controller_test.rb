require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  test 'passenger should get index' do
    session[:user_id]= users(:passenger_1).id
    session[:user_type]= users(:passenger_1).type
    session[:user_name]= users(:passenger_1).name
    get :index
    assert_response :success
  end

  test 'driver should get index' do
    session[:user_id]= users(:driver_1).id
    session[:user_type]= users(:driver_1).type
    session[:user_name]= users(:driver_1).name
    get :index
    assert_response :success
  end

end
