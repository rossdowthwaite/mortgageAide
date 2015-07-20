ActiveAdmin.register ApplicationCase do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :valuation, :product, :expiry, :mortgage, :term, :repayment, :status, :lender_id, :app_type, :user_id,
    mortgage_address_attributes: [:address_one, :address_two, :town, :county, :pcode],
    note_attributes: [:note, :user_id, :application_case_id],
    case_requirements_attributes: [:application_case_id, :requirement_id, :status, :date_requested, :free_requirement],
    applicants_attributes: [:application_case_id, :user_id]

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
          column do |applicant|
            applicant.user.contact.full_name
          end
        end
      end
      panel "Requirements" do
        table_for application_case.case_requirements do
          column do |req|
            if !req.requirement.nil?
              req.requirement.requirment
            else
              req.free_requirement
            end
          end
          column do |req|
            req.date_requested
          end
          column do |req|
            req.status
          end
        end
      end
      panel "Notes" do
        table_for application_case.notes do
          column do |note|
            note.note
          end
          column do |note|
            note.user.contact.full_name
          end
          column do |note|
            note.created_at
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

      f.inputs 'Mortgage Address', :for => [:mortgage_address, f.object.mortgage_address || MortgageAddress.new] do |address|
        address.input :address_one
        address.input :address_two
        address.input :town
        address.input :county
        address.input :pcode
      end

      if f.object.applicants.who_are_agents.count == 0 

        f.has_many :applicants, heading: 'Agent', new_record: 'Add Agent' do |b|
          if !b.object.user.nil?
            @user = b.object.user
            if @user.is_agent?
               b.input :user, :as => :select, :collection =>  User.agents.map{|l| [l.contact.full_name, l.id]}, label: 'Name'
            end
          else
            b.input :user, :as => :select, :collection =>  User.agents.map{|l| [l.contact.full_name, l.id]}, label: 'Name'
          end
        end

      else

        f.has_many :applicants, heading: 'Agent', new_record: false do |b|
          if !b.object.user.nil?
            @user = b.object.user
            if @user.is_agent?
               b.input :user, :as => :select, :collection =>  User.agents.map{|l| [l.contact.full_name, l.id]}, label: 'Name'
            end
          else
            b.input :user, :as => :select, :collection =>  User.agents.map{|l| [l.contact.full_name, l.id]}, label: 'Name'
          end
        end

      end

      f.has_many :application_statuses, new_record: false do |b|
          b.input :status, :as => :select, :collection =>  Status.all.map{|l| [l.status, l.id]}
      end

      f.has_many :case_requirements, allow_destroy: true, new_record: false do |b|
          if !b.object.requirement.nil?
            b.input :requirement, :as => :select, :collection =>  Requirement.all.map{|l| [l.requirment, l.id]}
          else
            b.input :free_requirement, :as => :string 
          end
      end

      f.has_many :notes, allow_destroy: true, new_record: 'Add Note' do |b|
        b.input :note
      end

    end
    f.actions
  end

  controller do 
    def permitted_params 
      params.permit! 
    end 
  end

end
