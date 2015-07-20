class Applicant < ActiveRecord::Base
  belongs_to :application_case
  belongs_to :user

  scope :who_are_clients, -> { joins(user: :role).where('roles.role = ?', "Client") } 
  scope :who_are_agents, -> { joins(user: :role).where('roles.role = ?', "Agent") } 
  scope :not_current, -> (user) { where.not(:user => user) }
 
  def names  
  	self
  end

  def is_client?
    self.user.contact == "Client"
  end
end
