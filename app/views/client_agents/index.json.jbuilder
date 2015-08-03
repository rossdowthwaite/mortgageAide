json.array!(@client_agents) do |client_agent|
  json.extract! client_agent, :id, :agent, :client
  json.url client_agent_url(client_agent, format: :json)
end
