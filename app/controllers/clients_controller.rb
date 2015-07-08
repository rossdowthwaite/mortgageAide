class ClientsController < InheritedResources::Base

  def index 
  	 @clients = current_user.clients
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

