class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters, if: :devise_controller?

  def number_to_currency_gbp (number)
    number_to_currency(number, { :unit => "&pound;"})
  end

  protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.for(:sign_up) << :role_id
  	devise_parameter_sanitizer.for(:account_update) << :contact_id
  end

end
