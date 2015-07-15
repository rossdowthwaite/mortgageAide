class ApplicationStatusesController < InheritedResources::Base
  
  before_action :set_status, only: [:show, :edit, :update, :destroy]
  before_action :set_application_case, only: [:new, :edit, :index]	

  # GET /roles/new
  def new 
    if !@application_case.is_brokered_by?(current_user)
      flash[:notice] = "You can't see this, Sorry";
      redirect_to(application_cases_path);
    else
      @status = ApplicationStatus.new
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

  # POST /roles
  # POST /roles.json
  def create
    @status = ApplicationStatus.new(application_status_params)

    respond_to do |format|
      if @status.save
        format.html { redirect_to @status.application_case, notice: 'Role was successfully created.' }
        format.json { render :show, status: :created, location: @application_case }
      else
        format.html { render :new }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    respond_to do |format|

      if @status.update(application_status_params)

      	@application_case = @status.application_case
      	@applicants = @application_case.applicants.not_current(current_user)

        # Loop applicants and send a mail
        @applicants.each do |applicant|
            ApplicationCaseMailer.status_change(applicant.user, @status.status.status, @application_case).deliver
        end

        format.html { redirect_to @status.application_case, notice: 'Role was successfully updated.' }
        format.json { render :show, status: :ok, location: @status.application_case }
      else
        format.html { render :edit }
        format.json { render json: @status.application_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
  	@application_case = @status.application_case
    @status.destroy
    respond_to do |format|
      format.html { redirect_to @application_case, notice: 'Role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private

    def set_status
      @status = ApplicationStatus.find(params[:id])
    end 
  	
  	def set_application_case 
  	  @application_case = ApplicationCase.find(params[:application_case_id])
  	end

    def application_status_params
      params.require(:application_status).permit(:application_case_id, :status_id)
    end
end

