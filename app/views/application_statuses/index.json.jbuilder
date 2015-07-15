json.array!(@application_statuses) do |application_status|
  json.extract! application_status, :id, :application_case_id, :status_id
  json.url application_status_url(application_status, format: :json)
end
