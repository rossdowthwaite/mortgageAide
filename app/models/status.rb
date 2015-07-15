class Status < ActiveRecord::Base

	has_many :application_statuses, :dependent => :destroy
	has_many :application_cases, through: :application_statuses

end
