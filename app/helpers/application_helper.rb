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
end
