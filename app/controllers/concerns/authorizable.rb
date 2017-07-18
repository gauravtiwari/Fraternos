module Authorizable
  extend ActiveSupport::Concern

  included do # rubocop:disable Metrics/BlockLength
    include Pundit

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    def authorize(record, query = nil, policy_class: nil)
      query ||= params[:action].to_s + '?'

      @_pundit_policy_authorized = true

      policy = policy_class ? policy_class.new(pundit_user, record) : policy(record)

      unless policy.public_send(query)
        raise NotAuthorizedError, query: query, record: record, policy: policy
      end

      record
    end

    def policy_scope(scope, policy_scope_class: nil)
      @_pundit_policy_scoped = true
      policy_scope_class ? policy_scope_class.new(pundit_user, scope).resolve : pundit_policy_scope(scope)
    end

    def permitted_attributes(record, action = params[:action])
      param_key = PolicyFinder.new(record).param_key
      policy = policy(record)
      method_name =
        if policy.respond_to?("permitted_attributes_for_#{action}")
          "permitted_attributes_for_#{action}"
        else
          'permitted_attributes'
        end
      params.fetch(param_key, {}).permit(policy.public_send(method_name))
    end

    def user_not_authorized
      redirect_to(request.referer || sign_in_path, alert: t('errors.unauthorized'))
    end
  end
end
