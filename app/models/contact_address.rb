class ContactAddress < ActiveRecord::Base
  belongs_to :contact

  scope :primary, -> { where(primary: true) }
end
