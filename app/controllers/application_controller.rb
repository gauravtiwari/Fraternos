class ApplicationController < ActionController::Base
  include Authorizable

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  layout :layout_by_resource

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Override authorize method to allow overriding policy_class
  def authorize(record, query = nil, policy_class: nil)
    query ||= params[:action].to_s + '?'

    @_pundit_policy_authorized = true

    policy = policy_class ? policy_class.new(pundit_user, record) : policy(record)

    unless policy.public_send(query)
      raise NotAuthorizedError, query: query, record: record, policy: policy
    end

    record
  end

  # Override policy_scope method to allow overriding policy_scope_class
  def policy_scope(scope, policy_scope_class: nil)
    @_pundit_policy_scoped = true
    policy_scope_class ? policy_scope_class.new(pundit_user, scope).resolve : pundit_policy_scope(scope)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name])
  end

  def notification_for(action, subject)
    t("notifications.#{action}", subject: subject.model_name.human)
  end

  def user_not_authorized
    redirect_to(request.referer || authenticated_root_path, alert: t('errors.unauthorized'))
  end

  private

  def layout_by_resource
    devise_controller? ? 'visitor' : 'application'
  end
end
