require 'test_helper'

class ApplicationStatusesControllerTest < ActionController::TestCase
  setup do
    @application_status = application_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:application_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create application_status" do
    assert_difference('ApplicationStatus.count') do
      post :create, application_status: { application_case_id: @application_status.application_case_id, status_id: @application_status.status_id }
    end

    assert_redirected_to application_status_path(assigns(:application_status))
  end

  test "should show application_status" do
    get :show, id: @application_status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @application_status
    assert_response :success
  end

  test "should update application_status" do
    patch :update, id: @application_status, application_status: { application_case_id: @application_status.application_case_id, status_id: @application_status.status_id }
    assert_redirected_to application_status_path(assigns(:application_status))
  end

  test "should destroy application_status" do
    assert_difference('ApplicationStatus.count', -1) do
      delete :destroy, id: @application_status
    end

    assert_redirected_to application_statuses_path
  end
end
