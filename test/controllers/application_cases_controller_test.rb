require 'test_helper'

class ApplicationCasesControllerTest < ActionController::TestCase
  setup do
    @application_case = application_cases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:application_cases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create application_case" do
    assert_difference('ApplicationCase.count') do
      post :create, application_case: { expiry: @application_case.expiry, mortgage: @application_case.mortgage, product: @application_case.product, repayment: @application_case.repayment, status: @application_case.status, term: @application_case.term, valuation: @application_case.valuation }
    end

    assert_redirected_to application_case_path(assigns(:application_case))
  end

  test "should show application_case" do
    get :show, id: @application_case
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @application_case
    assert_response :success
  end

  test "should update application_case" do
    patch :update, id: @application_case, application_case: { expiry: @application_case.expiry, mortgage: @application_case.mortgage, product: @application_case.product, repayment: @application_case.repayment, status: @application_case.status, term: @application_case.term, valuation: @application_case.valuation }
    assert_redirected_to application_case_path(assigns(:application_case))
  end

  test "should destroy application_case" do
    assert_difference('ApplicationCase.count', -1) do
      delete :destroy, id: @application_case
    end

    assert_redirected_to application_cases_path
  end
end
