require 'test_helper'

class MortgageAddressesControllerTest < ActionController::TestCase
  setup do
    @mortgage_address = mortgage_addresses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mortgage_addresses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mortgage_address" do
    assert_difference('MortgageAddress.count') do
      post :create, mortgage_address: { address_one: @mortgage_address.address_one, address_two: @mortgage_address.address_two, application_case_id: @mortgage_address.application_case_id, county: @mortgage_address.county, pcode: @mortgage_address.pcode, town: @mortgage_address.town }
    end

    assert_redirected_to mortgage_address_path(assigns(:mortgage_address))
  end

  test "should show mortgage_address" do
    get :show, id: @mortgage_address
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mortgage_address
    assert_response :success
  end

  test "should update mortgage_address" do
    patch :update, id: @mortgage_address, mortgage_address: { address_one: @mortgage_address.address_one, address_two: @mortgage_address.address_two, application_case_id: @mortgage_address.application_case_id, county: @mortgage_address.county, pcode: @mortgage_address.pcode, town: @mortgage_address.town }
    assert_redirected_to mortgage_address_path(assigns(:mortgage_address))
  end

  test "should destroy mortgage_address" do
    assert_difference('MortgageAddress.count', -1) do
      delete :destroy, id: @mortgage_address
    end

    assert_redirected_to mortgage_addresses_path
  end
end
