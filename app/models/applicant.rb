class Applicant < ActiveRecord::Base
  belongs_to :application_case
  belongs_to :user
end
