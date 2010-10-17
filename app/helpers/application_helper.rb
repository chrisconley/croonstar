module ApplicationHelper

  def error_messages(errors)
    content_tag :span, errors.join(' and '), :class => 'error'
  end
end
