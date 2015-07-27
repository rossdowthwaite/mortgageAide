ActiveAdmin.register Status do
  
  before_filter :skip_sidebar!, :only => :index

  index do 
    column :id
    column :status
    actions
  end

  controller do
    def permitted_params
      params.permit status: [:status]
    end
  end
end
