class AddPaperclipToExtraDetails < ActiveRecord::Migration
  def change
  	add_attachment :extra_details, :logo 
  end
end
