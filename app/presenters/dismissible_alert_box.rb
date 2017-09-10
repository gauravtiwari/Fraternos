class DismissibleAlertBox < AlertBox
  BASE_CLASSES = %w[alert fade show alert-dismissible].freeze

  protected

  def content
    safe_join([@content, close_button])
  end

  def close_button
    content_tag(:button, raw('&times'), class: 'close', data: { dismiss: :alert })
  end
end
