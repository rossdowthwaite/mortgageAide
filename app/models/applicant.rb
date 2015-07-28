class Applicant < ActiveRecord::Base
  belongs_to :application_case
  belongs_to :user

  scope :who_are_clients, -> { joins(user: :role).where('roles.role = ?', "Client") } 
  scope :who_are_agents, -> { joins(user: :role).where('roles.role = ?', "Agent") } 
  scope :not_current, -> (user) { where.not(:user => user) }

  scope :as_applicants, -> { where('as_role = ?', 'Applicant') }
  scope :as_agents, -> { where('as_role = ?', 'Agent') }
 
  def names  
  	self
  end

  def is_client?
    self.user.contact == "Client"
  end
end
