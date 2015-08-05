class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # -------------------------------------------
  # Associations

  belongs_to :role

  has_many :notes
  has_many :contact_addresses, :dependent => :destroy
  has_many :phone_numbers, :dependent => :destroy

  has_one  :extra_detail, :dependent => :destroy
  has_one  :mail_notification_setting, :dependent => :destroy
  has_one  :global_setting, :dependent => :destroy
  has_one  :client_agent, :dependent => :destroy, :foreign_key => "client_id"
  has_one  :contact, :dependent => :destroy

  has_many :brokered_cases, foreign_key: "user_id", class_name: "ApplicationCase"
  has_many :application_cases

  has_many :applicants, :dependent => :destroy
  has_many :application_cases, :through => :applicants

  has_many :clients, :dependent => :destroy
  has_many :customers, :through => :clients, :source => 'customer'

  # -------------------------------------------
  # scopes

  scope :clients, -> { joins(:role).where('roles.role = ?', 'Client') }
  scope :agents, -> { joins(:role).where('roles.role = ?', 'Agent') }
  scope :brokers, -> { joins(:role).where('roles.role = ?', 'Broker') }

  # -------------------------------------------
  # Callbacks

  after_create :build_contact
  after_create :add_extra_details
  after_create :create_mail_setting
  after_create :add_global_settings

  after_destroy :remove_as_client

  
  # -------------------------------------------
  #  User functions

  # check if Broker
  def is_broker?
    self.role.role == "Broker";
  end

  def has_contact_info?
     !!self.contact
  end

  def get_agent(user)
    @agent = ClientAgent.agents(user).first
    if !@agent.nil?
      return @agent.agent.contact.full_name 
    end
  end

  def get_broker
    client = Client.where_client_is(self).first
    @broker = User.find(client.user_id)
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

  def has_opted_out_of? (notifcation_type)
    @mail_setting = self.mail_notification_setting
    if @mail_setting.all_emails == true
      return true
    else
      @mail_setting.public_send(notifcation_type) == true
    end
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

  def has_agent_and_is?(user)
    @agents = ClientAgent.agents(self)
    if @agents.any?
      @agent = ClientAgent.agents(self).first
      @agent.agent != user
    else
      return false
    end
  end

  private

    def remove_as_client
      @clients = Client.where_client_is(self)
      @clients.destroy_all
    end

    # Sets default role
    def build_contact
      @contact = Contact.create(:user_id => self.id, :fname => "Firstname", :lname => 'Lastname' );
      self.update_attributes(:contact_id => @contact.id)
    end

    def add_extra_details 
      if !self.is_client? 
        @extra = ExtraDetail.create(:user_id => self.id, :branch => '', :logo => '')
      end
    end

    def add_global_settings 
        GlobalSetting.create(:user_id => self.id, :color_one => '', :color_two => '', :color_three => '')
    end

    def create_mail_setting
        MailNotificationSetting.create(:user_id => self.id, :notes => true, :all_emails => true, :daily_digest => true, :status_update => true)
    end
end
