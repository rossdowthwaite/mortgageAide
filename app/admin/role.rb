ActiveAdmin.register Role do

  before_filter :skip_sidebar!, :only => :index

  index do 
    column :role
    actions
  end

  controller do
    def permitted_params
      params.permit role: [:role]
    end
  end

end
