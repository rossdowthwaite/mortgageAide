class CaseRequirement < ActiveRecord::Base
  belongs_to :application_case
  belongs_to :requirement

  scope :complete, -> { where(requirement_id: '1') }

  # Set the icon
  def is_complete
  	if self.status == 'pending'
  		return 'clock-o'
  	else 
  		return 'check-circle-o'
  	end
  end
end
