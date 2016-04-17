module ApplicationHelper
  include DigitalServicesCore::ApplicationHelper

  # helper to return the default location of partials for a particular state
  def enrollment_partial_location(state)
    "flood_risk_engine/enrollments/steps/#{state}"
  end

  def set_page_title(title)
    return unless title.present?

    stripped_title = title.gsub(/’/, %{'})

    if content_for? :page_title
      content_for :page_title, " | #{stripped_title}"
    else
      content_for :page_title, "GOV.UK | #{stripped_title}"
    end

    title
  end

  def submit_button_text(enrollment)
    t("global.continue")
  end

end
