# We don't want to wrap the field so we just return the original tag
ActionView::Base.field_error_proc = proc do |html_tag, _instance|
  html_tag
end
