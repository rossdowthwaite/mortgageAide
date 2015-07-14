json.array!(@contact_addresses) do |contact_address|
  json.extract! contact_address, :id, :address_one, :address_two, :town, :post_code, :primary, :user_id
  json.url contact_address_url(contact_address, format: :json)
end
