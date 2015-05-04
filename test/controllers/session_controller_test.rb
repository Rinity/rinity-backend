require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should get create' do
    post :create, login: { email: users(:passenger_1).email }
    assert_redirected_to dashboard_index_path
  end

  test 'should get destroy' do
    get :destroy
    assert_response :success
  end

end
