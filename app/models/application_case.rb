class ApplicationCase < ActiveRecord::Base

	belongs_to :lender
	
	has_many :notes, :dependent => :destroy
	
	has_many :case_requirements, :dependent => :destroy
	has_many :requirements, through: :case_requirements
	
	has_many :applicants, :dependent => :destroy
  	has_many :users, :through => :applicants

  	belongs_to :broker, class_name: "User", foreign_key: "user_id"
  	
	has_one :mortgage_address, :dependent => :destroy
	accepts_nested_attributes_for :mortgage_address

	def has_applicants?
		self.applicants.count != 0;
	end

	def is_brokered_by? (user)
		self.users.map(&:id).include? user.id
	end
end
