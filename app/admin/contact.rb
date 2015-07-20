ActiveAdmin.register Contact do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  permit_params :fname, :mname, :lname, :title, :dob, :user_id,
    phone_number_attributes: [:phone_number, :phone_type, :user_id, :primary],
    contact_address_attributes: [:address_one, :address_two, :town, :post_code, :primary, :user_id],
    extra_detail_attributes: [:branch, :user_id, :logo]

  index do 
    column :title
    column :fname
    column :lname
    column :role do |r|
      r.user.role.role
    end
    column :user
    actions
  end

 show do
    attributes_table do
      row :title
      row :fname
      row :lname
      row :dob
      row :user
      panel "Phone Numbers" do
        table_for contact.phone_numbers do
          column do |number|
            number.phone_type + ' ' + number.phone_number
          end
        end
      end
     panel "Addresses" do
      table_for contact.contact_addresses do
          column do |address|
            address.address_one + ', ' + address.address_two + ', ' + address.town + ', ' + address.post_code
          end
        end
      end
     if !contact.user.is_client?
        panel "Company Details" do
          table_for contact.extra_details do
            column do |detail|
              detail.branch
            end
          end
        end
      end
    end
    active_admin_comments
  end

 form do |f|
    f.inputs "Contact details" do
      
      f.input :title, :as => :select, :collection => [ 'Mr', 'Mrs', 'Miss']
      f.input :fname
      f.input :mname
      f.input :lname
      f.input :dob
      
      f.has_many :phone_numbers, new_record: 'Add number' do |b|
        b.input :phone_number
      end
      
      f.has_many :contact_addresses, new_record: 'Add Address' do |b|
        b.input :address_one
        b.input :address_two
        b.input :town
        b.input :post_code
        b.input :primary
      end
      
      if !f.object.user.nil?
        @user = f.object.user
        if !@user.is_client?
          f.has_many :extra_details, new_record: 'Company Detail' do |b|
            b.input :branch
            b.input :logo
          end
        end
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
