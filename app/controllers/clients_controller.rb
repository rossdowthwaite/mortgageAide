class ClientsController < InheritedResources::Base
  before_action :set_client, only: [:destroy]

  def index 
    @contacts = Contact.search(params[:search])

  	if current_user.is_broker?
      @clients = current_user.clients
    end
    
    if current_user.is_agent?
      @clients = current_user.clients

      # Set empty clients array. 
      @clients ||= []
      
      cases.each do |app_case|
        app_case.applicants.try(:each) do |applicant|
          unless @clients.include?(applicant.user)
            @clients << applicant.user
          end
        end
      end

    end

  end	

  def cases
  	@client = Client.find(params[:id])
  	@client = User.find(@client.client_id)
  	@cases = @client.application_cases.all
    
  end

    # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_path, notice: 'Contact Number was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private

    def set_client 
      @client = Client.find(params[:id])
    end

    def client_params
      params.require(:client).permit(:user_id, :client_id)
    end
end

