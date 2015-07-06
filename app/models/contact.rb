class Contact < ActiveRecord::Base
  belongs_to :user
  belongs_to :role

  validates :fname, presence: true
  validates :lname, presence: true

  def full_name
  	([fname, lname] - ['']).compact.join(' ') 
  end
end
