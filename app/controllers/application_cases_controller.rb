class ApplicationCasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_application_case, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  # GET /application_cases
  # GET /application_cases.json
  def index
    @application_cases = current_user.application_cases.all

    filtering_params(params).each do |key, value|
      @application_cases = @application_cases.public_send(key, value) if value.present?
    end
  end

  def case_archive
    @application_cases = current_user.application_cases.archived
  end

  # GET /application_cases/1
  # GET /application_cases/1.json
  def show
    if @application_case.is_brokered_by?(current_user)
      @notes = @application_case.notes
      @requirements = @application_case.case_requirements
      @status = @application_case.status
      @m_address = @application_case.mortgage_address
      @applicants = @application_case.applicants
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

  # GET /application_cases/1/edit
  def edit_status
    @application_case = ApplicationCase.find(params[:application_case_id])
  end

  # POST /application_cases
  # POST /application_cases.json
  def create
    @application_case = ApplicationCase.new(application_case_params)
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
      params.slice(:status, :active)
    end

    def set_application_case
      @application_case = ApplicationCase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def application_case_params
      params.require(:application_case).permit(:valuation, :product, :expiry, :mortgage, :term, :repayment, :status, :lender_id, :app_type, :user_id, :archived, :active, :mortgage_address_id, mortgage_address_attributes: [ :address_one, :address_two, :town, :county, :pcode])
    end
end
