module ApplicationHelper

  def number_to_currency_gbp (number)
    number_to_currency(number, { :unit => "£"})
  end

  def can_edit? (model)
  	current_user == model.user
  end

  def is_brokered_by?(application_case)
  	current_user.is_broker? && application_case.brokered_by?(current_user)
  end	
end
