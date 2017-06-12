class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout :layout_by_resource

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def notification_for(action, subject)
    t("notifications.#{action}", subject: subject.model_name.human)
  end

  private

  def layout_by_resource
    devise_controller? ? 'visitor' : 'application'
  end
end
