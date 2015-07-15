class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :contact
  belongs_to :role

  has_many :notes

  has_many :contact_addresses
  has_many :phone_numbers
  has_one  :extra_detail

  has_many :brokered_cases, foreign_key: "user_id", class_name: "ApplicationCase"

  has_many :application_cases

  has_many :applicants
  has_many :application_cases, :through => :applicants

  has_many :clients
  has_many :customers, :through => :clients, :source => 'customer'

  # scopes
  scope :clients, -> { joins(:role).where('roles.role = ?', 'Client') }
  scope :agents, -> { joins(:role).where('roles.role = ?', 'Agent') }
  scope :brokers, -> { joins(:role).where('roles.role = ?', 'Broker') }


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

  def is_broker_of? (user)
    self.customers.include?(user)
  end

  def self.search(search)
    if search
      self.where('email LIKE ?', "#{search}")
    else
      # Do nothing
    end
  end

  def add_as_client(client, broker)
    broker.clients << Client.create(:user_id => broker.id, :client_id => @client.id )
  end

  def is_current_user?(user)
    self == user
  end

  private
    # Sets default role
    def build_contact
      @contact = Contact.create(:user_id => self.id, :fname => "Firstname", :lname => 'Lastname' );
      self.update_attributes(:contact_id => @contact.id)
    end
end
