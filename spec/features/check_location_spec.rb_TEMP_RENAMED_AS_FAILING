require "rails_helper"

RSpec.describe "Page check_location" do
  let(:page_object) { CheckLocationPageObject.new }

  context "Page Object" do
    it "has state helpers setup to check page text" do
      expect(CheckLocationPageObject.on_page_locale_key).to include "flood_risk_engine.enrollments.steps"
      expect(CheckLocationPageObject.on_page_text).to_not be_blank
    end

    it "has state helpers setup to confirm the state we are testing" do
      expect(page_object.expected_state).to eq :check_location
    end

    it "renders the correct starting point" do
      page_object.visit_page
      expect(page).to be_on_page_object page_object
    end

    scenario "PageObject supplied can visit, fill & submit page in one" do
      page_object.advance_page

      pending "story for next page"
      expect(page).to be_on_page_object page_object.next_page
    end
  end

  context "Navigation " do
    scenario "Check Location: Back link navigation - answers should be remembered" do
      page_object.advance_page

      pending "story for next page"
      # When I click on the back link - from NEXT page
      page_object.click_back_link

      # Now back to page - radios should be checked
      expect(page).to be_on_page_object page_object

      expect(find('#yes_option')).to be_checked
      expect(find('#no_option')).to_not be_checked
    end
  end

  context "Validation" do
    before(:each) do
      page_object.visit_page
    end

    scenario "When I first visit page no option is selected" do
      page_object.verify_nothing_selected
    end

    scenario "When I don't choose any option, asked to choose an options" do
      page_object.submit
      expect(page).to be_on_page_object page_object

      expect(page).to have_text t("errors.problems_to_fix")
      expect(page).to have_text t("errors.select_yes_or_no")

      expect(page).to have_error_anchors :location_check
    end

    scenario "When choose no redirected to static help page" do
      page_object.advance_via_radio_no_option

      path = FloodRiskEngine.config.redirection_url_on_location_unchecked

      expect(page).to have_current_path(path)
    end
  end
end
