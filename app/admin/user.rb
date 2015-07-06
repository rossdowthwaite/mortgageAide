ActiveAdmin.register User do

  index do 
    column :id
    column :email
    column :role
    column :contact
    actions
  end

 form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role_id
    end
    f.actions
  end

  # This is related to Rails 4 and the changes it introduced in handling strong parameters. Here we replace :email with :username.
  controller do
    def permitted_params
      params.permit user: [:email, :password, :password_confirmation, :role_id]
    end

    def update
      if params[:user][:password].blank?
        params[:user].delete("password")
        params[:user].delete("password_confirmation")
      end
      super
    end
    
  end
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


end
