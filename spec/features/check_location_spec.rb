=begin - Page removed
require "rails_helper"

RSpec.describe "Page check_location" do
  let(:page_object) { CheckLocationPageObject.new }

  context "Page Object" do
    it "has state helpers setup to check page text" do
      expect(
        CheckLocationPageObject.on_page_locale_key
      ).to eq ".flood_risk_engine.enrollments.steps.check_location.heading"

      expect(CheckLocationPageObject.on_page_text).to_not be_blank
    end

    it "has state helpers setup to confirm the state we are testing" do
      expect(page_object.expected_state).to eq :check_location
    end

    it "renders the correct starting point" do
      page_object.visit_page
      expect(page).to be_on_page_object page_object
    end
  end

  context "Navigation " do
    scenario "When I use Back link navigation, then I should return to this page" do
      page_object.advance_page

      # When I click on the back link - from NEXT page
      page_object.click_back_link

      # Then I should return to this page
      expect(FloodRiskEngine::Enrollment.last.step).to eq page_object.expected_state.to_s
      expect(page).to be_on_page_object page_object

      page_object.expect_yes_to_not_be_checked
      page_object.expect_no_to_not_be_checked
    end
  end

  context "Validation" do
    before(:each) do
      page_object.visit_page
    end

    scenario "When I first visit page, then  no option is selected" do
      page_object.verify_nothing_selected
    end

    scenario "When I don't choose any option, Then I am asked to choose an options" do
      page_object.submit
      expect(page).to be_on_page_object page_object

      expect(page).to have_text t("errors.problems_to_fix")
      expect(page).to have_text t("errors.select_yes_or_no")

      expect(page).to have_error_anchors :location_check
    end

    scenario "When choose YES, Then I am sent to the next page in the journey" do
      page_object.visit_page

      next_step = FloodRiskEngine::Enrollment.last.next_step

      page_object.advance_via_radio_check_location_location_check_yes

      expect(page).to_not be_on_page_object page_object

      expect(FloodRiskEngine::Enrollment.last.step).to eq next_step
    end

    scenario "When choose no, Then I am redirected to static help page" do
      page_object.advance_via_radio_check_location_location_check_no

      path = FloodRiskEngine.config.redirection_url_on_location_unchecked

      expect(page).to have_current_path(path)
    end

    context "When I use the Back Button", js: true do
      context "After I choose Nothing, And I subsequently choose No" do
        scenario "Then I should return to this page" do
          page_object.submit
          expect(page).to be_on_page_object page_object
          expect(page).to have_error_anchors :location_check

          page_object.advance_via_radio_check_location_location_check_no

          expect(page).to_not be_on_page_object page_object

          path = FloodRiskEngine.config.redirection_url_on_location_unchecked
          expect(page).to have_current_path(path)

          # When I click on the back BUTTON - from NEXT page
          page.driver.go_back

          # Then I should return to this page
          expect(page).to be_on_page_object page_object
        end
      end
    end
  end
end
=end # Page removed
