ActiveAdmin.register ApplicationCase do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :valuation, :product, :expiry, :mortgage, :term, :repayment, :status, :lender_id, :app_type, :user_id,
    mortgage_address_attributes: [:address_one, :address_two, :town, :county, :pcode]

  # preserve_default_filters!
  filter :broker, :collection => proc {(User.brokers).map{|c| [c.contact.full_name, c.id]}}
  filter :agent, :collection => proc {(User.agents).map{|c| [c.contact.full_name, c.id]}}
  filter :users, :collection => proc {(User.all).map{|c| [c.contact.full_name, c.id]}}
  filter :lender, :collection => proc {(Lender.all).map{|c| [c.name, c.id]}}
  filter :statuses, :collection => proc {(Status.all).map{|c| [c.status, c.id]}} 
  filter :active, :as => :select

  show do
    attributes_table do
      row :app_type
      row :product
      row :broker
      row :mortgage_address 
      row :valuation  do |c|
        number_to_currency_gbp(c.valuation)
      end
      row :mortgage do |c|
        number_to_currency_gbp(c.mortgage) 
      end
      panel "Applicants" do
        table_for application_case.applicants.who_are_clients do
          column do |applcant|
            applcant.user.contact.full_name
          end
        end
      end
      panel "Agent" do
        table_for application_case.applicants.who_are_agents do
          column do |applcant|
            applcant.user.contact.full_name
          end
        end
      end
      row :term 
      row :repayment
      row :status do |c|
        c.application_statuses.first.status.status if !c.application_statuses.empty?
      end
      row :lender, :sortable => :lender_id do |c|
        c.lender.name
      end
    end
  end

  index do 
    column :app_type
    column :product
    column :broker
    column :valuation  do |c|
      number_to_currency_gbp(c.valuation)
    end
    column :mortgage do |c|
      number_to_currency_gbp(c.mortgage) 
    end
    column :term
    column :repayment
    column :status do |c|
      c.application_statuses.first.status.status if !c.application_statuses.empty?
    end
    column :lender, :sortable => :lender_id do |c|
      c.lender.name
    end
    actions
  end

  form do |f|
    f.inputs 'Details' do
      f.input :valuation
      f.input :product
      f.input :expiry
      f.input :mortgage
      f.input :term
      f.input :repayment, :as => :select, :collection => [ 'Capital & Repayment', 'Interest Only', 'Split']
      f.input :lender_id, :as => :select, :collection =>  Lender.all.map{|l| [l.name, l.id]}
      f.input :app_type, :as => :select, :collection =>  [ 'Capital & Repayment', 'Interest Only', 'Split']
      f.has_many :application_statuses, new_record: 'Add status' do |b|
        b.input :status, :as => :select, :collection =>  Status.all.map{|l| [l.status, l.id]}
      end
    end
    f.actions
  end

end
