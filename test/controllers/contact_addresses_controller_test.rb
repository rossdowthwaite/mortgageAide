require 'test_helper'

class ContactAddressesControllerTest < ActionController::TestCase
  setup do
    @contact_address = contact_addresses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contact_addresses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contact_address" do
    assert_difference('ContactAddress.count') do
      post :create, contact_address: { address_one: @contact_address.address_one, address_two: @contact_address.address_two, post_code: @contact_address.post_code, primary: @contact_address.primary, town: @contact_address.town, user_id: @contact_address.user_id }
    end

    assert_redirected_to contact_address_path(assigns(:contact_address))
  end

  test "should show contact_address" do
    get :show, id: @contact_address
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contact_address
    assert_response :success
  end

  test "should update contact_address" do
    patch :update, id: @contact_address, contact_address: { address_one: @contact_address.address_one, address_two: @contact_address.address_two, post_code: @contact_address.post_code, primary: @contact_address.primary, town: @contact_address.town, user_id: @contact_address.user_id }
    assert_redirected_to contact_address_path(assigns(:contact_address))
  end

  test "should destroy contact_address" do
    assert_difference('ContactAddress.count', -1) do
      delete :destroy, id: @contact_address
    end

    assert_redirected_to contact_addresses_path
  end
end
