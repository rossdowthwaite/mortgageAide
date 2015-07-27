class ExtraDetail < ActiveRecord::Base
  belongs_to :user

  # Paperclip stuff
  has_attached_file :logo, styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates_attachment_content_type :logo, :content_type => ['image/jpeg', 'image/jpg', 'image/png']
end
 