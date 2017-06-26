class CustomFormBuilder < ActionView::Helpers::FormBuilder
  FIELDS = %w[textarea input select].freeze

  delegate :capture, :safe_join, :raw, :content_tag, to: :@template

  def field_wrapper(attribute, options = {}, &block)
    errors  = @object.errors[attribute]
    classes = options.delete(:class) { '' }.split

    content = capture(&block)

    if errors.any?
      classes.push('has-danger')

      elements = Nokogiri::HTML::DocumentFragment.parse(content)

      elements
        .select { |element| FIELDS.include? element.node_name }
        .select { |element| %w[checkbox radio hidden].exclude? element[:type] }
        .each   { |field| field[:class] = "form-control-danger #{field[:class]}".strip }

      content = safe_join([elements.to_html.html_safe, *html_errors(errors)]) # rubocop:disable Rails/OutputSafety
    end

    content_tag :div, class: classes.join(' '), **options do
      content
    end
  end

  private

  def html_errors(errors)
    errors.map { |error| content_tag(:div, error, class: 'form-control-feedback') }
  end
end
