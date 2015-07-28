ActiveAdmin.register Lender do

  index do 
    column :name
    column :admin_phone
    column :sales_phone
    column :email
    actions
  end

  show do
    attributes_table do
      row :name
      row :admin_phone
      row :sales_phone
      row :email
      row :hq_address
    end
  end

  controller do
    def permitted_params
      params.permit lender: [:name, :admin_phone, :sales_phone, :hq_address, :email]
    end
  end

end
