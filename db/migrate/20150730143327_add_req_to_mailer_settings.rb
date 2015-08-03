class AddReqToMailerSettings < ActiveRecord::Migration
  def change
    add_column :mail_notification_settings, :requirement_alerts, :boolean
  end
end
