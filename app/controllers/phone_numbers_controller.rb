class PhoneNumbersController < ApplicationController
  before_action :set_number, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:new, :index, :show, :create, :edit, :update, :destroy]
  
  def index
    @phone_numbers = @user.phone_numbers.all
  end

  # GET /Contacts/1
  # GET /Contacts/1.json
  def show
  end

  # GET /Contacts/new
  def new
    @phone_number = PhoneNumber.new
  end 

  # GET /Contacts/1/edit
  def edit
  end

  # POST /Contacts
  # POST /Contacts.json
  def create
    @phone_number = @user.phone_numbers.build(phone_number_params)

    respond_to do |format|
      if @phone_number.save
        format.html { redirect_to @user, notice: 'Contact Number was successfully created.' }
        format.json { render :show, status: :created, location: [@user, @phone_number] }
      else
        format.html { render :new }
        format.json { render json: @contact_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    respond_to do |format|
      if @phone_number.update(phone_number_params)
        format.html { redirect_to @phone_number.user, notice: 'Contact Number was successfully updated.' }
        format.json { render :show, status: :ok, location: @phone_number }
      else
        format.html { render :edit }
        format.json { render json: @contact_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @phone_number.destroy
    respond_to do |format|
      format.html { redirect_to @phone_number.user, notice: 'Contact Number was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private

    def set_user
      @user = User.find(params[:user_id])
    end

   	def set_number
  		@phone_number = PhoneNumber.find(params[:id])
  	end

    def phone_number_params
      params.require(:phone_number).permit(:phone_number, :phone_type, :user_id)
    end
end

