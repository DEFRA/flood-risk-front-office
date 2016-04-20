module ApplicationHelper

  def page_title(title)
    return unless title.present?

    stripped_title = title.gsub(/’/, %('))

    if content_for? :page_title
      content_for :page_title, " | #{stripped_title}"
    else
      content_for :page_title, "GOV.UK | #{stripped_title}"
    end

    title
  end

  def submit_button_text(_enrollment)
    t("global.continue")
  end

end
