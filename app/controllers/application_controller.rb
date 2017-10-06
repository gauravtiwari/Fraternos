class ApplicationController < ActionController::Base
  include Authorizable

  protect_from_forgery with: :exception

  layout :layout_by_resource

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :load_fraternity, if: :user_signed_in?

  def load_fraternity
    @fraternity = find_fraternity || NullFraternity.new
  end

  def current_fraternity
    @fraternity
  end

  helper_method :current_fraternity

  def current_fraternity?
    @fraternity.present?
  end

  def find_fraternity
    fraternity_scope.find_by(id: fraternity_id) if fraternity_id.present?
  end

  def fraternity_scope
    current_user.fraternities
  end

  def fraternity_id
    fraternities_controller? ? params[:id] : params[:fraternity_id]
  end

  def fraternities_controller?
    controller_name == 'fraternities'
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name])
  end

  def notification_for(action, subject)
    t("notifications.#{action}", subject: subject.model_name.human)
  end

  private

  def layout_by_resource
    devise_controller? ? 'visitor' : 'application'
  end
end
