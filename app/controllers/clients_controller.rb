class ClientsController < InheritedResources::Base

  private

    def client_params
      params.require(:client).permit(:user_id, :client_id)
    end
end

