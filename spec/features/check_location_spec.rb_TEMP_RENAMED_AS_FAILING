require "rails_helper"

RSpec.describe "Page check_location" do
  let(:page_object) { CheckLocationPageObject.new }

  context "Page Object" do
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
    scenario "Check Location: Back link navigation - answers should be remembered", duff: true do
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

      expect(page).to have_text "You have 1 error"
      expect(page).to have_text I18n.t("errors.you_must_make_selection")

      expect(page).to have_error_anchors "base"
    end
  end
end
