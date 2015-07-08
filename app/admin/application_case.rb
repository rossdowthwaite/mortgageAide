ActiveAdmin.register ApplicationCase do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :valuation, :product, :expiry, :mortgage, :term, :repayment, :status, :lender_id, :app_type, :user_id,
    mortgage_address_attributes: [:address_one, :address_two, :town, :county, :pcode]

  index do 
    column :valuation  do |c|
      number_to_currency_gbp(c.valuation)
    end
    column :product
    column :expiry
    column :mortgage do |c|
      number_to_currency_gbp(c.mortgage) 
    end
    column :term
    column :repayment
    column :status
    column :lender, :sortable => :lender_id do |c|
      c.lender.name
    end
    column :app_type
    actions
  end

  form do |f|
    f.inputs 'Details' do
      f.input :valuation
      f.input :product
      f.input :expiry
      f.input :mortgage
      f.input :term
      f.input :repayment
      f.input :status
      f.input :lender_id
      f.input :app_type
    end
  end

end
