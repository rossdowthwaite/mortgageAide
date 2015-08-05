json.array!(@global_settings) do |global_setting|
  json.extract! global_setting, :id, :user_id, :color_one, :color_two, :color_three
  json.url global_setting_url(global_setting, format: :json)
end
