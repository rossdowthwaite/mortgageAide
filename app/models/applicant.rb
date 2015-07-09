class Applicant < ActiveRecord::Base
  belongs_to :application_case
  belongs_to :user

  scope :who_are_clients, -> { joins(user: :role).where('roles.role = ?', "Client") } 
 
  def names  
  	self
  end
end
