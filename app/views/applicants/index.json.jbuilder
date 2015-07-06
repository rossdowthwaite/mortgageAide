json.array!(@applicants) do |applicant|
  json.extract! applicant, :id, :application_case_id, :contact_id
  json.url applicant_url(applicant, format: :json)
end
