require 'test_helper'

class RidesControllerTest < ActionController::TestCase
  setup do
    @ride = rides(:request_1)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:rides)
  end

  test 'should get new' do
    session[:user_id] = users(:passenger_1).id
    session[:user_type] = users(:passenger_1).type
    get :new
    assert_response :success
  end

  test 'should create ride' do
    assert_difference('Ride.count') do
      post :create, ride: { direction:  @ride.direction,
                            freeSeats:  @ride.freeSeats,
                            fromAddress:@ride.fromAddress,
                            fromCity:   @ride.fromCity,
                            ride_id:    @ride.ride_id,
                            status:     @ride.status,
                            time:       @ride.time,
                            toAddress:  @ride.toAddress,
                            toCity:     @ride.toCity,
                            type:       @ride.type,
                            user_id:    @ride.user_id,
                            office_id:  @ride.office_id }, session: { user_id: users(:passenger_1).id, user_type: users(:passenger_1).type }
    end

    assert_redirected_to ride_path(assigns(:ride))
  end

  test 'should show ride' do
    get :show, id: @ride
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @ride
    assert_response :success
  end

  test 'should update ride' do
    patch :update, id: @ride, ride: { direction: @ride.direction, freeSeats: @ride.freeSeats, fromAddress: @ride.fromAddress, fromCity: @ride.fromCity, ride_id: @ride.ride_id, status: @ride.status, time: @ride.time, toAddress: @ride.toAddress, toCity: @ride.toCity, type: @ride.type, user_id: @ride.user_id, office_id: @ride.office_id }
    assert_redirected_to ride_path(assigns(:ride))
  end

  # Ride should not be destroyed
  test 'should not destroy ride' do
    assert_difference('Ride.count', 0) do
      delete :destroy, id: @ride
    end

    assert_redirected_to rides_path
  end
end
