class MortgageAddressesController < ApplicationController
  before_action :set_mortgage_address, only: [:show, :edit, :update, :destroy]

  # POST /mortgage_addresses
  # POST /mortgage_addresses.json
  def create
    @mortgage_address = MortgageAddress.new(mortgage_address_params)

    respond_to do |format|
      if @mortgage_address.save
        format.html { redirect_to @mortgage_address, notice: 'Mortgage address was successfully created.' }
        format.json { render :show, status: :created, location: @mortgage_address }
      else
        format.html { render :new }
        format.json { render json: @mortgage_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mortgage_addresses/1
  # PATCH/PUT /mortgage_addresses/1.json
  def update
    respond_to do |format|
      if @mortgage_address.update(mortgage_address_params)
        format.html { redirect_to @mortgage_address, notice: 'Mortgage address was successfully updated.' }
        format.json { render :show, status: :ok, location: @mortgage_address }
      else
        format.html { render :edit }
        format.json { render json: @mortgage_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mortgage_addresses/1
  # DELETE /mortgage_addresses/1.json
  def destroy
    @mortgage_address.destroy
    respond_to do |format|
      format.html { redirect_to mortgage_addresses_url, notice: 'Mortgage address was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mortgage_address
      @mortgage_address = MortgageAddress.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mortgage_address_params
      params.require(:mortgage_address).permit(:address_one, :address_two, :town, :county, :pcode, :application_case_id)
    end
end
