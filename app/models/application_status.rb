class ApplicationStatus < ActiveRecord::Base
  belongs_to :application_case
  belongs_to :status

  after_update :update_application_case_active_status

  def update_application_case_active_status
  	@application_case = self.application_case

	case self.status.status
	when "Complete" 
	  @active = 'Archive'
	when 'Offer' 
	  @active = 'Offered & Awaiting completion'
	when 'Exchanged' 
	  @active = 'Offered & Awaiting completion'
	else
	  @active = 'Active'
	end

  	@application_case.update_attribute(:active, @active)
  end

end
