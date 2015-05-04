require 'test_helper'

class OfficesControllerTest < ActionController::TestCase
  setup do
    @office = offices(:lyons)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:offices)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create office' do
    assert_difference('Office.count') do
      post :create, office: { address: @office.address, city: @office.city, company_id: @office.company_id, name: @office.name }
    end

    assert_redirected_to office_path(assigns(:office))
  end

  test 'should show office' do
    get :show, id: @office
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @office
    assert_response :success
  end

  test 'should update office' do
    patch :update, id: @office, office: { address: @office.address, company_id: @office.company_id, name: @office.name }
    assert_redirected_to office_path(assigns(:office))
  end

  test 'should destroy office' do
    assert_difference('Office.count', -1) do
      delete :destroy, id: @office
    end

    assert_redirected_to offices_path
  end
end
