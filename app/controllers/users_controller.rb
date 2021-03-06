class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /roles
  # GET /roles.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show

    @contact_addresses = @user.contact.contact_addresses
    @extra = @user.extra_detail
    @numbers = @user.contact.phone_numbers
    @agent = ClientAgent.agents(@user).first
    @global_setting = @user.global_setting

    if current_user != @user 
      if !current_user.is_broker_of?(@user) && @user.has_agent_and_is?(current_user)
        flash[:notice] = "You can't see this, Sorry";
        redirect_to(application_cases_path);
      end
    end

  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1
  # GET /users/1.json
  def clients_index
    @clients = User.clients
  end

  def search_users
    @users = User.search(params[:search])
    @clients = current_user.clients
  end

  def my_clients
    if current_user.is_broker?
      @clients = current_user.clients
    end
    if current_user.is_agent?
      @clients = current_user.clients
    end
  end
    # GET /users/1
  # GET /users/1.json
  def add_new_client
    @role = Role.where(:role => 'Client').pluck(:id);
    @user = User.new
  end

  def add_as_client
    current_user.clients << Client.create(:client_id => params[:client_id] )
    redirect_to(clients_path);
  end

  # GET /users/1
  # GET /users/1.json
  def agents_index
    @agents = User.agents
  end

  def add_new_agent
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.password = Devise.friendly_token.first(8)
    @password = @user.password
    respond_to do |format|
      if @user.save

        if current_user.is_broker?
          current_user.clients << Client.create(:user_id => current_user.id, :client_id => @user.id )
          
          # send password to user 
          ApplicationCaseMailer.new_user_and_password_notification(@user, current_user, @password).deliver
        else 

          ApplicationCaseMailer.new_user_and_password_notification(@user, current_user, @password).deliver
        end  
        format.html { redirect_to @user, notice: 'user was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'user was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :role_id)
    end
end

