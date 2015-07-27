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

  controller do
    def permitted_params
      params.permit requirement: [:requirment]
    end
  end
end
