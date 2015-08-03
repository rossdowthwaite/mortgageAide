class ExtraDetailsController < ApplicationController
  before_action :set_extra_detail, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:new, :index, :show, :create, :edit, :update, :destroy]

  def new
    extra_detail = ExtraDetail.new
  end

  def edit
  end

  # POST /Contacts
  # POST /Contacts.json
  def create
    @extra_detail = @user.build_extra_detail(extra_detail_params)

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
      if @extra_detail.update(extra_detail_params)
        format.html { redirect_to @extra_detail.user, notice: 'Detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @extra_detail }
      else
        format.html { render :edit }
        format.json { render json: @extra_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @extra_detail.destroy
    respond_to do |format|
      format.html { redirect_to @extra_detail.user, notice: 'Detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private

    def set_user
      @user = User.find(params[:user_id])
    end

  	def set_extra_detail
  		@extra_detail = ExtraDetail.find(params[:id])
  	end

    def extra_detail_params
      params.require(:extra_detail).permit(:branch, :user_id, :logo)
    end
end

