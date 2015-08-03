class Client < ActiveRecord::Base
	belongs_to :user
	belongs_to :customer, :class_name => "User", :foreign_key => "client_id"

	scope :unique_client, -> (user) { where client_id: user.id }
	scope :where_client_is, -> (user) { where client_id: user.id  }

end
