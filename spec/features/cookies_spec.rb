require "rails_helper"

RSpec.feature "Cookies", type: :feature do
  let(:cookie_banner_div) { ".govuk-cookie-banner" }

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
  end

  scenario "User rejects analytics cookies" do
    visit "/"
    click_on "Reject analytics cookies"
    expect(page).to have_text("You’ve rejected analytics cookies")
  end
end
