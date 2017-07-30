ActionView::Base.default_form_builder = CustomFormBuilder

module ApplicationHelper
  def page_title(separator: ' | ')
    app_name = t('general.title')

    if content_for?(:page_title)
      [app_name, content_for(:page_title)].join(separator)
    else
      app_name
    end
  end

  def flash_class_for(flash_type)
    css_class = {
      alert: 'warning', error: 'danger', notice: 'info', success: 'success'
    }.fetch(flash_type.to_sym, flash_type)

    "alert-#{css_class}"
  end

  def plural_name_for(model)
    model.model_name.human(count: 0)
  end

  def alert_tag(message, options = {}, html_options = {})
    type = options.fetch(:type, :success)
    dismissible = options.fetch(:dismissible, true)

    alert_classes = %w[alert fade show]
    alert_classes.push(flash_class_for(type))
    alert_classes.push('alert-dismissible') if dismissible

    alert_options =
      html_options.merge(
        class: [html_options.fetch(:class, ''), *alert_classes].join(' '),
        role: 'alert'
      )

    content = Array(message)
    content.push(close_button(data: { dismiss: :alert })) if dismissible

    content_tag(:div, safe_join(content), alert_options)
  end

  def close_button(options)
    options[:class] = options.fetch(:class, '') + ' close'

    content_tag(:button, raw('&times'), options) # rubocop:disable Rails/OutputSafety
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

  def class_string(*args)
    classes_hash = args.last.is_a?(Hash) ? args.pop : {}
    classes = classes_hash.map do |css_class, condition|
      if css_class.is_a?(Array)
        condition ? css_class.first : css_class.last
      elsif condition
        css_class
      end
    end

    (args + classes.compact).join(' ').strip
  end

  def frequency_options
    [['daily', 1], ['weekly', 7], ['bi weekly', 14]]
  end

  def organizer_options
    [1, 2, 3, 4, 5].map { |n| [n, n] }
  end
end
