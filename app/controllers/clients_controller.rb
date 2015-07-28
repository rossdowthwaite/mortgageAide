class ClientsController < InheritedResources::Base

  def index 

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

  private

    def client_params
      params.require(:client).permit(:user_id, :client_id)
    end
end

