class LendersController < InheritedResources::Base

  private

    def lender_params
      params.require(:lender).permit(:name)
    end
end

