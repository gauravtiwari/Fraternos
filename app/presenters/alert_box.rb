class AlertBox < Presenter
  BASE_CLASSES = %w[alert fade show].freeze
  TYPE_TO_CONTEXT_MAP = {
    alert: 'warning', error: 'danger', notice: 'info', success: 'success'
  }.freeze

  def initialize(helpers, content, type = :success, options = {})
    super helpers
    @type = type.to_sym
    @content = content
    @options = options

    append_base_classes
  end

  def render
    content_tag :div, content, @options
  end

  protected

  def content
    @content
  end

  def contextual_class
    'alert-' + TYPE_TO_CONTEXT_MAP[@type]
  end

  def append_base_classes
    @options[:class] = Array(@options[:class]).push(*BASE_CLASSES, contextual_class)
  end
end
