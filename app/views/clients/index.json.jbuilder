json.array!(@clients) do |client|
  json.extract! client, :id, :user_id, :client_id
  json.url client_url(client, format: :json)
end
