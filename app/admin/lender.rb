ActiveAdmin.register Lender do

  controller do
    def permitted_params
      params.permit lender: [:name]
    end
  end

end
