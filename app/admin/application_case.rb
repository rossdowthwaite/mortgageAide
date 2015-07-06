ActiveAdmin.register ApplicationCase do
  config.filters = false

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :valuation, :product, :expiry, :mortgage, :term, :repayment, :status, :lender_id, :app_type, :user_id,
    mortgage_address_attributes: [:address_one, :address_two, :town, :county, :pcode]


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
    
      f.inputs do
        f.has_many :mortgage_address do |a|
          a.input :address_one
          a.input :address_two
          a.input :town
          a.input :county
          a.input :pcode
        end
      end
      f.actions
    end
  end

end
