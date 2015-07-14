class ContactAddressesController < ApplicationController
  before_action :set_contact_address, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:new, :index, :show, :create, :edit, :update, :destroy]

  def index
    @contact_addresses = @user.contact_addresses.all
  end

  # GET /Contacts/1
  # GET /Contacts/1.json
  def show
  end

  # GET /Contacts/new
  def new
    @contact_address = ContactAddress.new
  end 

  # GET /Contacts/1/edit
  def edit
  end

  # POST /Contacts
  # POST /Contacts.json
  def create
    @contact_address = @user.contact_addresses.build(contact_address_params)

    respond_to do |format|
      if @contact_address.save
        format.html { redirect_to @user, notice: 'Address was successfully created.' }
        format.json { render :show, status: :created, location: @contact_address }
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
      if @contact_address.update(contact_address_params)
        format.html { redirect_to @contact_address.user, notice: 'Address was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact_address }
      else
        format.html { render :edit }
        format.json { render json: @contact_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @contact_address.destroy
    respond_to do |format|
      format.html { redirect_to @contact_address.user, notice: 'Address was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private

    def set_user
      @user = User.find(params[:user_id])
    end

  	def set_contact_address
  		@contact_address = ContactAddress.find(params[:id])
  	end

    def contact_address_params
      params.require(:contact_address).permit(:address_one, :address_two, :town, :post_code, :primary, :user_id)
    end
end

