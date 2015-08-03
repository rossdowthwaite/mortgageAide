json.array!(@mail_notification_settings) do |mail_notification_setting|
  json.extract! mail_notification_setting, :id, :notes, :all_emails, :daily_digest, :status_update, :user_id
  json.url mail_notification_setting_url(mail_notification_setting, format: :json)
end
