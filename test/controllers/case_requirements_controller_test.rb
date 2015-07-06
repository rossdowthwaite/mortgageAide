require 'test_helper'

class CaseRequirementsControllerTest < ActionController::TestCase
  setup do
    @case_requirement = case_requirements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:case_requirements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create case_requirement" do
    assert_difference('CaseRequirement.count') do
      post :create, case_requirement: { application_case_id: @case_requirement.application_case_id, requirement_id: @case_requirement.requirement_id }
    end

    assert_redirected_to case_requirement_path(assigns(:case_requirement))
  end

  test "should show case_requirement" do
    get :show, id: @case_requirement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @case_requirement
    assert_response :success
  end

  test "should update case_requirement" do
    patch :update, id: @case_requirement, case_requirement: { application_case_id: @case_requirement.application_case_id, requirement_id: @case_requirement.requirement_id }
    assert_redirected_to case_requirement_path(assigns(:case_requirement))
  end

  test "should destroy case_requirement" do
    assert_difference('CaseRequirement.count', -1) do
      delete :destroy, id: @case_requirement
    end

    assert_redirected_to case_requirements_path
  end
end
