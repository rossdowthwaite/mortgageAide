json.array!(@contacts) do |contact|
  json.extract! contact, :id, :fname, :mname, :lname, :title, :dob, :user_id, :role_id
  json.url contact_url(contact, format: :json)
end
