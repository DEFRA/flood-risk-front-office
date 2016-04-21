module ApplicationHelper

  # rubocop:disable Style/AccessorMethodName
  def set_page_title(title)
    return unless title.present?

    stripped_title = title.gsub(/’/, %('))

    if content_for? :page_title
      content_for :page_title, " | #{stripped_title}"
    else
      content_for :page_title, "GOV.UK | #{stripped_title}"
    end

    title
  end
end
