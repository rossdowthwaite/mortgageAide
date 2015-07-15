class PhoneNumber < ActiveRecord::Base
  belongs_to :user

  scope :primary, -> { where(primary: true) }

  def is_primary?
  	self.primary == true
  end
end
