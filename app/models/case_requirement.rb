class CaseRequirement < ActiveRecord::Base
  belongs_to :application_case
  belongs_to :requirement

  scope :complete, -> { where(requirement_id: '1') }

  before_update :update_date_satisfied

  def update_date_satisfied
    self.date_satisfied = Date.today if self.status_changed? && self.status != 'pending'
  end

  # Set the icon
  def is_complete
  	if self.status == 'pending'
  		return 'clock-o'
  	else 
  		return 'check-circle-o'
  	end
  end
end
