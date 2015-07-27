class ContactAddressesController < ApplicationController
  before_action :set_contact_address, only: [:show, :edit, :update, :destroy]
  before_action :set_contact, only: [:new, :index, :show, :create, :edit, :update]

  def index
    @contact_addresses = @contact.contact_addresses.all
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
    @contact_address = @contact.contact_addresses.build(contact_address_params)

    respond_to do |format|
      if @contact_address.save
        format.html { redirect_to @contact.user, notice: 'Address was successfully created.' }
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
        format.html { redirect_to @contact_address.contact.user, notice: 'Address was successfully updated.' }
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
      format.html { redirect_to @contact_address.contact.user, notice: 'Address was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private

    def set_contact
      @contact = Contact.find(params[:contact_id])
    end

  	def set_contact_address
  		@contact_address = ContactAddress.find(params[:id])
  	end

    def contact_address_params
      params.require(:contact_address).permit(:address_one, :address_two, :town, :county, :post_code, :primary, :user_id)
    end
end

