class ApplicationCase < ActiveRecord::Base

	belongs_to :lender
	
	has_many :notes, :dependent => :destroy
	
	has_many :application_statuses, :dependent => :destroy
	has_many :statuses, through: :application_statuses

	has_many :case_requirements, :dependent => :destroy
	has_many :requirements, through: :case_requirements
	
	has_many :applicants, :dependent => :destroy
  	has_many :users, :through => :applicants

  	belongs_to :broker, class_name: "User", foreign_key: "user_id"
  	belongs_to :agent, class_name: "User", foreign_key: "agent_id"
  	
	has_one :mortgage_address, :dependent => :destroy
	accepts_nested_attributes_for :mortgage_address

	validates :mortgage, :presence => true,
            :numericality => true,
            :format => { :with => /\A\d{1,8}(\.\d{0,2})?\z/ }

    scope :archived, -> { where(archived: true) }
    scope :active, -> (status) { where active: status }
    scope :current_status, -> (status) { joins(:statuses).where('status.id = ?', status) }

	def has_applicants?
		self.applicants.count != 0;
	end

	def is_brokered_by? (user)
		self.users.map(&:id).include? user.id
	end
end
