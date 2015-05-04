require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  setup do
    @company = companies(:itsh)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:companies)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create company' do
    assert_difference('Company.count') do
      office = @company.offices.first
      response = post :create, company: { address: @company.address, domain: @company.domain + '_', name: @company.name, city: @company.city, offices_attributes: [{ name: office.name, address: office.address, city: @company.city }] }
      #head, status, body = *response
      #puts body.inspect
    end

    assert_redirected_to company_path(assigns(:company))
  end

  test 'should show company' do
    get :show, id: @company
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @company
    assert_response :success
  end

  test 'should update company' do
    patch :update, id: @company, company: { address: @company.address, domain: @company.domain, name: @company.name }
    assert_redirected_to company_path(assigns(:company))
  end

  test 'should destroy company' do
    assert_difference('Company.count', -1) do
      delete :destroy, id: @company
    end

    assert_redirected_to companies_path
  end
end
