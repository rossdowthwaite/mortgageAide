class ApplicationCase < ActiveRecord::Base

	belongs_to :user
	belongs_to :lender
	has_many :applicants
	has_many :applicant, through: :applicants
	has_many :notes
	has_many :case_requirements
	has_many :requirements, through: :case_requirements
	has_many :applicants
  	has_many :application_cases, through: :applicants
	has_one :mortgage_address
	accepts_nested_attributes_for :mortgage_address

	def has_applicants?
		self.applicants.count != 0;
	end

	def is_brokered_by? (user)
		self.user_id == user.id
	end
end
