class GlobalSettingsController < InheritedResources::Base
  before_action :set_user, only: [:new, :index, :show, :create, :edit, :update, :destroy]
  before_action :set_global, only: [:show, :edit, :update, :destroy]

  def new
  	@global_setting = GlobalSetting.new
  end

  def edit
  	# 
  end

  def create
  	@global_setting = @user.build_global_setting(global_setting_params)

    respond_to do |format|
      if @global_setting.save
        format.html { redirect_to @user, notice: 'Global setting was successfully created.' }
        format.json { render :show, status: :created, location: @application_case }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  	respond_to do |format|
      if @global_setting.update(global_setting_params)
        format.html { redirect_to @global_setting.user, notice: 'Detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @global_setting }
      else
        format.html { render :edit }
        format.json { render json: @global_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  	@global_setting.destroy
    respond_to do |format|
      format.html { redirect_to @user, notice: 'Global setting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private

    def set_global
      @global_setting = GlobalSetting.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def global_setting_params
      params.require(:global_setting).permit(:user_id, :color_one, :color_two, :color_three)
    end
end

