class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @application_case = ApplicationCase.find(params[:application_case_id])
    @note = @application_case.notes.create(note_params)
    @applicants = @application_case.applicants.not_current(current_user)

    respond_to do |format|
      if @note.save

        # Loop applicants and send a mail
        @applicants.each do |applicant|
          # ApplicationCaseMailer.new_note_notification(applicant.user, @note.note, current_user, @application_case).deliver
        end

        format.html { redirect_to @application_case, notice: 'Note was successfully created.' }
        format.json { render :show, status: :created, location: @application_case }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def send_email_notification

      @application_case = ApplicationCase.find(params[:application_case_id])
      @applicants = @application_case.applicants.not_current(current_user)

      @notes = Note.find(params[:notes])

      @applicants.each do |applicant|
        if !applicant.user.mail_notification_setting.nil? && !applicant.user.has_opted_out_of?(:notes)
          ApplicationCaseMailer.multiple_note_notification(applicant.user, @notes, current_user, @application_case).deliver
        end
      end

      redirect_to @application_case

  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note.application_case, notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @application_case = ApplicationCase.find(params[:application_case_id])
    @note = @application_case.notes.find(params[:id])
    @note.destroy
    respond_to do |format|
      format.html { redirect_to @application_case, notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:note, :user_id, :application_case_id)
    end
end
