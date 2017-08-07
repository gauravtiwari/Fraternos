class CustomFormBuilder < ActionView::Helpers::FormBuilder
  FIELDS = %w[textarea input select].freeze

  delegate :capture, :safe_join, :raw, :content_tag, to: :@template

  def field_wrapper(attribute, options = {}, &block)
    errors  = @object.errors[attribute]
    classes = options.delete(:class) { '' }.split

    content = capture(&block)

    if errors.any?
      fragment = Nokogiri::HTML::DocumentFragment.parse(content)

      fragment
        .children
        .select { |element| FIELDS.include? element.node_name }
        .select { |element| %w[checkbox radio hidden].exclude? element[:type] }
        .each   { |field| field[:class] = "is-invalid #{field[:class]}".strip }

      content = safe_join([fragment.to_html.html_safe, *html_errors(errors)]) # rubocop:disable Rails/OutputSafety
    end

    content_tag :div, class: classes.join(' '), **options do
      content
    end
  end

  private

  def html_errors(errors)
    errors.map { |error| content_tag(:div, error, class: 'invalid-feedback') }
  end
end
