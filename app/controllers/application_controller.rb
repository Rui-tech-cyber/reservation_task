class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar_filename, :bio])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar_filename, :bio])
  end

  def set_locale
    I18n.locale = :ja
  end
end