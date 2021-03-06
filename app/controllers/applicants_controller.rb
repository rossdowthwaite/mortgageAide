class ApplicantsController < ApplicationController
  before_action :set_applicant, only: [:show, :edit, :update, :destroy]
  before_action :set_application, only: [:new, :create]

  # GET /applicants/new
  def new
    if !@application_case.is_brokered_by?(current_user)
      flash[:notice] = "You can't see this, Sorry";
      redirect_to(application_cases_path);
    else
      @applicant = Applicant.new
      @application_case = ApplicationCase.find(params[:application_case_id])
    end
  end

  # POST /applicants
  # POST /applicants.json
  def create
    @applicant = Applicant.new(applicant_params)

    respond_to do |format|
      if @applicant.save
        format.html { redirect_to @application_case, notice: 'Applicant was successfully created.' }
        format.json { render :show, status: :created, location: @applicant }
      else
        format.html { render :new }
        format.json { render json: @applicant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /applicants/1
  # PATCH/PUT /applicants/1.json
  def update
    respond_to do |format|
      if @applicant.update(applicant_params)
        format.html { redirect_to @applicant, notice: 'Applicant was successfully updated.' }
        format.json { render :show, status: :ok, location: @applicant }
      else
        format.html { render :edit }
        format.json { render json: @applicant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applicants/1
  # DELETE /applicants/1.json
  def destroy
    @application_case = @applicant.application_case
    @user_applicant = @applicant

    @user = @user_applicant.user
    @agent = @user.client_agent.agent

    ApplicationCaseMailer.notify_removed_agent(@agent, current_user, @application_case).deliver
    ApplicationCaseMailer.notify_removed_applicant(@user_applicant.user, current_user, @application_case).deliver

    @applicant.destroy
    respond_to do |format|

      format.html { redirect_to @application_case, notice: 'Applicant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_applicant
      @applicant = Applicant.find(params[:id])
    end

    def set_application
      @application_case = ApplicationCase.find(params[:application_case_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def applicant_params
      params.require(:applicant).permit(:application_case_id, :user_id, :as_role)
    end
end
