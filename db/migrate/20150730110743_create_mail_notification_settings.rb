class CreateMailNotificationSettings < ActiveRecord::Migration
  def change
    create_table :mail_notification_settings do |t|
      t.boolean :notes
      t.boolean :all_emails
      t.boolean :daily_digest
      t.boolean :status_update
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
