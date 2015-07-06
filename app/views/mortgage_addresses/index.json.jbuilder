json.array!(@mortgage_addresses) do |mortgage_address|
  json.extract! mortgage_address, :id, :address_one, :address_two, :town, :county, :pcode, :application_case_id
  json.url mortgage_address_url(mortgage_address, format: :json)
end
