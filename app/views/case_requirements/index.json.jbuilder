json.array!(@case_requirements) do |case_requirement|
  json.extract! case_requirement, :id, :application_case_id, :requirement_id
  json.url case_requirement_url(case_requirement, format: :json)
end
