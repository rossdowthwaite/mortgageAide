class MailNotificationSettingsController < ApplicationController
  before_action :set_mail_setting, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:new, :index, :show, :create, :edit, :update, :destroy]

  def new
  	@mail_notification_setting = MailNotificationSetting.new
  end

  def edit
  end

  # POST /Contacts
  # POST /Contacts.json
  def create
    @extra_detail = @user.build_mail_notification_setting(mail_notification_setting_params)

    respond_to do |format|
      if @extra_detail.save
        format.html { redirect_to @user, notice: 'Detail was successfully created.' }
        format.json { render :show, status: :created, location: @contact_address }
      else
        format.html { render :new }
        format.json { render json: @extra_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    respond_to do |format|
      if @mail_notification_setting.update(mail_notification_setting_params)
        format.html { redirect_to @user, notice: 'Detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @extra_detail }
      else
        format.html { render :edit }
        format.json { render json: @mail_notification_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @mail_notification_setting.destroy
    respond_to do |format|
      format.html { redirect_to @mail_setting.user, notice: 'Detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private

    def set_user
      @user = User.find(params[:user_id])
    end
 
  	def set_mail_setting
  		@mail_notification_setting = MailNotificationSetting.find(params[:id])
  	end

    def mail_notification_setting_params
      params.require(:mail_notification_setting).permit(:notes, :all_emails, :daily_digest, :status_update, :user_id, :requirement_alerts)
    end
end

