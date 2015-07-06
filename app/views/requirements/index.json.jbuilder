json.array!(@requirements) do |requirement|
  json.extract! requirement, :id, :requirment, :date_needed
  json.url requirement_url(requirement, format: :json)
end
