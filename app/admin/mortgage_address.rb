ActiveAdmin.register MortgageAddress do

  index do 
    column :address_one
    column :address_two
    column :town
    column :county
    column :pcode
    column :application_case
    actions
  end

end
