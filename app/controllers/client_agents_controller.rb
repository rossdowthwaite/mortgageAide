class ClientAgentsController < InheritedResources::Base
  before_action :set_client_agent, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:new, :edit]

  def index
  	@client_agents = ClientAgent.clients(current_user)
  end

  def new
  	@client_agent = ClientAgent.new
  end

  def edit
   	
  end

  # POST /Contacts
  # POST /Contacts.json
  def create
    @client_agent = ClientAgent.new(client_agent_params)

    respond_to do |format|
      if @client_agent.save

	    ApplicationCaseMailer.added_as_agent(@client_agent.agent, @client_agent.client).deliver

        format.html { redirect_to @client_agent.client, notice: 'Address was successfully created.' }
        format.json { render :show, status: :created, location: @contact_address }
      else
        format.html { render :new }
        format.json { render json: @client_agent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    respond_to do |format|
      if @client_agent.update(client_agent_params)
        format.html { redirect_to @client_agent.client, notice: 'Address was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact_address }
      else
        format.html { render :edit }
        format.json { render json: @client_agent.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @client_agent.destroy
    respond_to do |format|
      format.html { redirect_to @client_agent.client, notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  	def set_user
  		@user = User.find(params[:user_id])
  	end

  	def set_client_agent
  	  @client_agent = ClientAgent.find(params[:id])
  	end

    def client_agent_params
      params.require(:client_agent).permit(:agent_id, :client_id)
    end
end

