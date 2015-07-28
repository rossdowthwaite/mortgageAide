class StaticsController < ApplicationController
  before_action :set_static, only: [:show, :edit, :update, :destroy]

  # GET /statics
  # GET /statics.json
  def index
  	@application_cases = current_user.application_cases.active_status('Active')
  end

end
