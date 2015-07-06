class Requirement < ActiveRecord::Base
	has_many :application_cases
	has_many :case_requirements
	has_many :application_cases, through: :case_requirements
end
