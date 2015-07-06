json.array!(@application_cases) do |application_case|
  json.extract! application_case, :id, :valuation, :product, :expiry, :mortgage, :term, :repayment, :status
  json.url application_case_url(application_case, format: :json)
end
