require 'test_helper'

class MailNotificationSettingsControllerTest < ActionController::TestCase
  setup do
    @mail_notification_setting = mail_notification_settings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mail_notification_settings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mail_notification_setting" do
    assert_difference('MailNotificationSetting.count') do
      post :create, mail_notification_setting: { all_emails: @mail_notification_setting.all_emails, daily_digest: @mail_notification_setting.daily_digest, notes: @mail_notification_setting.notes, status_update: @mail_notification_setting.status_update, user_id: @mail_notification_setting.user_id }
    end

    assert_redirected_to mail_notification_setting_path(assigns(:mail_notification_setting))
  end

  test "should show mail_notification_setting" do
    get :show, id: @mail_notification_setting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mail_notification_setting
    assert_response :success
  end

  test "should update mail_notification_setting" do
    patch :update, id: @mail_notification_setting, mail_notification_setting: { all_emails: @mail_notification_setting.all_emails, daily_digest: @mail_notification_setting.daily_digest, notes: @mail_notification_setting.notes, status_update: @mail_notification_setting.status_update, user_id: @mail_notification_setting.user_id }
    assert_redirected_to mail_notification_setting_path(assigns(:mail_notification_setting))
  end

  test "should destroy mail_notification_setting" do
    assert_difference('MailNotificationSetting.count', -1) do
      delete :destroy, id: @mail_notification_setting
    end

    assert_redirected_to mail_notification_settings_path
  end
end
