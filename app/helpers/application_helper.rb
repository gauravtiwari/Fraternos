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

  def plural_name_for(model)
    model.model_name.human(count: 0)
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
    [[t('general.daily'), 1], [t('general.weekly'), 7], [t('general.bi_weekly'), 14]]
  end

  def text_with_icon(icon_name, text)
    safe_join([icon(icon_name), text], ' ')
  end

  def on_fraternity?
    return true if request.path_info.match?(/fraternities/)
  end

  def formatted_amount(amount)
    return amount if amount.abs < 1_000
    number_to_human(amount, format: '%n%u', precision: 4, units: { thousand: 'k' })
  end
end
