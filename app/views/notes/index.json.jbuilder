json.array!(@notes) do |note|
  json.extract! note, :id, :note, :application_case_id
  json.url note_url(note, format: :json)
end
