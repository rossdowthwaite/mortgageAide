class Contact < ActiveRecord::Base
  belongs_to :user
  has_many :phone_numbers
  has_many :contact_addresses
  has_many :extra_details

  validates :fname, presence: true
  validates :lname, presence: true

  accepts_nested_attributes_for :phone_numbers
  accepts_nested_attributes_for :contact_addresses
  accepts_nested_attributes_for :extra_details

  def full_name
  	([fname, lname] - ['']).compact.join(' ') 
  end

  def self.search(search)
    if search
      self.where('lname LIKE ?', "#{search}")
    else
      # Do nothing
    end
  end

end
