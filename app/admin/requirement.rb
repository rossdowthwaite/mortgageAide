ActiveAdmin.register Requirement do
  before_filter :skip_sidebar!, :only => :index

  index do 
    column :requirment
    actions
  end

  form do |f|
    f.inputs "Requirements" do
      f.input :requirment
    end
    f.actions
  end

  show do
    attributes_table do
      row :requirment
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

    # This is related to Rails 4 and the changes it introduced in handling strong parameters. Here we replace :email with :username.
  controller do
    def permitted_params
      params.permit requirement: [:requirment]
    end
  end
end
