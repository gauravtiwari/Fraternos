module ApplicationHelper
  def page_title(separator: ' | ')
    app_name = t('general.title')

    if content_for?(:page_title)
      [app_name, content_for(:page_title)].join(separator)
    else
      app_name
    end
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def link_to_delete(object, name = nil, options = {}, &block)
    options, name = name, capture(&block) if block_given? # rubocop:disable Style/ParallelAssignment

    data = { confirm: t('messages.delete_prompt') }

    link_to name, object, method: :delete, **options.deep_merge(data: data)
  end
end
