require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    post :create, login: { email: users(:one).email }
    assert_redirected_to rides_path
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

end
