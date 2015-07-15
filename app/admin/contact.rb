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

  index do 
    column :title
    column :fname
    column :lname
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
        table_for contact.user.phone_numbers do
          column do |number|
            number.phone_type + ' ' + number.phone_number
          end
        end
      end
     panel "Addresses" do
      table_for contact.user.contact_addresses do
          column do |address|
            address.address_one + ', ' + address.address_two + ', ' + address.town + ', ' + address.post_code
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
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit contact: [:fname, :mname, :lname, :title, :dob, :user_id]
    end
  end

end
