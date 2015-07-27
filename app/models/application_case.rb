class ApplicationCase < ActiveRecord::Base

	belongs_to :lender
	
	has_many :notes, :dependent => :destroy
	
	# Only has one status but utilizes the :through helpers and extre table columns. 
	# Control methods ensure only one join table entry per case.
	has_many :application_statuses, :dependent => :destroy
	has_many :statuses, through: :application_statuses

	has_many :case_requirements, :dependent => :destroy
	has_many :requirements, through: :case_requirements
	
	# Users can be the broker, agent or client.
	has_many :applicants, :dependent => :destroy
  	has_many :users, :through => :applicants

  	belongs_to :broker, class_name: "User", foreign_key: "user_id"
  	
	has_one :mortgage_address, :dependent => :destroy
	
	accepts_nested_attributes_for :mortgage_address, allow_destroy: true
	accepts_nested_attributes_for :application_statuses, allow_destroy: true
	accepts_nested_attributes_for :notes, allow_destroy: true
	accepts_nested_attributes_for :case_requirements, allow_destroy: true
	accepts_nested_attributes_for :applicants, allow_destroy: true

	validates :mortgage, :presence => true,
            :numericality => true,
            :format => { :with => /\A\d{1,8}(\.\d{0,2})?\z/ } #currency

    scope :archived, -> { where(archived: true) }
    scope :active, -> (status) { where active: status }
    scope :current_status, -> (status) { joins(:statuses).where('status.id = ?', status) }

	after_create :set_status

	def has_applicants?
		self.applicants.count != 0;
	end

	def is_brokered_by? (user)
		self.users.map(&:id).include? user.id
	end

	private

	    def set_status
	      ApplicationStatus.create(:application_case_id => self.id, :status_id => 1 );
	    end
end
