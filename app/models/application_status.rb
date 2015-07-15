class ApplicationStatus < ActiveRecord::Base
  belongs_to :application_case
  belongs_to :status
end
