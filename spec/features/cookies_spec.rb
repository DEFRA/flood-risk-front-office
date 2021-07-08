require "rails_helper"

RSpec.feature "Cookies", type: :feature do
  let(:cookie_banner_div) { ".govuk-cookie-banner" }

  before { ENV["GOOGLE_ANALYTICS_ID"] = "GA_ID" }

  scenario "User accepts analytics cookies" do
    visit "/"
    expect(page).to have_link("View cookies", href: "/pages/cookies")

    click_on "Accept analytics cookies"
    expect(page).to have_text("You’ve accepted analytics cookies")

    within cookie_banner_div do
      expect(page).to have_link("change your cookie settings", href: "/pages/cookies")
      click_on "Hide this message"
    end

    expect(page).not_to have_css(cookie_banner_div)

    # Note that the google analytics tag is only parsed into a URL
    # if javascript is enabled.
    # Here we check that the GOOGLE_ANALYTICS_ID is rendered as expected
    expect(page.source).to have_text("'script','dataLayer','GA_ID'")
  end

  scenario "User rejects analytics cookies" do
    visit "/"
    click_on "Reject analytics cookies"
    expect(page).to have_text("You’ve rejected analytics cookies")

    click_on "Hide this message"

    expect(page.source).to have_text("'script','dataLayer','ga-disable-GA_ID'")
  end
end
