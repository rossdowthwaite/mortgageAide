class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :contact, :dependent => :destroy
  belongs_to :role

  has_many :application_cases

  has_many :applicants
  has_many :application_cases, :through => :applicants

  has_many :clients
  has_many :customers, :through => :clients, :source => 'customer'

  # scopes
  scope :clients, -> { where(role_id: '1') }
  scope :agents, -> { where(role_id: '3') }
  scope :brokers, -> { where(role_id: '2') }


  after_create :build_contact

  # check if Broker
  def is_broker?
    self.role.role == "Broker";
  end

  def has_contact_info?
     !!self.contact
  end

  # check if Agent
  def is_agent?
    self.role.role == "Agent";
  end

  # check if Client
  def is_client?
    self.role.role == "Client";
  end

  private
    # Sets default role
    def build_contact
      @contact = Contact.create(:user_id => self.id, :fname => "Sam", :lname => 'Doe' )
      self.update_attributes(:contact_id => @contact.id)
    end
end
