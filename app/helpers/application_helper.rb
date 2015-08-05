module ApplicationHelper

  def number_to_currency_gbp (number)
    number_to_currency(number, { :unit => "£", precision: 0})
  end

  def can_edit? (model)
  	current_user == model.user
  end

  def branch_settings(user)
  	if user_signed_in?
  		if user.is_client?
	  		@broker = user.get_broker
	  		@extra = @broker.extra_detail
	  	else 
	  		@extra = user.extra_detail
	  	end
  	end
  end

  def global_settings(user)
  	if user_signed_in?
	  	if user.is_client?
	  		@broker = user.get_broker
	  		@global_settings = @broker.global_setting
	  	else 
	  		@global_settings = user.global_setting
	  	end
	 end
  end

  def is_brokered_by?(application_case)
  	current_user.is_broker? && application_case.brokered_by?(current_user)
  end	
end
