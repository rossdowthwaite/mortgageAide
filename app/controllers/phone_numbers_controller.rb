class PhoneNumbersController < ApplicationController
  before_action :set_number, only: [:edit, :update, :destroy]
  before_action :set_contact, only: [:new, :index, :create, :edit, :update]
  
  def index
    @phone_numbers = @contact.phone_numbers.all
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
    @phone_number = @contact.phone_numbers.build(phone_number_params)

    respond_to do |format|
      if @phone_number.save
        format.html { redirect_to @contact.user, notice: 'Contact Number was successfully created.' }
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
        format.html { redirect_to @phone_number.contact.user, notice: 'Contact Number was successfully updated.' }
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
      format.html { redirect_to @phone_number.contact.user, notice: 'Contact Number was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private

    def set_contact
      @contact = Contact.find(params[:contact_id])
    end

   	def set_number
  		@phone_number = PhoneNumber.find(params[:id])
  	end

    def phone_number_params
      params.require(:phone_number).permit(:phone_number, :phone_type, :user_id, :primary)
    end
end

