require 'test_helper'

class ClientAgentsControllerTest < ActionController::TestCase
  setup do
    @client_agent = client_agents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:client_agents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create client_agent" do
    assert_difference('ClientAgent.count') do
      post :create, client_agent: { agent: @client_agent.agent, client: @client_agent.client }
    end

    assert_redirected_to client_agent_path(assigns(:client_agent))
  end

  test "should show client_agent" do
    get :show, id: @client_agent
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @client_agent
    assert_response :success
  end

  test "should update client_agent" do
    patch :update, id: @client_agent, client_agent: { agent: @client_agent.agent, client: @client_agent.client }
    assert_redirected_to client_agent_path(assigns(:client_agent))
  end

  test "should destroy client_agent" do
    assert_difference('ClientAgent.count', -1) do
      delete :destroy, id: @client_agent
    end

    assert_redirected_to client_agents_path
  end
end
