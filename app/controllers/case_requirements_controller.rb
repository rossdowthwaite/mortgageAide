class CaseRequirementsController < ApplicationController

before_action :set_case_requirement, only: [:show, :edit, :update, :destroy]
before_action :set_application_case, only: [:new, :edit]

  # GET /roles/new
  def new 
    if !@application_case.is_brokered_by?(current_user)
      flash[:notice] = "You can't see this, Sorry";
      redirect_to(application_cases_path);
    else
      @case_req = CaseRequirement.new
    end
  end

  # GET /roles/1/edit
  def edit
    if !@application_case.is_brokered_by?(current_user)
      flash[:notice] = "You can't see this, Sorry";
      redirect_to(application_cases_path);
    else
  	   @application_case = ApplicationCase.find(params[:application_case_id])
    end
  end



  def send_email_requirements_notification

      @application_case = ApplicationCase.find(params[:application_case_id])
      @applicants = @application_case.applicants.not_current(current_user)

      @requirements = CaseRequirement.find(params[:requirements])

      @applicants.each do |applicant|
        if applicant.is_client?

          if !applicant.user.mail_notification_setting.nil? && !applicant.user.has_opted_out_of?(:requirement_alerts)
            ApplicationCaseMailer.new_requirements_added(applicant.user, @requirements, current_user, @application_case).deliver
          end
        end
      end

      redirect_to @application_case

  end

  # POST /roles
  # POST /roles.json
  def create
    @case_req = CaseRequirement.new(case_requirement_params)

    respond_to do |format|
      if @case_req.save

        @application_case = @case_req.application_case
        @applicants = @application_case.applicants.not_current(current_user)

        format.html { redirect_to @case_req.application_case, notice: 'Role was successfully created.' }
        format.json { render :show, status: :created, location: @application_case }
      else
        format.html { render :new }
        format.json { render json: @case_req.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    respond_to do |format|
      if @case_req.update(case_requirement_params)

        @application_case = @case_req.application_case
        @applicants = @application_case.applicants.not_current(current_user)

        # Loop applicants and send a mail
        @applicants.each do |applicant|
           ApplicationCaseMailer.requirement_update(applicant.user, @case_req, current_user, @application_case).deliver
        end

        format.html { redirect_to @case_req.application_case, notice: 'Role was successfully updated.' }
        format.json { render :show, status: :ok, location: @case_req }
      else
        format.html { render :edit }
        format.json { render json: @rcase_reqole.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
  	@application_case = @case_req.application_case
    @case_req.destroy
    respond_to do |format|
      format.html { redirect_to @application_case, notice: 'Role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_case_requirement
      @case_req = CaseRequirement.find(params[:id])
    end

    def set_application_case
      @application_case = ApplicationCase.find(params[:application_case_id])
    end

    def case_requirement_params
      params.require(:case_requirement).permit(:application_case_id, :requirement_id, :status, :date_requested, :free_requirement, :date_satisfied)
    end
end

