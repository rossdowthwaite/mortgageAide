require 'test_helper'

class ExtraDetailsControllerTest < ActionController::TestCase
  setup do
    @extra_detail = extra_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:extra_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create extra_detail" do
    assert_difference('ExtraDetail.count') do
      post :create, extra_detail: { branch: @extra_detail.branch, user_id: @extra_detail.user_id }
    end

    assert_redirected_to extra_detail_path(assigns(:extra_detail))
  end

  test "should show extra_detail" do
    get :show, id: @extra_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @extra_detail
    assert_response :success
  end

  test "should update extra_detail" do
    patch :update, id: @extra_detail, extra_detail: { branch: @extra_detail.branch, user_id: @extra_detail.user_id }
    assert_redirected_to extra_detail_path(assigns(:extra_detail))
  end

  test "should destroy extra_detail" do
    assert_difference('ExtraDetail.count', -1) do
      delete :destroy, id: @extra_detail
    end

    assert_redirected_to extra_details_path
  end
end
