class CaseRequirementsController < ApplicationController

before_action :set_case_requirement, only: [:show, :edit, :update, :destroy]

  # GET /roles
  # GET /roles.json
  def index
    @case_reqs = CaseRequirement.all
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
  end

  # GET /roles/new
  def new
  	@application_case = ApplicationCase.find(params[:application_case_id])
    @case_req = CaseRequirement.new
  end

  # GET /roles/1/edit
  def edit
  	@application_case = ApplicationCase.find(params[:application_case_id])
  end

  # POST /roles
  # POST /roles.json
  def create
    @case_req = CaseRequirement.new(case_requirement_params)

    respond_to do |format|
      if @case_req.save
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

    def case_requirement_params
      params.require(:case_requirement).permit(:application_case_id, :requirement_id, :status, :date_requested, :free_requirement)
    end
end

