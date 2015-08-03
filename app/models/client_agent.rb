class ClientAgent < ActiveRecord::Base
	belongs_to :client, :class_name => "User", :foreign_key => "client_id"
	belongs_to :agent, :class_name => "User", :foreign_key => "agent_id"

	scope :agents, -> (user) { where client_id: user.id }
	scope :clients, -> (user) { where agent_id: user.id }

end
