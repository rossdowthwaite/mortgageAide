class ApplicationCasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_application_case, only: [:show, :edit, :update, :destroy, :find_client]
  before_action :set_user

  # GET /application_cases
  # GET /application_cases.json
  def index
    # @application_cases = current_user.application_cases.all
    if params[:active].present?
      @application_cases = current_user.application_cases.where(nil) # creates an anonymous scope
      @application_cases = @application_cases.active_status(params[:active]) if params[:active].present?
    else 
      @application_cases = current_user.application_cases.active_status('Active')
    end

  end

  def case_archive
    @application_cases = current_user.application_cases.archived
  end

  # GET /application_cases/1
  # GET /application_cases/1.json
  def show
    if @application_case.has_user?(current_user)

      @notes = @application_case.notes
      @requirements = @application_case.case_requirements
      @status = @application_case.application_statuses
      @statuses = Status.all.sort_by(&:created_at)
      @m_address = @application_case.mortgage_address
      @applicants = @application_case.applicants.as_applicants
      @agent = @application_case.applicants.as_agents.first

      @agents ||= []
      @applicants.each do |applicant|
        @agents << ClientAgent.agents(applicant.user).first
      end

    else 
      flash[:notice] = "You are not authorized to view this";
      redirect_to(application_cases_path);
    end
  end

  # GET /application_cases/new
  def new
    @application_case = ApplicationCase.new
    @application_case.build_mortgage_address
  end

  # GET /application_cases/1/edit
  def edit
    if !@application_case.is_brokered_by?(current_user)
      flash[:notice] = "You can't edit this, Sorry";
      redirect_to(application_cases_path);
    end
  end

  def add_as_applicant
    @application_case = ApplicationCase.find(params[:application_case_id])
    @user = User.find(params[:applicant_id])
    @agent = @user.client_agent.agent

    @application_case.applicants << Applicant.create(:user_id => params[:applicant_id], :as_role => params[:as_role])
    @application_case.applicants << Applicant.create(:user_id => @agent.id, :as_role => 'Agent')

    ApplicationCaseMailer.notify_new_applicant(@user, current_user, @application_case).deliver
    ApplicationCaseMailer.notify_new_applicant(@agent, current_user, @application_case).deliver

    redirect_to(@application_case);
  end

  def find_client
    @contacts = Contact.search(params[:search])
  end

  # GET /application_cases/1/edit
  def edit_status
    @application_case = ApplicationCase.find(params[:application_case_id])
  end

  def search_agents
    @application_case = ApplicationCase.find(params[:application_case_id])
    @users = User.agents.search(params[:search])
  end

  def add_as_agent
    @application_case = ApplicationCase.find(params[:application_case_id])
    @agent = User.find(params[:agent_id])
    @application_case.applicants << Applicant.create(:user_id => params[:agent_id], :as_role => params[:as_role])

    respond_to do |format|
      if @application_case.save
          format.html { redirect_to @application_case, notice: 'Agent was successfully added.' }
          format.json { render :show, status: :created, location: @application_case }

          ApplicationCaseMailer.notify_new_agent(@agent, current_user, @application_case).deliver

      else
        format.html { render :new }
        format.json { render json: @application_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /application_cases
  # POST /application_cases.json
  def create
    @application_case = ApplicationCase.new(application_case_params)
    @application_case.active = 'Active'
    current_user.application_cases << @application_case

    respond_to do |format|
      if @application_case.save
        format.html { redirect_to @application_case, notice: 'Application case was successfully created.' }
        format.json { render :show, status: :created, location: @application_case }
      else
        format.html { render :new }
        format.json { render json: @application_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /application_cases/1
  # PATCH/PUT /application_cases/1.json
  def update
    respond_to do |format|
      if @application_case.update(application_case_params)
        format.html { redirect_to @application_case, notice: 'Application case was successfully updated.' }
        format.json { render :show, status: :ok, location: @application_case }
      else
        format.html { render :edit }
        format.json { render json: @application_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /application_cases/1
  # DELETE /application_cases/1.json
  def destroy
    @application_case.destroy
    respond_to do |format|
      format.html { redirect_to application_cases_url, notice: 'Application case was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    def filtering_params(params)
      params.slice(:current_status, :active)
    end

    def set_application_case
      @application_case = ApplicationCase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def application_case_params
      params.require(:application_case).permit(:valuation, :product, :expiry, :mortgage, :case_ref, :term, :repayment, :lifetime, :split_amount,  :status_id, :lender_id, :lender_ref, :app_type, :user_id, :archived, :active, :mortgage_address_id, mortgage_address_attributes: [ :address_one, :address_two, :town, :county, :pcode])
    end
end
