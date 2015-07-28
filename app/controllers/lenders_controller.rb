class LendersController < InheritedResources::Base

  private

    def lender_params
      params.require(:lender).permit(:name, :admin_phone, :sales_phone, :hq_address, :email)
    end
end

